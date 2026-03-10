# ============================================================
# app.R — Main Application with Login Gate
# Introduction to R — Powered by PRODATALYTICS INDIA PVT LTD.
# ============================================================

source("global.R")

# ── Shared theme ──────────────────────────────────────────────
app_theme <- bs_theme(
  version    = 5,
  bootswatch = "flatly",
  primary    = "#1A3E6E",
  "navbar-bg" = "#1A3E6E",
  base_font  = font_google("Inter"),
  code_font  = font_google("JetBrains Mono")
)

# ── Main navbar UI (shown after login) ────────────────────────
main_app_ui <- function() {
  page_navbar(
    id     = "main_navbar",
    title  = tags$div(
      style = "display:flex; align-items:center; gap:10px;",
      tags$div(
        style = "background:#fff; border-radius:6px; padding:3px 8px; line-height:1;",
        tags$span(style="color:#1A3E6E; font-weight:800; font-size:.9rem; letter-spacing:-.3px;", "PRO"),
        tags$span(style="color:#E8892A; font-weight:800; font-size:.9rem;", "DATA"),
        tags$span(style="color:#1A3E6E; font-weight:800; font-size:.9rem;", "LYTICS")
      ),
      tags$span(style="color:rgba(255,255,255,.7); font-size:.8rem;", "│"),
      tags$span(style="font-weight:600; font-size:.92rem;", "Introduction to R")
    ),
    theme        = app_theme,
    window_title = "Intro to R — ProDatalytics India",
    header = tags$head(
      tags$link(rel = "stylesheet", href = "styles.css"),
      tags$meta(name="viewport", content="width=device-width, initial-scale=1")
    ),

    nav_panel(title = tags$span("🏠 Home"),              value = "home",           mod_home_ui("home")),
    nav_panel(title = tags$span("📘 R Basics"),          value = "basics",         mod_basics_ui("basics")),
    nav_panel(title = tags$span("🗂 Data Structures"),   value = "datastructures", mod_datastructures_ui("datastructures")),
    nav_panel(title = tags$span("🔄 Control Flow"),      value = "controlflow",    mod_controlflow_ui("controlflow")),
    nav_panel(title = tags$span("🔧 Data Manipulation"), value = "datamanip",      mod_datamanip_ui("datamanip")),
    nav_panel(title = tags$span("📊 Visualization"),     value = "visualization",  mod_visualization_ui("visualization")),
    nav_panel(title = tags$span("✅ Quizzes"),            value = "quiz",           mod_quiz_ui("quiz")),
    nav_panel(title = tags$span("🏆 Certificate"),       value = "certificate",    mod_certificate_ui("certificate")),

    nav_spacer(),

    nav_item(uiOutput("nav_user_badge")),
    nav_item(
      actionButton("btn_logout", "⏏ Logout",
        style = "background:rgba(255,255,255,.15); color:#fff; border:1px solid rgba(255,255,255,.3);
                 border-radius:8px; padding:.35rem .85rem; font-size:.82rem; font-weight:600; cursor:pointer;",
        class = "")
    )
  )
}

# ── Root UI ───────────────────────────────────────────────────
ui <- fluidPage(
  theme = app_theme,
  tags$head(
    tags$link(rel = "stylesheet", href = "styles.css"),
    tags$meta(name="viewport", content="width=device-width, initial-scale=1")
  ),
  uiOutput("root_ui")
)

# ── Server ───────────────────────────────────────────────────
server <- function(input, output, session) {

  # ── Session state ──────────────────────────────────────────
  rv <- reactiveValues(
    logged_in = FALSE,
    username  = NULL,
    user      = NULL
  )

  # ── Root UI: login or main app ─────────────────────────────
  output$root_ui <- renderUI({
    if (!rv$logged_in) {
      mod_login_ui("login_panel")
    } else {
      main_app_ui()
    }
  })

  # ── User badge in navbar ───────────────────────────────────
  output$nav_user_badge <- renderUI({
    req(rv$logged_in)
    u <- rv$user
    p <- get_progress_summary(rv$username)
    div(style = "display:flex; align-items:center; gap:8px; padding:.3rem .5rem;",
      div(style = "background:rgba(255,255,255,.2); border-radius:50%; width:30px; height:30px;
                   display:flex; align-items:center; justify-content:center; font-weight:700; font-size:.85rem;",
        toupper(substr(u$full_name, 1, 1))),
      div(
        div(style="color:#fff; font-size:.82rem; font-weight:600; line-height:1.2;",
          strsplit(u$full_name, " ")[[1]][1]),
        div(style="color:rgba(255,255,255,.7); font-size:.7rem;",
          paste0(p$pct_complete, "% Complete"))
      )
    )
  })

  # ── Login server ───────────────────────────────────────────
  mod_login_server("login_panel", rv)

  # ── Logout ────────────────────────────────────────────────
  observeEvent(input$btn_logout, {
    rv$logged_in <- FALSE
    rv$username  <- NULL
    rv$user      <- NULL
  })

  # ── Track module views ─────────────────────────────────────
  module_view_map <- list(
    basics         = "basics",
    datastructures = "datastructures",
    controlflow    = "controlflow",
    datamanip      = "datamanip",
    visualization  = "visualization"
  )

  observe({
    req(rv$logged_in)
    tab <- input$main_navbar
    req(!is.null(tab), nchar(tab) > 0)
    key <- module_view_map[[tab]]
    if (!is.null(key)) {
      u <- get_user(rv$username)
      if (!isTRUE(u$modules_viewed[[key]])) {
        mark_module_viewed(rv$username, key)
        rv$user <- get_user(rv$username)
      }
    }
  })

  # ── Module servers ─────────────────────────────────────────
  mod_home_server("home", rv)
  mod_basics_server("basics")
  mod_datastructures_server("datastructures")
  mod_controlflow_server("controlflow")
  mod_datamanip_server("datamanip")
  mod_visualization_server("visualization")
  mod_quiz_server("quiz", rv)
  mod_certificate_server("certificate", rv)
}

shinyApp(ui = ui, server = server)
