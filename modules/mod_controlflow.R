# ============================================================
# modules/mod_controlflow.R — Control Flow Module
# Topics: If/Else, Loops, Custom Functions
# ============================================================

mod_controlflow_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:960px; margin:0 auto; padding:.5rem 1rem 2rem;",

      div(class = "r-card r-card-warning",
        tags$span(class = "badge-module", "Module 3"),
        tags$h3(class = "section-title", "🔄 Control Flow"),
        tags$p(class = "section-subtitle",
          "Control how your code executes using conditionals, loops, and your own custom functions.")
      ),

      navset_tab(

        # ──────────────────────────────────────────────────────
        # Tab 1: If / Else
        # ──────────────────────────────────────────────────────
        nav_panel("If / Else",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "Conditional Logic"),
            tags$p(
              "Use ", tags$code("if"), ", ", tags$code("else if"), ", and ", tags$code("else"),
              " to make decisions in your code."
            ),

            code_block(HTML(paste(
              'x <span class="code-keyword">&lt;-</span> <span class="code-number">75</span>\n\n',
              '<span class="code-keyword">if</span> (x <span class="code-keyword">&gt;=</span> <span class="code-number">90</span>) {\n',
              '  <span class="code-function">cat</span>(<span class="code-string">"Grade: A"</span>)\n',
              '} <span class="code-keyword">else if</span> (x <span class="code-keyword">&gt;=</span> <span class="code-number">75</span>) {\n',
              '  <span class="code-function">cat</span>(<span class="code-string">"Grade: B"</span>)\n',
              '} <span class="code-keyword">else if</span> (x <span class="code-keyword">&gt;=</span> <span class="code-number">60</span>) {\n',
              '  <span class="code-function">cat</span>(<span class="code-string">"Grade: C"</span>)\n',
              '} <span class="code-keyword">else</span> {\n',
              '  <span class="code-function">cat</span>(<span class="code-string">"Grade: F"</span>)\n',
              '}\n',
              '<span class="code-output"># Grade: B</span>\n\n',
              '<span class="code-comment"># Compact: ifelse() for vectors</span>\n',
              '<span class="code-function">ifelse</span>(x <span class="code-keyword">&gt;</span> <span class="code-number">60</span>, <span class="code-string">"Pass"</span>, <span class="code-string">"Fail"</span>)',
              sep = ""
            ))),

            callout_tip("💡",
              "Use <code>ifelse(condition, yes, no)</code> when working on entire vectors —
               it's vectorized and much faster than a loop."
            ),

            tags$h5(class = "lesson-heading", "switch() Statement"),
            tags$p("Use ", tags$code("switch()"), " for multiple branches based on a single value:"),

            code_block(HTML(paste(
              'day <span class="code-keyword">&lt;-</span> <span class="code-string">"Monday"</span>\n\n',
              '<span class="code-function">switch</span>(day,\n',
              '  <span class="code-string">"Monday"</span>    = <span class="code-string">"Start of week"</span>,\n',
              '  <span class="code-string">"Friday"</span>    = <span class="code-string">"Almost weekend!"</span>,\n',
              '  <span class="code-string">"Saturday"</span>  = <span class="code-string">"Weekend!"</span>,\n',
              '  <span class="code-string">"Sunday"</span>    = <span class="code-string">"Weekend!"</span>,\n',
              '  <span class="code-string">"Weekday"</span>\n',
              ')\n',
              '<span class="code-output"># "Start of week"</span>',
              sep = ""
            )))
            ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Grade Calculator"),
            fluidRow(
              column(4,
                numericInput(ns("if_score"), "Enter a score (0–100):",
                             value = 78, min = 0, max = 100),
                actionButton(ns("btn_if"), "▶ Get Grade", class = "btn-run")
              ),
              column(4,
                selectInput(ns("if_check"), "Also check if score is:",
                  choices = c("Even or Odd" = "parity",
                              "Positive / Negative / Zero" = "sign",
                              "Above or below average (70)" = "avg")),
              ),
              column(4,
                tags$label("Output:"),
                verbatimTextOutput(ns("out_if"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 2: Loops
        # ──────────────────────────────────────────────────────
        nav_panel("Loops",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "for Loop"),
            tags$p("The ", tags$code("for"), " loop iterates over a sequence:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Print squares of 1 to 5</span>\n',
              '<span class="code-keyword">for</span> (i <span class="code-keyword">in</span> <span class="code-number">1</span>:<span class="code-number">5</span>) {\n',
              '  <span class="code-function">cat</span>(<span class="code-string">"i ="</span>, i, <span class="code-string">"  i² ="</span>, i^<span class="code-number">2</span>, <span class="code-string">"\\n"</span>)\n',
              '}\n',
              '<span class="code-comment"># Iterate over a vector</span>\n',
              'fruits <span class="code-keyword">&lt;-</span> <span class="code-function">c</span>(<span class="code-string">"apple", "mango", "grape"</span>)\n',
              '<span class="code-keyword">for</span> (f <span class="code-keyword">in</span> fruits) {\n',
              '  <span class="code-function">cat</span>(<span class="code-string">"Fruit:"</span>, f, <span class="code-string">"\\n"</span>)\n',
              '}',
              sep = ""
            ))),

            tags$h5(class = "lesson-heading", "while & repeat Loops"),
            code_block(HTML(paste(
              '<span class="code-comment"># while: repeat while condition is TRUE</span>\n',
              'n <span class="code-keyword">&lt;-</span> <span class="code-number">1</span>\n',
              '<span class="code-keyword">while</span> (n <span class="code-keyword">&lt;=</span> <span class="code-number">5</span>) {\n',
              '  <span class="code-function">cat</span>(n, <span class="code-string">" "</span>)\n',
              '  n <span class="code-keyword">&lt;-</span> n + <span class="code-number">1</span>\n',
              '}\n\n',
              '<span class="code-comment"># repeat: infinite loop (use break to exit)</span>\n',
              'count <span class="code-keyword">&lt;-</span> <span class="code-number">0</span>\n',
              '<span class="code-keyword">repeat</span> {\n',
              '  count <span class="code-keyword">&lt;-</span> count + <span class="code-number">1</span>\n',
              '  <span class="code-keyword">if</span> (count <span class="code-keyword">&gt;</span> <span class="code-number">3</span>) <span class="code-keyword">break</span>\n',
              '}',
              sep = ""
            ))),

            tags$h5(class = "lesson-heading", "break, next, and apply() Family"),
            code_block(HTML(paste(
              '<span class="code-comment"># break exits loop; next skips iteration</span>\n',
              '<span class="code-keyword">for</span> (i <span class="code-keyword">in</span> <span class="code-number">1</span>:<span class="code-number">10</span>) {\n',
              '  <span class="code-keyword">if</span> (i == <span class="code-number">4</span>) <span class="code-keyword">next</span>   <span class="code-comment"># skip 4</span>\n',
              '  <span class="code-keyword">if</span> (i == <span class="code-number">7</span>) <span class="code-keyword">break</span>   <span class="code-comment"># stop at 7</span>\n',
              '  <span class="code-function">cat</span>(i, <span class="code-string">" "</span>)\n',
              '}\n\n',
              '<span class="code-comment"># apply family: vectorized alternatives</span>\n',
              'x <span class="code-keyword">&lt;-</span> <span class="code-function">list</span>(<span class="code-number">1</span>:<span class="code-number">3</span>, <span class="code-number">4</span>:<span class="code-number">6</span>)\n',
              '<span class="code-function">lapply</span>(x, sum)    <span class="code-output"># returns list</span>\n',
              '<span class="code-function">sapply</span>(x, sum)    <span class="code-output"># simplifies to vector</span>',
              sep = ""
            )))
            ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Loop Explorer"),
            fluidRow(
              column(4,
                numericInput(ns("loop_n"), "Loop from 1 to N:", value = 8, min = 1, max = 20),
                selectInput(ns("loop_type"), "Loop shows:",
                  choices = c("Squares (i²)"    = "sq",
                              "Cubes (i³)"      = "cube",
                              "Fibonacci"       = "fib",
                              "Even numbers only" = "even",
                              "Factorial"       = "fact")),
                actionButton(ns("btn_loop"), "▶ Run Loop", class = "btn-run")
              ),
              column(8,
                tags$label("Loop Output:"),
                verbatimTextOutput(ns("out_loop"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 3: Functions
        # ──────────────────────────────────────────────────────
        nav_panel("Functions",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "Writing Your Own Functions"),
            tags$p(
              "Functions let you package reusable code. Define with ", tags$code("function()"),
              " and call with parentheses."
            ),

            code_block(HTML(paste(
              '<span class="code-comment"># Basic function with one argument</span>\n',
              'square <span class="code-keyword">&lt;-</span> <span class="code-keyword">function</span>(x) {\n',
              '  x ^ <span class="code-number">2</span>\n',
              '}\n',
              '<span class="code-function">square</span>(<span class="code-number">5</span>)  <span class="code-output"># [1] 25</span>\n\n',
              '<span class="code-comment"># Default argument values</span>\n',
              'greet <span class="code-keyword">&lt;-</span> <span class="code-keyword">function</span>(name = <span class="code-string">"Student"</span>) {\n',
              '  <span class="code-function">paste</span>(<span class="code-string">"Hello,"</span>, name)\n',
              '}\n',
              '<span class="code-function">greet</span>()            <span class="code-output"># "Hello, Student"</span>\n',
              '<span class="code-function">greet</span>(<span class="code-string">"Alice"</span>)   <span class="code-output"># "Hello, Alice"</span>\n\n',
              '<span class="code-comment"># Multiple arguments with return</span>\n',
              'bmi <span class="code-keyword">&lt;-</span> <span class="code-keyword">function</span>(weight_kg, height_m) {\n',
              '  bmi_val <span class="code-keyword">&lt;-</span> weight_kg / height_m ^ <span class="code-number">2</span>\n',
              '  <span class="code-function">round</span>(bmi_val, <span class="code-number">1</span>)\n',
              '}\n',
              '<span class="code-function">bmi</span>(<span class="code-number">70</span>, <span class="code-number">1.75</span>)    <span class="code-output"># [1] 22.9</span>',
              sep = ""
            ))),

            callout_info("ℹ️",
              "The last evaluated expression in a function is automatically returned.
               You can also use <code>return(value)</code> explicitly."
            ),

            tags$h5(class = "lesson-heading", "Recursive Functions"),
            tags$p("Functions can call themselves to solve problems recursively:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Factorial: n! = n × (n-1)!</span>\n',
              'fact <span class="code-keyword">&lt;-</span> <span class="code-keyword">function</span>(n) {\n',
              '  <span class="code-keyword">if</span> (n <span class="code-keyword">&lt;=</span> <span class="code-number">1</span>) {\n',
              '    <span class="code-number">1</span>\n',
              '  } <span class="code-keyword">else</span> {\n',
              '    n * <span class="code-function">fact</span>(n - <span class="code-number">1</span>)\n',
              '  }\n',
              '}\n',
              '<span class="code-function">fact</span>(<span class="code-number">5</span>)  <span class="code-output"># [1] 120</span>',
              sep = ""
            ))),

            tags$h5(class = "lesson-heading", "Anonymous Functions & Lambda"),
            tags$p("Use unnamed functions with ", tags$code("\\(x) expr"), " syntax (R 4.1+):"),

            code_block(HTML(paste(
              '<span class="code-comment"># Anonymous function with lapply</span>\n',
              '<span class="code-function">lapply</span>(<span class="code-function">c</span>(<span class="code-number">1, 2, 3</span>), <span class="code-keyword">\\</span>(x) x^<span class="code-number">2</span>)\n',
              '<span class="code-output"># [[1]] 1  [[2]] 4  [[3]] 9</span>\n\n',
              '<span class="code-comment"># Older syntax: function(x) x^2</span>\n',
              '<span class="code-function">sapply</span>(<span class="code-function">c</span>(<span class="code-number">1, 2, 3, 4</span>), <span class="code-keyword">function</span>(x) x %% <span class="code-number">2</span> == <span class="code-number">0</span>)\n',
              '<span class="code-output"># [1] FALSE  TRUE FALSE  TRUE</span>',
              sep = ""
            )))
            ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Build & Call a Function"),
            fluidRow(
              column(5,
                selectInput(ns("fn_type"), "Choose a function:",
                  choices = c(
                    "BMI Calculator"          = "bmi",
                    "Celsius → Fahrenheit"    = "temp",
                    "Compound Interest"       = "ci",
                    "Factorial"               = "factorial",
                    "Is Prime?"               = "prime"
                  )
                ),
                uiOutput(ns("fn_inputs_ui")),
                actionButton(ns("btn_fn2"), "▶ Call Function", class = "btn-run")
              ),
              column(7,
                tags$label("Function code & result:"),
                verbatimTextOutput(ns("out_fn2"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        )

      ) # end navset_tab
    )
  )
}

# ── Server ────────────────────────────────────────────────────
mod_controlflow_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ── If/Else ─────────────────────────────────────────────
    output$out_if <- renderText({
      req(input$btn_if)
      isolate({
        x    <- input$if_score
        chk  <- input$if_check

        grade <- if (x >= 90) "A" else if (x >= 75) "B" else if (x >= 60) "C" else "F"
        extra <- switch(chk,
          "parity" = if (x %% 2 == 0) "Even number" else "Odd number",
          "sign"   = if (x > 0) "Positive" else if (x < 0) "Negative" else "Zero",
          "avg"    = if (x > 70) "Above average" else "Below average"
        )
        paste0(
          "Score  : ", x, "\n",
          "Grade  : ", grade, "\n",
          "Extra  : ", extra, "\n",
          "Pass?  : ", if (x >= 60) "✅ Yes" else "❌ No"
        )
      })
    })

    # ── Loop ─────────────────────────────────────────────────
    output$out_loop <- renderText({
      req(input$btn_loop)
      isolate({
        n    <- max(1, min(20, input$loop_n))
        type <- input$loop_type

        lines <- switch(type,
          "sq"   = sapply(1:n, function(i) sprintf("i = %2d  |  i² = %d", i, i^2)),
          "cube" = sapply(1:n, function(i) sprintf("i = %2d  |  i³ = %d", i, i^3)),
          "even" = {
            evens <- Filter(function(i) i %% 2 == 0, 1:n)
            c(sprintf("Even numbers from 1 to %d:", n),
              paste(evens, collapse = "  "))
          },
          "fib"  = {
            a <- 0; b <- 1
            fibs <- integer(n)
            for (i in 1:n) { fibs[i] <- a; tmp <- a + b; a <- b; b <- tmp }
            c(sprintf("First %d Fibonacci numbers:", n),
              paste(fibs, collapse = "  "))
          },
          "fact" = {
            f <- 1
            rows <- character(n)
            for (i in 1:n) { f <- f * i; rows[i] <- sprintf("%d! = %d", i, f) }
            rows
          }
        )
        paste(lines, collapse = "\n")
      })
    })

    # ── Function UI inputs ────────────────────────────────────
    output$fn_inputs_ui <- renderUI({
      switch(input$fn_type,
        "bmi"      = tagList(
          numericInput(ns("fn_a"), "Weight (kg):",   value = 70, min = 1),
          numericInput(ns("fn_b"), "Height (m):",    value = 1.75, min = 0.5, step = 0.01)
        ),
        "temp"     = numericInput(ns("fn_a"), "Celsius:",       value = 25),
        "ci"       = tagList(
          numericInput(ns("fn_a"), "Principal ($):", value = 1000, min = 1),
          numericInput(ns("fn_b"), "Rate (% p.a.):", value = 5, min = 0, step = 0.1),
          numericInput(ns("fn_c"), "Years:",         value = 10, min = 1)
        ),
        "factorial"= numericInput(ns("fn_a"), "n:",              value = 7, min = 0, max = 15),
        "prime"    = numericInput(ns("fn_a"), "Check number:", value = 17, min = 2)
      )
    })

    # ── Function Result ───────────────────────────────────────
    output$out_fn2 <- renderText({
      req(input$btn_fn2, input$fn_type)
      isolate({
        type <- input$fn_type
        fn_a <- if (!is.null(input$fn_a)) input$fn_a else 0
        fn_b <- if (!is.null(input$fn_b)) input$fn_b else 1
        fn_c <- if (!is.null(input$fn_c)) input$fn_c else 1

        result_text <- switch(type,
          "bmi" = {
            w <- fn_a; h <- fn_b
            bmi <- round(w / h^2, 1)
            cat_text <- if (bmi < 18.5) "Underweight" else if (bmi < 25) "Normal" else if (bmi < 30) "Overweight" else "Obese"
            paste0(
              "bmi <- function(weight_kg, height_m) {\n",
              "  round(weight_kg / height_m^2, 1)\n}\n\n",
              "bmi(", w, ", ", h, ")  →  BMI = ", bmi, "\n",
              "Category: ", cat_text
            )
          },
          "temp" = {
            c_val <- fn_a
            f_val <- round(c_val * 9/5 + 32, 1)
            paste0(
              "celsius_to_f <- function(c) c * 9/5 + 32\n\n",
              "celsius_to_f(", c_val, ")  →  ", f_val, " °F"
            )
          },
          "ci" = {
            p <- fn_a; r <- fn_b/100; t <- fn_c
            amt <- round(p * (1 + r)^t, 2)
            paste0(
              "compound_interest <- function(p, r, t) {\n",
              "  p * (1 + r)^t\n}\n\n",
              "compound_interest(", p, ", ", r, ", ", t, ")\n",
              "→ $", format(amt, big.mark = ","), "\n",
              "→ Profit: $", format(round(amt - p, 2), big.mark = ",")
            )
          },
          "factorial" = {
            n <- max(0, fn_a)
            f <- factorial(n)
            paste0(
              "fact <- function(n) if (n <= 1) 1 else n * fact(n-1)\n\n",
              "fact(", n, ")  →  ", format(f, big.mark = ",")
            )
          },
          "prime" = {
            n <- max(2, fn_a)
            is_prime_fn <- function(x) {
              if (x < 2) return(FALSE)
              if (x == 2) return(TRUE)
              if (x %% 2 == 0) return(FALSE)
              all(x %% 2:floor(sqrt(x)) != 0)
            }
            res <- is_prime_fn(n)
            paste0(
              "is_prime <- function(n) {\n",
              "  if (n < 2) return(FALSE)\n",
              "  all(n %% 2:floor(sqrt(n)) != 0)\n}\n\n",
              "is_prime(", n, ")  →  ",
              if (res) paste0(n, " ✅ IS prime") else paste0(n, " ❌ is NOT prime")
            )
          }
        )
        result_text
      })
    })

  })
}
