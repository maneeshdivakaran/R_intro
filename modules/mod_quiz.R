# ============================================================
# modules/mod_quiz.R — Quiz Module (Mandatory, Score Saving)
# ============================================================

# ── Quiz Question Bank (5 questions per module) ───────────────
quiz_data <- list(

  basics = list(
    title  = "📘 R Basics Quiz",
    key    = "basics",
    questions = list(
      list(q="What symbol is the preferred assignment operator in R?",
           opts=c("<-","=","->",":="), ans="<-",
           exp="<code>&lt;-</code> is the recommended convention in R. While <code>=</code> also works inside function calls, <code>&lt;-</code> is preferred for general assignment."),
      list(q="What does class(42) return?",
           opts=c('"numeric"','"integer"','"double"','"number"'), ans='"numeric"',
           exp="<code>class(42)</code> returns <code>\"numeric\"</code>. If you write <code>42L</code>, class returns <code>\"integer\"</code>."),
      list(q="What is the result of 7 %% 3 in R?",
           opts=c("1","2","3","0.43"), ans="1",
           exp="<code>%%</code> is the modulo (remainder) operator. 7 ÷ 3 = 2 with remainder <strong>1</strong>."),
      list(q="Which function checks the data type of a variable?",
           opts=c("class()","type()","datatype()","check()"), ans="class()",
           exp="<code>class(x)</code> returns the class/type: 'numeric', 'character', 'logical', etc."),
      list(q="What does nchar('Hello') return?",
           opts=c("5","4","6","7"), ans="5",
           exp="<code>nchar()</code> counts characters in a string. 'Hello' has 5 characters."),
      list(q="What does as.numeric('3.14') produce?",
           opts=c("3.14","\"3.14\"","NA","Error"), ans="3.14",
           exp="<code>as.numeric()</code> converts a character string to a number when possible."),
      list(q="What is 2^8 in R?",
           opts=c("256","64","512","128"), ans="256",
           exp="<code>^</code> is the exponentiation operator. 2⁸ = 256."),
      list(q="Which function prints output to the console?",
           opts=c("print()","echo()","output()","show()"), ans="print()",
           exp="<code>print(x)</code> displays the value of x. You can also just type the variable name.")
    )
  ),

  datastructures = list(
    title  = "🗂 Data Structures Quiz",
    key    = "datastructures",
    questions = list(
      list(q="What function creates a vector?",
           opts=c("c()","vector()","list()","array()"), ans="c()",
           exp="<code>c()</code> stands for 'combine'. It creates a vector: <code>c(1,2,3)</code>."),
      list(q="In R, what index does the first element of a vector have?",
           opts=c("1","0","−1","None"), ans="1",
           exp="R uses 1-based indexing. <code>x[1]</code> gives the first element, unlike Python's 0-based indexing."),
      list(q="What is the class of c(1, 'hello', TRUE)?",
           opts=c("character","mixed","logical","numeric"), ans="character",
           exp="When types are mixed in a vector, R coerces to the most flexible type. A string forces everything to <code>character</code>."),
      list(q="How do you access the 'name' element of a list called person?",
           opts=c("person$name","person['name']","person[[name]]","person.name"), ans="person$name",
           exp="The <code>$</code> operator accesses named elements of a list. <code>[[\"name\"]]</code> also works."),
      list(q="What function returns the dimensions of a matrix?",
           opts=c("dim()","size()","shape()","length()"), ans="dim()",
           exp="<code>dim(m)</code> returns a vector of c(nrow, ncol)."),
      list(q="What function creates a data frame?",
           opts=c("data.frame()","frame()","df()","table()"), ans="data.frame()",
           exp="<code>data.frame(col1=..., col2=...)</code> creates a tabular data structure."),
      list(q="Which of these is NOT a valid way to subset a data frame by column?",
           opts=c("df.col","df$col","df[[\"col\"]]","df[,\"col\"]"), ans="df.col",
           exp="R does not use dot notation for column access. Use <code>$</code>, <code>[[]]</code>, or <code>[,]</code>."),
      list(q="What does length() return for a list with 3 elements?",
           opts=c("3","1","0","Depends on contents"), ans="3",
           exp="<code>length()</code> counts top-level elements. A list with 3 items has length 3.")
    )
  ),

  controlflow = list(
    title  = "🔄 Control Flow Quiz",
    key    = "controlflow",
    questions = list(
      list(q="Which loop is best for a known number of iterations?",
           opts=c("for","while","repeat","switch"), ans="for",
           exp="<code>for (i in 1:10) {...}</code> iterates over a known sequence."),
      list(q="What does 'next' do inside a loop?",
           opts=c("Skips to next iteration","Exits the loop","Repeats current step","Stops R"), ans="Skips to next iteration",
           exp="<code>next</code> skips the rest of the current loop body and moves to the next iteration. <code>break</code> exits the loop."),
      list(q="How do you define a custom function in R?",
           opts=c("function() {}","def() {}","func() {}","define() {}"), ans="function() {}",
           exp="Syntax: <code>my_fn &lt;- function(x, y) { x + y }</code>"),
      list(q="What does ifelse(5 > 3, 'yes', 'no') return?",
           opts=c('"yes"','"no"',"TRUE","5"), ans='"yes"',
           exp="Since 5 > 3 is TRUE, <code>ifelse()</code> returns the second argument: 'yes'."),
      list(q="What is automatically returned from a function if no return() is used?",
           opts=c("Last evaluated expression","NULL","NA","Nothing"), ans="Last evaluated expression",
           exp="In R, functions implicitly return the last evaluated expression."),
      list(q="What keyword exits a loop immediately?",
           opts=c("break","stop","exit","end"), ans="break",
           exp="<code>break</code> immediately exits the loop. Use <code>next</code> to skip one iteration."),
      list(q="Which family of functions replaces loops for applying functions over data?",
           opts=c("apply family","map family","loop family","do family"), ans="apply family",
           exp="<code>lapply()</code>, <code>sapply()</code>, <code>apply()</code> etc. apply functions over lists/vectors/matrices."),
      list(q="What does switch('b', a='Apple', b='Banana', c='Cherry') return?",
           opts=c('"Banana"','"Apple"','"b"',"NULL"), ans='"Banana"',
           exp="<code>switch()</code> matches the first argument to the named choices and returns the matching value.")
    )
  ),

  datamanip = list(
    title  = "🔧 Data Manipulation Quiz",
    key    = "datamanip",
    questions = list(
      list(q="Which dplyr verb keeps rows matching a condition?",
           opts=c("filter()","select()","arrange()","slice()"), ans="filter()",
           exp="<code>filter(df, age > 18)</code> keeps rows where age > 18."),
      list(q="Which verb adds or modifies columns?",
           opts=c("mutate()","add_col()","transform()","modify()"), ans="mutate()",
           exp="<code>mutate(df, area = length * width)</code> adds a new 'area' column."),
      list(q="What does the |> operator do?",
           opts=c("Passes result to next function","Logical OR","Filters rows","Creates a pipe variable"), ans="Passes result to next function",
           exp="The native pipe <code>|></code> (R 4.1+) passes the left-hand result as the first argument to the right-hand function."),
      list(q="Which function sorts rows in descending order?",
           opts=c("arrange(desc(col))","sort(-col)","order(desc=TRUE)","arrange(-col)"), ans="arrange(desc(col))",
           exp="<code>arrange(df, desc(score))</code> sorts from highest to lowest score."),
      list(q="What does group_by() do alone without summarise()?",
           opts=c("Groups for later operations","Removes duplicate rows","Filters by group","Sorts by group"), ans="Groups for later operations",
           exp="<code>group_by()</code> marks the data for grouped operations, usually followed by <code>summarise()</code> or <code>mutate()</code>."),
      list(q="Which dplyr function keeps specific columns?",
           opts=c("select()","pick()","keep()","choose()"), ans="select()",
           exp="<code>select(df, name, age)</code> keeps only the 'name' and 'age' columns."),
      list(q="What does n() count inside summarise()?",
           opts=c("Number of rows in the group","Sum of values","Number of columns","Number of NAs"), ans="Number of rows in the group",
           exp="<code>n()</code> is a special dplyr function that counts rows in the current group."),
      list(q="What is the result of: iris |> filter(Sepal.Length > 7) |> nrow()?",
           opts=c("12","50","5","150"), ans="12",
           exp="There are 12 rows in the iris dataset where Sepal.Length > 7.")
    )
  ),

  visualization = list(
    title  = "📊 Data Visualization Quiz",
    key    = "visualization",
    questions = list(
      list(q="What R package is used for the 'Grammar of Graphics' approach?",
           opts=c("ggplot2","plotly","base","lattice"), ans="ggplot2",
           exp="<code>ggplot2</code> by Hadley Wickham uses a layered grammar: data → aesthetics → geoms → scales → themes."),
      list(q="What does aes() do in ggplot2?",
           opts=c("Maps variables to visual properties","Sets axis limits","Changes the theme","Controls point size"), ans="Maps variables to visual properties",
           exp="<code>aes(x=col1, y=col2, color=group)</code> maps data columns to visual properties of the plot."),
      list(q="Which geom creates a scatter plot?",
           opts=c("geom_point()","geom_scatter()","geom_dot()","geom_plot()"), ans="geom_point()",
           exp="<code>geom_point()</code> draws individual data points for scatter plots."),
      list(q="Which geom shows the distribution of a continuous variable?",
           opts=c("geom_histogram()","geom_bar()","geom_col()","geom_area()"), ans="geom_histogram()",
           exp="<code>geom_histogram(bins=20)</code> bins and counts continuous values."),
      list(q="How do you add a title in ggplot2?",
           opts=c("labs(title='...')","add_title('...')","ggtitle('...')","Both A and C"), ans="Both A and C",
           exp="Both <code>labs(title='...')</code> and <code>ggtitle('...')</code> add a chart title."),
      list(q="What does theme_minimal() do?",
           opts=c("Applies a clean minimal theme","Removes all axes","Makes background black","Adds a grid"), ans="Applies a clean minimal theme",
           exp="<code>theme_minimal()</code> removes background panels and uses subtle grid lines for a clean look."),
      list(q="How do you create subplots split by a variable (e.g., Species)?",
           opts=c("facet_wrap(~Species)","subplot(Species)","split_plot(Species)","group_plot(Species)"), ans="facet_wrap(~Species)",
           exp="<code>facet_wrap(~Species)</code> creates a separate panel for each species."),
      list(q="Which of these correctly adds a regression line to a scatter plot?",
           opts=c("geom_smooth(method='lm')","geom_line(regression=TRUE)","add_lm()","stat_regline()"), ans="geom_smooth(method='lm')",
           exp="<code>geom_smooth(method='lm', se=TRUE)</code> adds a linear regression line with a confidence band.")
    )
  )
)

# ── UI ────────────────────────────────────────────────────────
mod_quiz_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:860px; margin:0 auto; padding:.5rem 1rem 2rem;",

      div(style = "background:linear-gradient(135deg,#0f2142,#1A3E6E); color:#fff;
                   border-radius:12px; padding:1.5rem 2rem; margin-bottom:1.2rem;",
        tags$h3(style="font-weight:700; margin-bottom:.3rem;", "✅ Module Quizzes"),
        tags$p(style="opacity:.85; margin:0; font-size:.9rem;",
          "Each quiz is mandatory — score ≥60% to pass. You need ≥80% average for your certificate.")
      ),

      # ── Overall progress bar ─────────────────────────────────
      uiOutput(ns("quiz_overall_progress")),

      # ── Module selector ──────────────────────────────────────
      div(class="r-card",
        fluidRow(
          column(6,
            selectInput(ns("quiz_module"), "Select Module Quiz:",
              choices = c(
                "📘 Module 1: R Basics"           = "basics",
                "🗂 Module 2: Data Structures"    = "datastructures",
                "🔄 Module 3: Control Flow"       = "controlflow",
                "🔧 Module 4: Data Manipulation"  = "datamanip",
                "📊 Module 5: Data Visualization" = "visualization"
              ))
          ),
          column(6, style="display:flex; align-items:flex-end; padding-bottom:.8rem;",
            uiOutput(ns("selected_module_status"))
          )
        )
      ),

      # ── Quiz Questions ────────────────────────────────────────
      uiOutput(ns("quiz_question_ui")),

      # ── Submit ────────────────────────────────────────────────
      uiOutput(ns("quiz_submit_ui")),

      # ── Results ──────────────────────────────────────────────
      uiOutput(ns("quiz_result_ui"))
    )
  )
}

# ── Server ────────────────────────────────────────────────────
mod_quiz_server <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    qrv <- reactiveValues(
      started   = FALSE,
      submitted = FALSE,
      module    = NULL,
      n_q       = 5   # questions per attempt
    )

    # Randomly select N questions from the bank
    selected_qs <- reactiveVal(NULL)

    observeEvent(input$quiz_module, {
      qrv$started   <- FALSE
      qrv$submitted <- FALSE
    })

    # ── Overall progress ──────────────────────────────────────
    output$quiz_overall_progress <- renderUI({
      req(rv$logged_in)
      p <- get_progress_summary(rv$username)
      module_labels <- c("R Basics","Data Structures","Control Flow","Data Manipulation","Visualization")

      div(class="r-card", style="margin-bottom:1rem;",
        tags$h6(style="font-weight:700; color:#1A3E6E; margin-bottom:.8rem;", "📊 Your Quiz Progress"),
        fluidRow(
          lapply(seq_along(names(p$scores)), function(i) {
            k <- names(p$scores)[i]
            sc <- p$scores[[k]]
            col <- if (is.na(sc)) "#94A3B8" else if (sc >= 80) "#16A34A" else if (sc >= 60) "#2563EB" else "#DC2626"
            bg  <- if (is.na(sc)) "#F1F5F9" else if (sc >= 80) "#D1FAE5" else if (sc >= 60) "#DBEAFE" else "#FEE2E2"
            column(2, style=sprintf(
              "background:%s; border-radius:10px; padding:.6rem .4rem; text-align:center; margin:0 .2rem;", bg),
              div(style=sprintf("font-size:1rem; font-weight:800; color:%s;", col),
                if (!is.na(sc)) paste0(sc,"%") else "—"),
              div(style="font-size:.65rem; color:#64748B; margin-top:.2rem;", module_labels[i])
            )
          })
        ),
        div(style="margin-top:.7rem; background:#E2E8F0; border-radius:99px; height:8px; overflow:hidden;",
          div(style=sprintf(
            "width:%d%%; height:100%%; background:linear-gradient(90deg,#1A3E6E,#E8892A); border-radius:99px; transition:width .5s;",
            p$pct_complete))
        ),
        div(style="font-size:.78rem; color:#64748B; margin-top:.4rem;",
          paste0(p$quiz_passed, "/5 passed | Average: ", p$avg_score, "% | Need 80% avg for certificate"))
      )
    })

    # ── Selected module status ────────────────────────────────
    output$selected_module_status <- renderUI({
      req(rv$logged_in, input$quiz_module)
      p  <- get_progress_summary(rv$username)
      sc <- p$scores[[input$quiz_module]]
      div(style="display:flex; align-items:center; gap:.6rem;",
        tags$span(style="font-size:.85rem; color:#64748B;", "Status:"),
        module_status_badge(sc),
        if (!is.na(sc))
          tags$span(style="font-size:.8rem; color:#2563EB; font-weight:500;", "(Can retake to improve)")
      )
    })

    # ── Start/render quiz ─────────────────────────────────────
    output$quiz_question_ui <- renderUI({
      req(rv$logged_in, input$quiz_module)

      mod  <- input$quiz_module
      bank <- quiz_data[[mod]]$questions
      n    <- min(qrv$n_q, length(bank))

      if (!qrv$started) {
        p  <- get_progress_summary(rv$username)
        sc <- p$scores[[mod]]

        tagList(
          div(class="r-card",
            tags$h5(style="font-weight:700; margin-bottom:.5rem;", quiz_data[[mod]]$title),
            tags$p(style="color:#64748B; font-size:.9rem; margin-bottom:.8rem;",
              paste0("This quiz has ", n, " randomly selected questions from a bank of ", length(bank), ". ",
                     "Pass mark: 60% | Certificate threshold: 80% average")),
            if (!is.na(sc))
              div(style="background:#EFF6FF; border:1px solid #93C5FD; border-radius:8px; padding:.6rem .9rem;
                         font-size:.85rem; color:#1E40AF; margin-bottom:.8rem;",
                paste0("ℹ️ Your best score: ", sc, "%. Retaking will only save a higher score.")),
            actionButton(ns("btn_start"), "🚀 Start Quiz",
              style="background:#1A3E6E; color:#fff; border:none; border-radius:10px;
                     padding:.65rem 1.8rem; font-weight:700; font-size:.95rem; cursor:pointer;")
          )
        )
      } else if (!qrv$submitted) {
        qs <- selected_qs()
        tagList(
          tags$h5(style="font-weight:700; margin-bottom:.8rem; color:#1A3E6E;",
            quiz_data[[mod]]$title),
          tagList(lapply(seq_along(qs), function(i) {
            q <- qs[[i]]
            div(class="quiz-question",
              tags$p(class="q-text",
                tags$span(
                  style="background:#DBEAFE; color:#2563EB; border-radius:99px;
                           padding:.15rem .55rem; font-size:.8rem; font-weight:700; margin-right:.5rem;",
                  paste0("Q", i)),
                q$q),
              radioButtons(
                ns(paste0("q_", i)), NULL,
                choices  = q$opts,
                selected = character(0)
              )
            )
          }))
        )
      }
    })

    # ── Start button ──────────────────────────────────────────
    observeEvent(input$btn_start, {
      mod  <- input$quiz_module
      bank <- quiz_data[[mod]]$questions
      n    <- min(qrv$n_q, length(bank))
      # Randomly select n questions
      idx  <- sample(seq_along(bank), n)
      selected_qs(bank[idx])
      qrv$started   <- TRUE
      qrv$submitted <- FALSE
      qrv$module    <- mod
    })

    # ── Submit UI ─────────────────────────────────────────────
    output$quiz_submit_ui <- renderUI({
      req(qrv$started && !qrv$submitted)
      tagList(br(),
        actionButton(ns("btn_submit"), "📝 Submit Answers",
          style="background:#16A34A; color:#fff; border:none; border-radius:10px;
                 padding:.65rem 1.8rem; font-weight:700; font-size:.95rem; cursor:pointer;")
      )
    })

    # ── Grade & save ──────────────────────────────────────────
    observeEvent(input$btn_submit, {
      qs   <- selected_qs()
      n    <- length(qs)
      score <- 0L
      for (i in seq_len(n)) {
        chosen <- input[[paste0("q_", i)]]
        if (!is.null(chosen) && chosen == qs[[i]]$ans) score <- score + 1L
      }
      pct <- round(score / n * 100)

      # Save to user progress
      if (rv$logged_in) {
        save_quiz_score(rv$username, qrv$module, pct)
        rv$user <- get_user(rv$username)
      }

      qrv$submitted <- TRUE
    })

    # ── Results UI ────────────────────────────────────────────
    output$quiz_result_ui <- renderUI({
      req(qrv$submitted)
      qs   <- selected_qs()
      n    <- length(qs)
      score <- 0L
      for (i in seq_len(n)) {
        chosen <- input[[paste0("q_", i)]]
        if (!is.null(chosen) && chosen == qs[[i]]$ans) score <- score + 1L
      }
      pct <- round(score / n * 100)
      passed  <- pct >= 60
      grade_col <- if (pct >= 80) "#16A34A" else if (pct >= 60) "#2563EB" else "#DC2626"
      grade_lbl <- if (pct == 100) "🏆 Perfect!" else if (pct >= 80) "🌟 Excellent!" else if (pct >= 60) "✔ Passed!" else "❌ Below Pass Mark"

      feedback <- lapply(seq_along(qs), function(i) {
        q      <- qs[[i]]
        chosen <- input[[paste0("q_", i)]]
        is_cor <- !is.null(chosen) && (chosen == q$ans)
        div(class="quiz-question",
          tags$p(class="q-text",
            tags$span(style="background:#DBEAFE; color:#2563EB; border-radius:99px;
                               padding:.15rem .55rem; font-size:.8rem; font-weight:700; margin-right:.5rem;",
              paste0("Q",i)), q$q),
          if (is_cor)
            tags$p(class="quiz-result-correct", paste0("✅ Correct! — ", chosen))
          else
            tags$p(class="quiz-result-incorrect",
              paste0("❌ You chose: ", if(is.null(chosen)) "(no answer)" else chosen,
                     " | Correct: ", q$ans)),
          div(style="background:#F8FAFC; border-radius:8px; padding:.6rem .9rem;
                     font-size:.84rem; color:#334155; margin-top:.3rem; border-left:3px solid #93C5FD;",
            tags$strong("Explanation: "), HTML(q$exp))
        )
      })

      tagList(
        div(class="score-banner", style=sprintf("border-color:%s33;", grade_col),
          div(class="score-num", style=paste0("color:",grade_col,";"), paste0(score,"/",n)),
          div(class="score-label", paste0(pct, "% — ", grade_lbl)),
          if (!passed)
            div(style="margin-top:.6rem; font-size:.85rem; color:#991B1B;",
              "Score below 60% — retake to pass this module."),
          br(),
          actionButton(ns("btn_retry"), "🔄 Retake Quiz",
            style="background:#1A3E6E; color:#fff; border:none; border-radius:8px;
                   padding:.45rem 1.2rem; font-weight:600; cursor:pointer; font-size:.88rem;")
        ),
        br(),
        tags$h5(style="font-weight:700; margin-bottom:.5rem;", "📋 Answer Review:"),
        tagList(feedback)
      )
    })

    # ── Retry ─────────────────────────────────────────────────
    observeEvent(input$btn_retry, {
      mod  <- qrv$module
      bank <- quiz_data[[mod]]$questions
      n    <- min(qrv$n_q, length(bank))
      idx  <- sample(seq_along(bank), n)
      selected_qs(bank[idx])
      qrv$submitted <- FALSE
      # Reset radio buttons
      for (i in seq_len(n)) {
        updateRadioButtons(session, paste0("q_", i), selected = character(0))
      }
    })

  })
}
