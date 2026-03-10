# ============================================================
# modules/mod_certificate.R — Certificate Generation Module
# ============================================================

mod_certificate_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:900px; margin:0 auto; padding:.5rem 1rem 2rem;",

      uiOutput(ns("cert_page"))
    )
  )
}

mod_certificate_server <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$cert_page <- renderUI({
      req(rv$logged_in)
      u <- get_user(rv$username)
      p <- get_progress_summary(rv$username)

      if (!p$eligible) {
        # ── Not yet eligible ────────────────────────────────
        module_labels <- c(
          basics="R Basics", datastructures="Data Structures",
          controlflow="Control Flow", datamanip="Data Manipulation",
          visualization="Visualization"
        )
        remaining <- sum(is.na(unlist(p$scores)))
        avg_so_far <- if (!is.null(p$avg_score) && p$quiz_done > 0) p$avg_score else 0

        tagList(
          div(class="hero-banner",
            tags$h3("🏆 Your Certificate Awaits!"),
            tags$p("Complete all 5 module quizzes with an average score of ≥80% to unlock your certificate.")
          ),
          div(class="r-card",
            tags$h5(style="font-weight:700; margin-bottom:1rem; color:#1A3E6E;",
              "📋 Progress Towards Certificate"),
            fluidRow(
              column(6,
                div(style="background:#F8FAFC; border-radius:12px; padding:1rem; margin-bottom:1rem;",
                  tags$p(style="font-size:.85rem; color:#64748B; margin:0 0 .5rem;", "Quiz Completion"),
                  tags$div(style=sprintf(
                    "background:#E2E8F0; border-radius:99px; height:10px; overflow:hidden; margin-bottom:.4rem;"),
                    tags$div(style=sprintf(
                      "width:%d%%; height:100%%; background:#1A3E6E; border-radius:99px; transition:width .5s;",
                      p$quiz_done * 20))
                  ),
                  tags$p(style="font-size:.82rem; color:#374151; margin:0;",
                    paste0(p$quiz_done, "/5 quizzes completed"))
                ),
                div(style="background:#F8FAFC; border-radius:12px; padding:1rem;",
                  tags$p(style="font-size:.85rem; color:#64748B; margin:0 0 .5rem;", "Average Score"),
                  tags$div(style="background:#E2E8F0; border-radius:99px; height:10px; overflow:hidden; margin-bottom:.4rem;",
                    tags$div(style=sprintf(
                      "width:%d%%; height:100%%; background:%s; border-radius:99px;",
                      min(100, round(avg_so_far)),
                      if (avg_so_far >= 80) "#16A34A" else "#D97706"))
                  ),
                  tags$p(style="font-size:.82rem; color:#374151; margin:0;",
                    paste0(avg_so_far, "% (need ≥80%)"))
                )
              ),
              column(6,
                tags$h6(style="font-weight:600; margin-bottom:.7rem;", "Quiz Scores by Module:"),
                tagList(lapply(names(module_labels), function(k) {
                  score <- p$scores[[k]]
                  div(style="display:flex; align-items:center; justify-content:space-between;
                              padding:.5rem; border-radius:8px; margin-bottom:.4rem; background:#F8FAFC;",
                    tags$span(style="font-size:.85rem; color:#374151;", module_labels[[k]]),
                    module_status_badge(score)
                  )
                }))
              )
            ),
            div(class="callout callout-info",
              div(class="callout-icon","ℹ️"),
              tags$p(HTML(sprintf(
                "<strong>%s quizzes remaining.</strong> Head to the <strong>✅ Quizzes</strong>
                 tab to complete them. You need ≥60%% per quiz and ≥80%% average overall.",
                remaining)))
            )
          )
        )

      } else {
        # ── Eligible — show certificate ───────────────────────
        cert_id <- paste0("PDL-R-", format(Sys.Date(), "%Y%m"), "-",
                          toupper(substr(rv$username, 1, 4)),
                          sprintf("%04d", sum(utf8ToInt(rv$username)) %% 9999))

        if (!isTRUE(u$certificate_issued)) {
          issue_certificate(rv$username)
          u <- get_user(rv$username)
          rv$user <- u
        }

        module_labels <- c(
          basics="R Basics", datastructures="Data Structures",
          controlflow="Control Flow", datamanip="Data Manipulation",
          visualization="Visualization"
        )

        tagList(
          div(style="background:linear-gradient(135deg,#D1FAE5,#ECFDF5); border:2px solid #6EE7B7;
                     border-radius:12px; padding:1rem 1.5rem; margin-bottom:1rem;
                     display:flex; align-items:center; gap:1rem;",
            div(style="font-size:2rem;","🎉"),
            div(
              tags$h5(style="margin:0; color:#065F46; font-weight:700;",
                "Congratulations! You've earned your certificate!"),
              tags$p(style="margin:0; color:#047857; font-size:.88rem;",
                paste0("Avg Score: ", p$avg_score, "% | Issued: ", u$completion_date))
            )
          ),

          # Download button
          div(style="margin-bottom:1rem;",
            downloadButton(ns("btn_download_cert"), "⬇ Download Certificate (HTML)",
              style="background:#1A3E6E; color:#fff; border:none; border-radius:10px;
                     padding:.6rem 1.4rem; font-weight:600; font-size:.9rem; cursor:pointer; margin-right:.5rem;"),
            actionButton(ns("btn_print_cert"), "🖨 Print Certificate",
              style="background:#E8892A; color:#fff; border:none; border-radius:10px;
                     padding:.6rem 1.4rem; font-weight:600; font-size:.9rem; cursor:pointer;")
          ),

          # ── Certificate Preview ──────────────────────────
          div(style="background:#fff; border:3px solid #1A3E6E; border-radius:16px;
                     overflow:hidden; box-shadow:0 8px 32px rgba(0,0,0,.12);",

            # Gold top bar
            div(style="background:linear-gradient(90deg,#1A3E6E,#2563EB,#E8892A,#2563EB,#1A3E6E);
                       height:8px;"),

            div(style="padding:2.5rem 3rem; text-align:center;",

              # Header
              div(style="margin-bottom:1.5rem;",
                div(style="font-size:1.4rem; font-weight:900; letter-spacing:-1px; margin-bottom:.25rem;",
                  tags$span(style="color:#1A3E6E;","PRO"),
                  tags$span(style="color:#E8892A;","DATA"),
                  tags$span(style="color:#1A3E6E;","LYTICS")
                ),
                div(style="font-size:.72rem; letter-spacing:2px; color:#64748B; text-transform:uppercase;",
                  "INDIA PVT LTD.")
              ),

              tags$hr(style="border:none; border-top:2px solid #E2E8F0; margin:1rem 3rem;"),

              div(style="color:#94A3B8; font-size:.8rem; letter-spacing:3px; text-transform:uppercase; margin-bottom:.5rem;",
                "Certificate of Completion"),
              div(style="color:#1A3E6E; font-size:.95rem; margin-bottom:1rem;", "This is to certify that"),
              div(style="font-size:2.2rem; font-weight:800; color:#0f2142; font-style:italic;
                         border-bottom:2px solid #E8892A; display:inline-block; padding:0 2rem .3rem;
                         margin-bottom:1rem;",
                u$full_name),
              div(style="color:#475569; font-size:.9rem; margin-bottom:.5rem;",
                "has successfully completed the course"),
              div(style="font-size:1.3rem; font-weight:700; color:#1A3E6E; margin-bottom:1.5rem;",
                "Introduction to R for Students"),

              # Score summary
              div(style="background:#F8FAFC; border-radius:12px; padding:1rem 1.5rem; margin:1rem auto;
                         max-width:500px; border:1px solid #E2E8F0;",
                tags$h6(style="font-weight:700; color:#1A3E6E; margin-bottom:.7rem;", "Performance Summary"),
                fluidRow(
                  lapply(names(module_labels), function(k) {
                    sc <- p$scores[[k]]
                    column(4, style="margin-bottom:.4rem;",
                      div(style="font-size:.72rem; color:#64748B;", module_labels[[k]]),
                      div(style="font-size:.9rem; font-weight:700; color:#1A3E6E;",
                        paste0(if (!is.na(sc)) sc else 0, "%"))
                    )
                  })
                ),
                div(style="border-top:1px solid #E2E8F0; margin-top:.7rem; padding-top:.6rem;",
                  tags$strong(style="font-size:.95rem; color:#059669;",
                    paste0("Overall Average: ", p$avg_score, "%"))
                )
              ),

              div(style="color:#64748B; font-size:.8rem; margin-top:1rem; margin-bottom:1.5rem;",
                paste0("Date: ", u$completion_date, "  •  Certificate ID: ", cert_id)
              ),

              # Signatures
              fluidRow(
                column(6, style="text-align:center;",
                  div(style="border-top:2px solid #1A3E6E; padding-top:.5rem; margin:0 2rem;",
                    div(style="font-weight:700; font-size:.88rem; color:#1A3E6E;", "PRODATALYTICS INDIA PVT LTD."),
                    div(style="font-size:.75rem; color:#94A3B8;", "Authorized Signatory")
                  )
                ),
                column(6, style="text-align:center;",
                  div(style="border-top:2px solid #1A3E6E; padding-top:.5rem; margin:0 2rem;",
                    div(style="font-weight:700; font-size:.88rem; color:#1A3E6E;", "Course Director"),
                    div(style="font-size:.75rem; color:#94A3B8;", "Introduction to R")
                  )
                )
              )
            ),

            # Gold bottom bar
            div(style="background:linear-gradient(90deg,#1A3E6E,#2563EB,#E8892A,#2563EB,#1A3E6E);
                       height:8px;")
          )
        )
      }
    })

    # ── Download handler ──────────────────────────────────────
    output$btn_download_cert <- downloadHandler(
      filename = function() {
        paste0("ProDatalytics_Certificate_", rv$username, "_", Sys.Date(), ".html")
      },
      content = function(file) {
        u <- get_user(rv$username)
        p <- get_progress_summary(rv$username)
        cert_id <- paste0("PDL-R-", format(Sys.Date(), "%Y%m"), "-",
                          toupper(substr(rv$username, 1, 4)),
                          sprintf("%04d", sum(utf8ToInt(rv$username)) %% 9999))

        module_labels <- c(
          basics="R Basics", datastructures="Data Structures",
          controlflow="Control Flow", datamanip="Data Manipulation",
          visualization="Visualization"
        )

        score_rows <- paste(sapply(names(module_labels), function(k) {
          sc <- if (!is.na(p$scores[[k]])) p$scores[[k]] else 0
          sprintf('<tr><td>%s</td><td style="font-weight:700; color:#1A3E6E;">%s%%</td></tr>',
                  module_labels[[k]], sc)
        }), collapse = "\n")

        html <- sprintf('<!DOCTYPE html>
<html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ProDatalytics Certificate — %s</title>
<style>
  @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap");
  * { margin:0; padding:0; box-sizing:border-box; }
  body { font-family:"Inter",sans-serif; background:#f0f4f8; display:flex; justify-content:center; align-items:center; min-height:100vh; }
  .cert { background:#fff; width:800px; border:4px solid #1A3E6E; border-radius:20px; overflow:hidden; box-shadow:0 20px 60px rgba(0,0,0,.15); }
  .grad-bar { height:10px; background:linear-gradient(90deg,#1A3E6E,#2563EB,#E8892A,#2563EB,#1A3E6E); }
  .body { padding:3rem; text-align:center; }
  .brand { font-size:1.8rem; font-weight:900; letter-spacing:-1px; }
  .brand .pro { color:#1A3E6E; } .brand .data { color:#E8892A; } .brand .lytics { color:#1A3E6E; }
  .sub { font-size:.7rem; letter-spacing:3px; color:#94A3B8; text-transform:uppercase; margin-top:.2rem; }
  hr { border:none; border-top:2px solid #E2E8F0; margin:1.5rem 4rem; }
  .label { font-size:.75rem; letter-spacing:3px; color:#94A3B8; text-transform:uppercase; margin-bottom:.5rem; }
  .intro { color:#475569; font-size:.9rem; margin-bottom:1rem; }
  .name { font-size:2.5rem; font-weight:900; color:#0f2142; font-style:italic; border-bottom:3px solid #E8892A; display:inline-block; padding:0 2rem .3rem; margin-bottom:1rem; }
  .course { font-size:1.2rem; font-weight:700; color:#1A3E6E; margin-top:.5rem; margin-bottom:1.5rem; }
  .score-box { background:#F8FAFC; border:1px solid #E2E8F0; border-radius:12px; max-width:450px; margin:0 auto; padding:1.2rem 1.5rem; text-align:left; }
  .score-box h4 { color:#1A3E6E; font-size:.9rem; margin-bottom:.8rem; }
  .score-box table { width:100%; font-size:.85rem; }
  .score-box td { padding:.3rem .5rem; }
  .avg { border-top:1px solid #E2E8F0; padding-top:.7rem; margin-top:.5rem; font-size:1rem; font-weight:700; color:#059669; }
  .meta { color:#94A3B8; font-size:.75rem; margin-top:1rem; margin-bottom:1.5rem; }
  .sigs { display:flex; justify-content:space-around; margin-top:2rem; }
  .sig-block { text-align:center; width:180px; }
  .sig-line { border-top:2px solid #1A3E6E; padding-top:.5rem; }
  .sig-name { font-weight:700; font-size:.85rem; color:#1A3E6E; }
  .sig-role { font-size:.72rem; color:#94A3B8; margin-top:.2rem; }
</style></head><body>
<div class="cert">
  <div class="grad-bar"></div>
  <div class="body">
    <div class="brand"><span class="pro">PRO</span><span class="data">DATA</span><span class="lytics">LYTICS</span></div>
    <div class="sub">India Pvt Ltd.</div>
    <hr>
    <div class="label">Certificate of Completion</div>
    <div class="intro">This is to certify that</div>
    <div class="name">%s</div>
    <div style="color:#475569; font-size:.9rem; margin-top:.5rem;">has successfully completed the course</div>
    <div class="course">Introduction to R for Students</div>
    <div class="score-box">
      <h4>Performance Summary</h4>
      <table>%s<tr><td class="avg" colspan="2">Overall Average: %s%%</td></tr></table>
    </div>
    <div class="meta">Date: %s &nbsp;•&nbsp; Certificate ID: %s</div>
    <div class="sigs">
      <div class="sig-block"><div class="sig-line"><div class="sig-name">PRODATALYTICS INDIA PVT LTD.</div><div class="sig-role">Authorized Signatory</div></div></div>
      <div class="sig-block"><div class="sig-line"><div class="sig-name">Course Director</div><div class="sig-role">Introduction to R</div></div></div>
    </div>
  </div>
  <div class="grad-bar"></div>
</div>
</body></html>',
          u$full_name, u$full_name, score_rows, p$avg_score,
          u$completion_date, cert_id)

        writeLines(html, file)
      }
    )

    # ── Print ─────────────────────────────────────────────────
    observeEvent(input$btn_print_cert, {
      session$sendCustomMessage("printPage", list())
    })

  })
}
