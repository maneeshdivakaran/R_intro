# ============================================================
# modules/mod_home.R — Home / Dashboard Module
# ============================================================

mod_home_ui <- function(id) {
  ns <- NS(id)
  tagList(
    div(style = "max-width:1100px; margin:0 auto; padding:.5rem 1rem 2rem;",

      # ── Hero ─────────────────────────────────────────────────
      div(class = "hero-banner",
        fluidRow(
          column(8,
            tags$h1("📐 Introduction to R for Students"),
            tags$p(
              "A beginner-friendly, interactive course to master R programming —
               from your first variable to beautiful visualizations and data insights."
            ),
            br(),
            div(style = "display:flex; gap:.6rem; flex-wrap:wrap;",
              lapply(c("🎯 5 Modules","💡 Live Try-It","✅ Mandatory Quizzes","🏆 Certificate"), function(x)
                tags$span(style="background:rgba(255,255,255,.2); border-radius:99px; padding:.3rem .9rem;
                                 font-size:.8rem; font-weight:600;", x)
              )
            )
          ),
          column(4, style="text-align:right;",
            uiOutput(ns("progress_ring"))
          )
        )
      ),

      # ── Progress Dashboard (shown after login) ────────────────
      uiOutput(ns("progress_dashboard")),

      # ── Module Cards ─────────────────────────────────────────
      tags$h4(style="font-weight:700; margin:1.5rem 0 1rem; color:#1E293B;", "📚 Course Modules"),

      fluidRow(
        lapply(list(
          list("📘","Module 1","R Basics",          "Variables, types, operators, functions",       "#DBEAFE","#2563EB"),
          list("🗂", "Module 2","Data Structures",  "Vectors, matrices, lists, data frames",        "#EDE9FE","#7C3AED"),
          list("🔄","Module 3","Control Flow",       "If/else, loops, custom functions",            "#D1FAE5","#059669"),
          list("🔧","Module 4","Data Manipulation",  "dplyr: filter, mutate, summarise",            "#FEF3C7","#D97706"),
          list("📊","Module 5","Visualization",      "ggplot2: scatter, bar, histogram, boxplot",   "#FCE7F3","#DB2777")
        ), function(m) {
          column(12, style="margin-bottom:.7rem;",
            div(style=sprintf("background:%s; border-radius:12px; padding:1rem 1.2rem;
                               border:1px solid %s33; display:flex; align-items:center; gap:1rem;",
                              m[[6]], m[[6]]),
              div(style="font-size:2rem; flex-shrink:0;", m[[1]]),
              div(
                div(style="display:flex; align-items:center; gap:.5rem; margin-bottom:.2rem;",
                  tags$span(style=sprintf("background:%s; color:#fff; border-radius:99px;
                                           padding:.15rem .6rem; font-size:.72rem; font-weight:700;", m[[6]]), m[[2]]),
                  tags$strong(style="font-size:.95rem; color:#1E293B;", m[[3]])
                ),
                tags$p(style="margin:0; font-size:.82rem; color:#64748B;", m[[4]])
              ),
              uiOutput(ns(paste0("badge_", tolower(gsub(" ","_",m[[3]]))))  )
            )
          )
        })
      ),

      # ── Certification Path ───────────────────────────────────
      div(class="r-card", style="background:linear-gradient(135deg,#1A3E6E,#2563EB); color:#fff; border:none; margin-top:.5rem;",
        fluidRow(
          column(8,
            tags$h5(style="font-weight:700; margin-bottom:.5rem; color:#fff;", "🏆 Earn Your Certificate"),
            tags$p(style="opacity:.9; margin:0; font-size:.88rem;",
              "Complete all 5 modules and score ≥80% average across all quizzes to receive your
               official certificate powered by PRODATALYTICS INDIA PVT LTD.")
          ),
          column(4, style="text-align:right; display:flex; align-items:center; justify-content:flex-end;",
            div(
              div(style="font-size:2.5rem;","🎓"),
              tags$p(style="color:rgba(255,255,255,.8); font-size:.8rem; margin:.3rem 0 0; font-weight:600;",
                "Professional Certificate")
            )
          )
        )
      ),

      # ── About Prodatalytics ───────────────────────────────────
      div(id="about-prodatalytics",
        tags$h4(style="font-weight:700; margin:2rem 0 1rem; color:#1E293B;", "🏢 About Prodatalytics"),

        div(class="r-card",
          fluidRow(
            column(4,
              div(style="background:linear-gradient(135deg,#0f2142,#1A3E6E); border-radius:12px;
                         padding:1.5rem; text-align:center; height:100%;",
                div(style="font-size:1.6rem; font-weight:900; letter-spacing:-1px; margin-bottom:.4rem;",
                  tags$span(style="color:#fff;","PRO"),
                  tags$span(style="color:#E8892A;","DATA"),
                  tags$span(style="color:#fff;","LYTICS")
                ),
                tags$p(style="color:rgba(255,255,255,.7); font-size:.78rem; margin:0;
                               letter-spacing:1.5px; text-transform:uppercase;",
                  "INDIA PVT LTD."),
                tags$hr(style="border-color:rgba(255,255,255,.2); margin:.8rem 0;"),
                tags$p(style="color:rgba(255,255,255,.8); font-size:.82rem; margin:0;",
                  "Empowering learners with data-driven skills for tomorrow's world.")
              )
            ),
            column(8,
              tags$h5(style="font-weight:700; color:#1A3E6E; margin-bottom:.8rem;",
                "Transforming Careers Through Data Education"),
              tags$p(style="color:#475569; line-height:1.7; font-size:.9rem;",
                "Prodatalytics India Pvt Ltd is a premier data science and analytics training organization
                 dedicated to equipping students and professionals with industry-relevant skills.
                 Our expert-led programs combine theoretical foundations with hands-on practical experience
                 to ensure learners are job-ready from day one."
              ),
              tags$p(style="color:#475569; line-height:1.7; font-size:.9rem;",
                "From R and Python programming to machine learning and business intelligence,
                 Prodatalytics delivers world-class education tailored to the needs of the modern data ecosystem."
              ),
              fluidRow(
                lapply(list(
                  list("📊","Data Science"),
                  list("🐍","Python & R"),
                  list("🤖","Machine Learning"),
                  list("📈","Business Analytics")
                ), function(s) {
                  column(6, style="margin-bottom:.5rem;",
                    div(style="display:flex; align-items:center; gap:.5rem; font-size:.85rem; color:#374151;",
                      tags$span(s[[1]]), tags$span(style="font-weight:500;", s[[2]])
                    )
                  )
                })
              ),
              div(style="margin-top:.8rem;",
                tags$a(href="https://www.prodatalytics.com", target="_blank",
                  style="background:#E8892A; color:#fff; border-radius:8px; padding:.45rem 1.1rem;
                         font-size:.85rem; font-weight:600; text-decoration:none; display:inline-block;",
                  "🌐 Visit prodatalytics.com"
                )
              )
            )
          )
        )
      ),

      # ── How to Use ───────────────────────────────────────────
      div(class="r-card r-card-success",
        tags$h5(style="font-weight:700; margin-bottom:.8rem;", "🚀 How to Use This Course"),
        fluidRow(
          lapply(list(
            list("1️⃣","Visit Each Module","Use the top navigation to study concepts"),
            list("2️⃣","Try Exercises","Use interactive panels in each module"),
            list("3️⃣","Pass the Quiz","Score ≥60% in each module's quiz"),
            list("4️⃣","Earn Certificate","Score ≥80% average and get certified")
          ), function(s) {
            column(3, div(style="text-align:center; padding:.5rem;",
              div(style="font-size:2rem;", s[[1]]),
              tags$p(style="font-size:.85rem; font-weight:600; margin:.3rem 0 .15rem;", s[[2]]),
              tags$p(style="font-size:.78rem; color:#64748B; margin:0;", s[[3]])
            ))
          })
        )
      )
    )
  )
}

mod_home_server <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    module_labels <- c(
      basics         = "R Basics",
      datastructures = "Data Structures",
      controlflow    = "Control Flow",
      datamanip      = "Data Manipulation",
      visualization  = "Visualization"
    )

    # ── Progress ring ─────────────────────────────────────────
    output$progress_ring <- renderUI({
      req(rv$logged_in)
      p <- get_progress_summary(rv$username)
      pct <- p$pct_complete
      div(style="text-align:center;",
        div(style=sprintf(
          "width:90px; height:90px; border-radius:50%;
           background:conic-gradient(#E8892A 0deg, #E8892A %ddeg, rgba(255,255,255,.2) %ddeg);
           display:flex; align-items:center; justify-content:center; margin:0 auto .5rem;",
          round(pct * 3.6), round(pct * 3.6)),
          div(style="background:#1A3E6E; border-radius:50%; width:68px; height:68px;
                     display:flex; align-items:center; justify-content:center; flex-direction:column;",
            div(style="color:#fff; font-weight:800; font-size:1.1rem; line-height:1;",
              paste0(pct, "%")),
            div(style="color:rgba(255,255,255,.6); font-size:.6rem;", "Complete")
          )
        ),
        div(style="color:rgba(255,255,255,.8); font-size:.78rem;",
          paste0(p$quiz_done, "/5 quizzes done"))
      )
    })

    # ── Progress dashboard ────────────────────────────────────
    output$progress_dashboard <- renderUI({
      req(rv$logged_in)
      u <- rv$user
      p <- get_progress_summary(rv$username)

      div(class="r-card", style="margin-bottom:1rem;",
        tags$h5(style="font-weight:700; margin-bottom:1rem; color:#1A3E6E;",
          paste0("👋 Welcome back, ", strsplit(u$full_name," ")[[1]][1], "!")),
        fluidRow(
          lapply(list(
            list(p$viewed_count, "5","📖","Modules Visited","#DBEAFE","#2563EB"),
            list(p$quiz_done,    "5","✅","Quizzes Done",   "#D1FAE5","#059669"),
            list(p$quiz_passed,  "5","🏅","Quizzes Passed", "#FEF3C7","#D97706"),
            list(paste0(p$avg_score, "%"), "—","📊","Avg Quiz Score","#EDE9FE","#7C3AED")
          ), function(s) {
            column(3,
              div(style=sprintf("background:%s; border-radius:12px; padding:.9rem; text-align:center;", s[[5]]),
                div(style="font-size:1.4rem; margin-bottom:.2rem;", s[[3]]),
                div(style=sprintf("font-size:1.4rem; font-weight:800; color:%s; line-height:1;", s[[6]]),
                  paste0(s[[1]], if (s[[2]] != "—") paste0("/", s[[2]]) else "")),
                div(style="font-size:.75rem; color:#64748B; margin-top:.2rem;", s[[4]])
              )
            )
          })
        )
      )
    })

    # ── Per-module status badges ──────────────────────────────
    module_keys <- c("r_basics","data_structures","control_flow","data_manipulation","visualization")
    score_keys  <- c("basics","datastructures","controlflow","datamanip","visualization")

    for (i in seq_along(module_keys)) {
      local({
        mk <- module_keys[i]; sk <- score_keys[i]
        output[[paste0("badge_", mk)]] <- renderUI({
          req(rv$logged_in)
          p <- get_progress_summary(rv$username)
          div(style="margin-left:auto;",
            module_status_badge(p$scores[[sk]])
          )
        })
      })
    }
  })
}
