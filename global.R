# ============================================================
# global.R — Libraries, User Management, Shared Helpers
# Introduction to R — Powered by PRODATALYTICS INDIA PVT LTD.
# ============================================================

suppressPackageStartupMessages({
  library(shiny)
  library(bslib)
  library(ggplot2)
  library(dplyr)
  library(DT)
})

# ── File Paths ────────────────────────────────────────────────
USERS_FILE <- "data/users.rds"

# ── Password helper (local-use obfuscation) ───────────────────
.hash_pw <- function(x) {
  chars <- utf8ToInt(paste0(x, "pdl_salt_2024"))
  as.character(sum(chars * (seq_along(chars) + 7)) %% 999999937L)
}

# ── User Read/Write ───────────────────────────────────────────
read_users <- function() {
  if (file.exists(USERS_FILE)) readRDS(USERS_FILE) else list()
}

save_users <- function(users) {
  if (!dir.exists("data")) dir.create("data", recursive = TRUE)
  saveRDS(users, USERS_FILE)
}

# ── Register new user ─────────────────────────────────────────
register_user <- function(username, password, full_name, email) {
  users <- read_users()
  if (username %in% names(users)) return(list(ok=FALSE, msg="Username already taken."))
  if (nchar(trimws(username)) < 3) return(list(ok=FALSE, msg="Username must be at least 3 characters."))
  if (nchar(password) < 4) return(list(ok=FALSE, msg="Password must be at least 4 characters."))

  module_keys <- c("basics","datastructures","controlflow","datamanip","visualization")

  users[[username]] <- list(
    username    = username,
    password    = .hash_pw(password),
    full_name   = trimws(full_name),
    email       = trimws(email),
    created_at  = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
    modules_viewed = setNames(as.list(rep(FALSE, 5)), module_keys),
    quiz_scores    = setNames(as.list(rep(NA_real_, 5)), module_keys),
    quiz_attempts  = setNames(as.list(rep(0L, 5)),       module_keys),
    certificate_issued = FALSE,
    completion_date    = NA_character_
  )
  save_users(users)
  list(ok=TRUE, msg="Account created successfully!")
}

# ── Authenticate ──────────────────────────────────────────────
authenticate_user <- function(username, password) {
  users <- read_users()
  u <- users[[username]]
  if (is.null(u)) return(list(ok=FALSE, msg="Username not found."))
  if (u$password != .hash_pw(password)) return(list(ok=FALSE, msg="Incorrect password."))
  list(ok=TRUE, msg="Login successful!", user=u)
}

# ── Get/Update Progress ───────────────────────────────────────
get_user <- function(username) {
  users <- read_users()
  users[[username]]
}

mark_module_viewed <- function(username, module_key) {
  users <- read_users()
  if (is.null(users[[username]])) return(invisible(NULL))
  users[[username]]$modules_viewed[[module_key]] <- TRUE
  save_users(users)
}

save_quiz_score <- function(username, module_key, score_pct) {
  users <- read_users()
  if (is.null(users[[username]])) return(invisible(NULL))
  old_score <- users[[username]]$quiz_scores[[module_key]]
  # Only update if better or first attempt
  if (is.na(old_score) || score_pct > old_score) {
    users[[username]]$quiz_scores[[module_key]] <- score_pct
  }
  users[[username]]$quiz_attempts[[module_key]] <-
    users[[username]]$quiz_attempts[[module_key]] + 1L
  save_users(users)
}

check_certificate_eligibility <- function(username) {
  u <- get_user(username)
  if (is.null(u)) return(FALSE)
  scores <- unlist(u$quiz_scores)
  all(!is.na(scores)) && mean(scores, na.rm=TRUE) >= 80
}

issue_certificate <- function(username) {
  users <- read_users()
  if (is.null(users[[username]])) return(invisible(NULL))
  users[[username]]$certificate_issued <- TRUE
  users[[username]]$completion_date <- format(Sys.Date(), "%B %d, %Y")
  save_users(users)
}

get_progress_summary <- function(username) {
  u <- get_user(username)
  if (is.null(u)) return(NULL)
  module_keys   <- c("basics","datastructures","controlflow","datamanip","visualization")
  viewed_count  <- sum(unlist(u$modules_viewed), na.rm=TRUE)
  quiz_done     <- sum(!is.na(unlist(u$quiz_scores)))
  quiz_passed   <- sum(unlist(u$quiz_scores) >= 60, na.rm=TRUE)
  avg_score     <- if (quiz_done > 0) mean(unlist(u$quiz_scores), na.rm=TRUE) else 0
  list(
    viewed_count = viewed_count,
    quiz_done    = quiz_done,
    quiz_passed  = quiz_passed,
    avg_score    = round(avg_score, 1),
    pct_complete = round((quiz_passed / 5) * 100),
    eligible     = check_certificate_eligibility(username),
    modules      = u$modules_viewed,
    scores       = u$quiz_scores
  )
}

# ── Fixed safe_eval ───────────────────────────────────────────
safe_eval <- function(code_str) {
  tryCatch({
    env <- new.env(parent = globalenv())
    out <- capture.output(eval(parse(text = code_str), envir = env))
    if (length(out) == 0 || all(nchar(trimws(out)) == 0))
      "(No visible output — the code ran successfully)"
    else
      paste(out, collapse = "\n")
  },
  error   = function(e) paste0("❌ Error: ",   conditionMessage(e)),
  warning = function(w) paste0("⚠️  Warning: ", conditionMessage(w))
  )
}

# ── Parse a comma-separated numbers string ────────────────────
parse_nums <- function(txt) {
  parts <- unlist(strsplit(trimws(txt), "[,[:space:]]+"))
  parts <- parts[nchar(parts) > 0]
  vals  <- suppressWarnings(as.numeric(parts))
  if (any(is.na(vals))) NULL else vals
}

# ── Reusable UI helpers ───────────────────────────────────────
code_block <- function(...) tags$pre(class = "code-block", ...)

callout_info    <- function(icon, text) div(class="callout callout-info",    div(class="callout-icon",icon), tags$p(HTML(text)))
callout_tip     <- function(icon, text) div(class="callout callout-tip",     div(class="callout-icon",icon), tags$p(HTML(text)))
callout_warning <- function(icon, text) div(class="callout callout-warning", div(class="callout-icon",icon), tags$p(HTML(text)))

# ── Progress badge helper ─────────────────────────────────────
module_status_badge <- function(score) {
  if (is.na(score)) {
    tags$span(style="background:#FEF3C7;color:#D97706;border-radius:99px;padding:.2rem .6rem;font-size:.75rem;font-weight:600;", "Pending")
  } else if (score >= 80) {
    tags$span(style="background:#D1FAE5;color:#065F46;border-radius:99px;padding:.2rem .6rem;font-size:.75rem;font-weight:600;", paste0("✅ ", score, "%"))
  } else if (score >= 60) {
    tags$span(style="background:#DBEAFE;color:#1E40AF;border-radius:99px;padding:.2rem .6rem;font-size:.75rem;font-weight:600;", paste0("✔ ", score, "%"))
  } else {
    tags$span(style="background:#FEE2E2;color:#991B1B;border-radius:99px;padding:.2rem .6rem;font-size:.75rem;font-weight:600;", paste0("❌ ", score, "%"))
  }
}

# ── Source all modules ────────────────────────────────────────
source("modules/mod_login.R")
source("modules/mod_home.R")
source("modules/mod_basics.R")
source("modules/mod_datastructures.R")
source("modules/mod_controlflow.R")
source("modules/mod_datamanip.R")
source("modules/mod_visualization.R")
source("modules/mod_quiz.R")
source("modules/mod_certificate.R")
