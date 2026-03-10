# ============================================================
# modules/mod_login.R — Login & Registration Module
# ============================================================

mod_login_ui <- function(id) {
  ns <- NS(id)

  div(
    style = "min-height:100vh; background:linear-gradient(135deg,#0f2142 0%,#1A3E6E 50%,#0f2142 100%);
             display:flex; align-items:center; justify-content:center; padding:1rem;",

    div(style = "width:100%; max-width:480px;",

      # ── Branding ──────────────────────────────────────────
      div(style = "text-align:center; margin-bottom:1.8rem;",
        div(style = "display:inline-block; background:rgba(255,255,255,.1);
                     border-radius:16px; padding:1rem 1.8rem; margin-bottom:1rem;",
          div(style = "font-size:1.8rem; font-weight:900; letter-spacing:-1px; line-height:1;",
            tags$span(style="color:#fff;",   "PRO"),
            tags$span(style="color:#E8892A;","DATA"),
            tags$span(style="color:#fff;",   "LYTICS")
          ),
          div(style="color:rgba(255,255,255,.6); font-size:.72rem; letter-spacing:2px;
                     text-transform:uppercase; margin-top:.25rem;",
            "INDIA PVT LTD.")
        ),
        tags$h2(style="color:#fff; font-weight:700; margin:0 0 .3rem; font-size:1.4rem;",
          "Introduction to R for Students"),
        tags$p(style="color:rgba(255,255,255,.55); font-size:.85rem; margin:0;",
          "Sign in or create an account to start learning")
      ),

      # ── Card ──────────────────────────────────────────────
      div(style = "background:#fff; border-radius:16px; overflow:hidden;
                   box-shadow:0 20px 60px rgba(0,0,0,.35);",

        # Dynamic tab buttons (rendered by server so active state updates)
        uiOutput(ns("tab_buttons")),

        # Dynamic form content
        div(style = "padding:1.8rem;",
          uiOutput(ns("form_area"))
        )
      ),

      # Footer
      div(style="text-align:center; margin-top:1.2rem;",
        tags$p(style="color:rgba(255,255,255,.4); font-size:.75rem; margin:0;",
          "Course powered by PRODATALYTICS INDIA PVT LTD. | \u00a9 2024")
      )
    )
  )
}

# ── Server ────────────────────────────────────────────────────
mod_login_server <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ── Track which tab is active ─────────────────────────────
    active_tab <- reactiveVal("login")   # "login" or "register"

    observeEvent(input$go_login,    { active_tab("login") })
    observeEvent(input$go_register, { active_tab("register") })

    # ── Ensure demo accounts exist ────────────────────────────
    observe({
      users <- read_users()
      if (!"demo" %in% names(users))
        register_user("demo",  "demo123",  "Demo Student", "demo@example.com")
      if (!"user" %in% names(users))
        register_user("user",  "passpwrd", "Sample User",  "user@example.com")
    })

    # ── Dynamic tab buttons ───────────────────────────────────
    output$tab_buttons <- renderUI({
      tab <- active_tab()

      btn_style <- function(is_active) {
        base <- "flex:1; border:none; padding:.85rem; font-size:.9rem; font-weight:600;
                 cursor:pointer; transition:all .2s; background:transparent;"
        if (is_active)
          paste0(base, "color:#1A3E6E; border-bottom:3px solid #1A3E6E; background:#fff;")
        else
          paste0(base, "color:#94A3B8; border-bottom:3px solid transparent; background:#F8FAFC;")
      }

      div(style = "display:flex; border-bottom:1px solid #E2E8F0;",
        actionButton(ns("go_login"),
          "Sign In",
          style = btn_style(tab == "login"),
          class = ""
        ),
        actionButton(ns("go_register"),
          "Create Account",
          style = btn_style(tab == "register"),
          class = ""
        )
      )
    })

    # ── Dynamic form area ─────────────────────────────────────
    output$form_area <- renderUI({
      if (active_tab() == "login") {
        tagList(
          div(class="form-group", style="margin-bottom:1rem;",
            tags$label(style="font-weight:600; font-size:.88rem; margin-bottom:.3rem; display:block;",
              "Username"),
            textInput(ns("l_user"), NULL, placeholder="Enter your username") |>
              tagAppendAttributes(style="border-radius:8px; width:100%;")
          ),
          div(class="form-group", style="margin-bottom:1.2rem;",
            tags$label(style="font-weight:600; font-size:.88rem; margin-bottom:.3rem; display:block;",
              "Password"),
            passwordInput(ns("l_pass"), NULL, placeholder="Enter your password") |>
              tagAppendAttributes(style="border-radius:8px; width:100%;")
          ),
          uiOutput(ns("login_msg")),
          actionButton(ns("btn_login"), "Sign In \u2192",
            style="width:100%; background:#1A3E6E; color:#fff; border:none; border-radius:10px;
                   padding:.75rem; font-weight:700; font-size:.95rem; cursor:pointer; margin-top:.3rem;"),
          div(style="margin-top:1.2rem; padding:.9rem; background:#EFF6FF; border-radius:10px;",
            tags$p(style="margin:0 0 .3rem; font-size:.82rem; font-weight:700; color:#1A3E6E;",
              "\U0001f511 Demo Accounts"),
            tags$p(style="margin:0 0 .2rem; font-size:.8rem; color:#374151;",
              tags$code("username: demo"), "  \u2022  ", tags$code("password: demo123")),
            tags$p(style="margin:0; font-size:.8rem; color:#374151;",
              tags$code("username: user"), "  \u2022  ", tags$code("password: passpwrd"))
          )
        )
      } else {
        tagList(
          fluidRow(
            column(6,
              div(class="form-group", style="margin-bottom:.9rem;",
                tags$label(style="font-weight:600; font-size:.85rem; margin-bottom:.25rem; display:block;",
                  "Full Name"),
                textInput(ns("r_name"), NULL, placeholder="Your full name") |>
                  tagAppendAttributes(style="border-radius:8px; width:100%;")
              )
            ),
            column(6,
              div(class="form-group", style="margin-bottom:.9rem;",
                tags$label(style="font-weight:600; font-size:.85rem; margin-bottom:.25rem; display:block;",
                  "Username"),
                textInput(ns("r_user"), NULL, placeholder="Choose a username") |>
                  tagAppendAttributes(style="border-radius:8px; width:100%;")
              )
            )
          ),
          div(class="form-group", style="margin-bottom:.9rem;",
            tags$label(style="font-weight:600; font-size:.85rem; margin-bottom:.25rem; display:block;",
              "Email Address"),
            textInput(ns("r_email"), NULL, placeholder="your@email.com") |>
              tagAppendAttributes(style="border-radius:8px; width:100%;")
          ),
          fluidRow(
            column(6,
              div(class="form-group", style="margin-bottom:.9rem;",
                tags$label(style="font-weight:600; font-size:.85rem; margin-bottom:.25rem; display:block;",
                  "Password"),
                passwordInput(ns("r_pass"), NULL, placeholder="Min. 4 characters") |>
                  tagAppendAttributes(style="border-radius:8px; width:100%;")
              )
            ),
            column(6,
              div(class="form-group", style="margin-bottom:.9rem;",
                tags$label(style="font-weight:600; font-size:.85rem; margin-bottom:.25rem; display:block;",
                  "Confirm Password"),
                passwordInput(ns("r_pass2"), NULL, placeholder="Re-enter password") |>
                  tagAppendAttributes(style="border-radius:8px; width:100%;")
              )
            )
          ),
          uiOutput(ns("register_msg")),
          actionButton(ns("btn_register"), "Create Account \u2192",
            style="width:100%; background:#E8892A; color:#fff; border:none; border-radius:10px;
                   padding:.75rem; font-weight:700; font-size:.95rem; cursor:pointer; margin-top:.3rem;")
        )
      }
    })

    # ── Login handler ─────────────────────────────────────────
    output$login_msg <- renderUI({ NULL })

    observeEvent(input$btn_login, {
      user <- trimws(input$l_user)
      pass <- input$l_pass
      if (nchar(user) == 0 || nchar(pass) == 0) {
        output$login_msg <- renderUI({
          div(style="background:#FEF2F2; border:1px solid #FCA5A5; border-radius:8px;
                     padding:.6rem .9rem; color:#991B1B; font-size:.85rem; margin-bottom:.7rem;",
            "\u26a0\ufe0f Please enter both username and password.")
        })
        return()
      }
      result <- authenticate_user(user, pass)
      if (!result$ok) {
        output$login_msg <- renderUI({
          div(style="background:#FEF2F2; border:1px solid #FCA5A5; border-radius:8px;
                     padding:.6rem .9rem; color:#991B1B; font-size:.85rem; margin-bottom:.7rem;",
            paste0("\u274c ", result$msg))
        })
      } else {
        rv$logged_in <- TRUE
        rv$username  <- user
        rv$user      <- result$user
      }
    })

    # ── Register handler ──────────────────────────────────────
    output$register_msg <- renderUI({ NULL })

    observeEvent(input$btn_register, {
      nm    <- trimws(input$r_name)
      user  <- trimws(input$r_user)
      em    <- trimws(input$r_email)
      pass  <- input$r_pass
      pass2 <- input$r_pass2

      if (any(nchar(c(nm, user, em, pass)) == 0)) {
        output$register_msg <- renderUI({
          div(style="background:#FEF2F2; border:1px solid #FCA5A5; border-radius:8px;
                     padding:.6rem .9rem; color:#991B1B; font-size:.85rem; margin-bottom:.7rem;",
            "\u26a0\ufe0f All fields are required.")
        })
        return()
      }
      if (pass != pass2) {
        output$register_msg <- renderUI({
          div(style="background:#FEF2F2; border:1px solid #FCA5A5; border-radius:8px;
                     padding:.6rem .9rem; color:#991B1B; font-size:.85rem; margin-bottom:.7rem;",
            "\u274c Passwords do not match.")
        })
        return()
      }
      if (nchar(pass) < 4) {
        output$register_msg <- renderUI({
          div(style="background:#FEF2F2; border:1px solid #FCA5A5; border-radius:8px;
                     padding:.6rem .9rem; color:#991B1B; font-size:.85rem; margin-bottom:.7rem;",
            "\u274c Password must be at least 4 characters.")
        })
        return()
      }

      result <- register_user(user, pass, nm, em)
      if (!result$ok) {
        output$register_msg <- renderUI({
          div(style="background:#FEF2F2; border:1px solid #FCA5A5; border-radius:8px;
                     padding:.6rem .9rem; color:#991B1B; font-size:.85rem; margin-bottom:.7rem;",
            paste0("\u274c ", result$msg))
        })
      } else {
        # Auto-login after successful registration
        auth <- authenticate_user(user, pass)
        rv$logged_in <- TRUE
        rv$username  <- user
        rv$user      <- auth$user
      }
    })

  })
}
