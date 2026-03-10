# ============================================================
# modules/mod_basics.R — R Basics Module
# Topics: Variables, Data Types, Operators, Functions
# ============================================================

mod_basics_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:960px; margin:0 auto; padding:.5rem 1rem 2rem;",

      # ── Header ───────────────────────────────────────────────
      div(class = "r-card r-card-primary",
        tags$span(class = "badge-module", "Module 1"),
        tags$h3(class = "section-title", "📘 R Basics"),
        tags$p(class = "section-subtitle",
          "Learn the fundamental building blocks of R: variables, data types, operators, and built-in functions.")
      ),

      # ── Sub-Tabs ──────────────────────────────────────────────
      navset_tab(

        # ──────────────────────────────────────────────────────
        # Tab 1: Variables
        # ──────────────────────────────────────────────────────
        nav_panel("Variables & Assignment",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "What is a Variable?"),
            tags$p(
              "A variable stores a value so you can reuse it later. In R, you assign values
               using the ", tags$code("<-"), " operator (preferred) or ", tags$code("="), "."
            ),

            code_block(
              HTML(paste(
                '<span class="code-comment"># Assigning a number</span>\n',
                '<span class="code-function">age</span> <span class="code-keyword">&lt;-</span> <span class="code-number">21</span>\n\n',
                '<span class="code-comment"># Assigning text (a string)</span>\n',
                '<span class="code-function">name</span> <span class="code-keyword">&lt;-</span> <span class="code-string">"Alice"</span>\n\n',
                '<span class="code-comment"># Assigning a TRUE/FALSE (logical)</span>\n',
                '<span class="code-function">is_student</span> <span class="code-keyword">&lt;-</span> <span class="code-keyword">TRUE</span>\n\n',
                '<span class="code-comment"># Print a variable</span>\n',
                '<span class="code-function">print</span>(name)  <span class="code-output"># [1] "Alice"</span>',
                sep = ""
              ))
            ),

            callout_tip("💡",
              "<strong>Convention:</strong> Use <code>snake_case</code> for variable names
               (e.g., <code>my_age</code>, <code>student_name</code>). Avoid starting names
               with a number."
            ),

            tags$h5(class = "lesson-heading", "Viewing Variables"),
            tags$p(
              "Type a variable name and press Enter to print it. Use ",
              tags$code("ls()"), " to list all variables, and ",
              tags$code("rm(x)"), " to delete one."
            ),

            code_block(
              HTML(paste(
                'x <span class="code-keyword">&lt;-</span> <span class="code-number">42</span>\n',
                'x           <span class="code-output"># [1] 42</span>\n',
                '<span class="code-function">ls</span>()        <span class="code-output"># lists all objects</span>\n',
                '<span class="code-function">rm</span>(x)       <span class="code-output"># removes x</span>',
                sep = ""
              ))
            ),

            tags$h5(class = "lesson-heading", "Multiple Assignment & Scoping"),
            tags$p(
              "Assign to multiple variables at once, or use ", tags$code("<<-"),
              " for global assignment (rarely needed)."
            ),

            code_block(
              HTML(paste(
                '<span class="code-comment"># Assign same value to multiple variables</span>\n',
                'x <span class="code-keyword">&lt;-</span> y <span class="code-keyword">&lt;-</span> <span class="code-number">10</span>\n\n',
                '<span class="code-comment"># Global assignment (<<-) reaches parent scope</span>\n',
                'f <span class="code-keyword">&lt;-</span> <span class="code-keyword">function</span>() {\n',
                '  my_global <span class="code-keyword">&lt;&lt;-</span> <span class="code-number">99</span>\n',
                '}\n',
                '<span class="code-function">f</span>()    <span class="code-output"># my_global now exists outside f()</span>',
                sep = ""
              ))
            )
          ),

          # ── Try It: Variables ─────────────────────────────────
          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Assign & Print a Variable"),
            fluidRow(
              column(4,
                textInput(ns("var_name"), "Variable Name:", value = "my_var", placeholder = "e.g. age"),
                numericInput(ns("var_value"), "Numeric Value:", value = 25, min = -1e6, max = 1e6)
              ),
              column(4,
                textInput(ns("var_text"), "Or Text Value:", value = "", placeholder = "e.g. Hello"),
                tags$br(),
                actionButton(ns("btn_var"), "▶ Assign & Print", class = "btn-run")
              ),
              column(4,
                tags$label("Output:"),
                verbatimTextOutput(ns("out_var"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 2: Data Types
        # ──────────────────────────────────────────────────────
        nav_panel("Data Types",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "R's Core Data Types"),
            tags$p("Every value in R has a type. The main types are:"),

            fluidRow(
              lapply(list(
                list("🔢", "Numeric",   "42, 3.14, -7.5",        "#DBEAFE", "#2563EB"),
                list("📝", "Character", '"Hello", "R is fun"',    "#F3E8FF", "#7C3AED"),
                list("☑️", "Logical",   "TRUE, FALSE",            "#D1FAE5", "#16A34A"),
                list("🔬", "Integer",   "1L, 100L, -5L",          "#FEF3C7", "#D97706"),
                list("🔢", "Complex",   "3+2i, 1i",               "#FCE7F3", "#DB2777"),
                list("❓", "NULL/NA",   "NULL, NA, NaN, Inf",     "#F1F5F9", "#64748B")
              ), function(t) {
                column(4, style = "margin-bottom:.75rem;",
                  div(
                    style = sprintf("background:%s; border:1px solid %s; border-radius:10px;
                                    padding:.85rem; text-align:center;", t[[4]], t[[5]]),
                    div(style = "font-size:1.5rem;", t[[1]]),
                    tags$strong(style = sprintf("color:%s; font-size:.9rem;", t[[5]]), t[[2]]),
                    tags$br(),
                    tags$code(style = "font-size:.78rem;", t[[3]])
                  )
                )
              })
            ),

            code_block(
              HTML(paste(
                '<span class="code-function">class</span>(<span class="code-number">42</span>)       <span class="code-output"># "numeric"</span>\n',
                '<span class="code-function">class</span>(<span class="code-string">"hello"</span>) <span class="code-output"># "character"</span>\n',
                '<span class="code-function">class</span>(<span class="code-keyword">TRUE</span>)     <span class="code-output"># "logical"</span>\n',
                '<span class="code-function">class</span>(<span class="code-number">5L</span>)       <span class="code-output"># "integer"</span>\n',
                '<span class="code-function">is.numeric</span>(<span class="code-number">3.14</span>)   <span class="code-output"># TRUE</span>\n',
                '<span class="code-function">as.character</span>(<span class="code-number">99</span>) <span class="code-output"># "99"  — type conversion</span>',
                sep = ""
              ))
            ),

            tags$h5(class = "lesson-heading", "Type Coercion"),
            tags$p(
              "Convert between types using ", tags$code("as.numeric()"), ", ",
              tags$code("as.character()"), ", ", tags$code("as.logical()"), ", etc."
            ),

            code_block(
              HTML(paste(
                '<span class="code-comment"># Convert to numeric</span>\n',
                '<span class="code-function">as.numeric</span>(<span class="code-string">"3.14"</span>)  <span class="code-output"># [1] 3.14</span>\n\n',
                '<span class="code-comment"># Convert to character</span>\n',
                '<span class="code-function">as.character</span>(<span class="code-number">99</span>)   <span class="code-output"># [1] "99"</span>\n\n',
                '<span class="code-comment"># Convert to logical</span>\n',
                '<span class="code-function">as.logical</span>(<span class="code-number">1</span>)     <span class="code-output"># [1] TRUE</span>\n',
                '<span class="code-function">as.logical</span>(<span class="code-number">0</span>)     <span class="code-output"># [1] FALSE</span>',
                sep = ""
              ))
            )
          ),

          # ── Try It: Type Checker ──────────────────────────────
          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Check a Data Type"),
            fluidRow(
              column(5,
                textInput(ns("type_input"), "Enter any R value:", value = "42",
                          placeholder = 'e.g.  "hello" or TRUE or 5L'),
                actionButton(ns("btn_type"), "🔍 Check Type", class = "btn-run")
              ),
              column(7,
                tags$label("class() & typeof() result:"),
                verbatimTextOutput(ns("out_type"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 3: Operators
        # ──────────────────────────────────────────────────────
        nav_panel("Operators",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "Arithmetic Operators"),
            fluidRow(
              column(6,
                tags$table(
                  class = "table table-sm",
                  style = "font-size:.88rem;",
                  tags$thead(tags$tr(tags$th("Operator"), tags$th("Meaning"), tags$th("Example"))),
                  tags$tbody(
                    tags$tr(tags$td(tags$code("+")),  tags$td("Addition"),        tags$td("5 + 3 → 8")),
                    tags$tr(tags$td(tags$code("-")),  tags$td("Subtraction"),     tags$td("10 - 4 → 6")),
                    tags$tr(tags$td(tags$code("*")),  tags$td("Multiplication"),  tags$td("3 * 4 → 12")),
                    tags$tr(tags$td(tags$code("/")),  tags$td("Division"),        tags$td("9 / 2 → 4.5")),
                    tags$tr(tags$td(tags$code("^")),  tags$td("Power"),           tags$td("2 ^ 3 → 8")),
                    tags$tr(tags$td(tags$code("%%")), tags$td("Modulo (remainder)"), tags$td("7 %% 3 → 1")),
                    tags$tr(tags$td(tags$code("%/%")),tags$td("Integer division"), tags$td("7 %/% 3 → 2"))
                  )
                )
              ),
              column(6,
                tags$h5(class = "lesson-heading", "Comparison & Logical Operators"),
                tags$table(
                  class = "table table-sm",
                  style = "font-size:.88rem;",
                  tags$thead(tags$tr(tags$th("Operator"), tags$th("Meaning"))),
                  tags$tbody(
                    tags$tr(tags$td(tags$code("=="))  , tags$td("Equal to")),
                    tags$tr(tags$td(tags$code("!="))  , tags$td("Not equal")),
                    tags$tr(tags$td(tags$code(">"))   , tags$td("Greater than")),
                    tags$tr(tags$td(tags$code("<"))   , tags$td("Less than")),
                    tags$tr(tags$td(tags$code(">="))  , tags$td("Greater or equal")),
                    tags$tr(tags$td(tags$code("&"))   , tags$td("AND (elementwise)")),
                    tags$tr(tags$td(tags$code("|"))   , tags$td("OR (elementwise)")),
                    tags$tr(tags$td(tags$code("!"))   , tags$td("NOT"))
                  )
                )
              )
            ),

            tags$h5(class = "lesson-heading", "String Operators"),
            tags$p(
              "Combine strings with ", tags$code("paste()"), ", ", tags$code("paste0()"),
              ", and format with ", tags$code("sprintf()"), "."
            ),

            code_block(
              HTML(paste(
                '<span class="code-comment"># Combine strings with spaces</span>\n',
                '<span class="code-function">paste</span>(<span class="code-string">"Hello"</span>, <span class="code-string">"World"</span>)  <span class="code-output"># "Hello World"</span>\n\n',
                '<span class="code-comment"># Combine without spaces</span>\n',
                '<span class="code-function">paste0</span>(<span class="code-string">"Hello"</span>, <span class="code-string">"World"</span>)   <span class="code-output"># "HelloWorld"</span>\n\n',
                '<span class="code-comment"># Format strings with sprintf</span>\n',
                '<span class="code-function">sprintf</span>(<span class="code-string">"Pi is %.2f"</span>, <span class="code-number">3.14159</span>)  <span class="code-output"># "Pi is 3.14"</span>',
                sep = ""
              ))
            )
          ),

          # ── Try It: Calculator ────────────────────────────────
          div(class = "tryit-panel",
            tags$h6("🧮 Try It: R Calculator"),
            fluidRow(
              column(3,
                numericInput(ns("calc_a"), "Value A:", value = 10)
              ),
              column(3,
                selectInput(ns("calc_op"), "Operator:",
                  choices = c("+" = "+", "-" = "-", "*" = "*",
                              "/" = "/", "^" = "^", "%%" = "%%", "%/%" = "%/%"))
              ),
              column(3,
                numericInput(ns("calc_b"), "Value B:", value = 3),
                actionButton(ns("btn_calc"), "▶ Calculate", class = "btn-run")
              ),
              column(3,
                tags$label("Result:"),
                verbatimTextOutput(ns("out_calc"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 4: Built-in Functions
        # ──────────────────────────────────────────────────────
        nav_panel("Built-in Functions",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "Commonly Used Functions"),
            tags$p("R comes with hundreds of useful built-in functions:"),

            fluidRow(
              column(6,
                tags$table(
                  class = "table table-sm",
                  style = "font-size:.86rem;",
                  tags$thead(tags$tr(tags$th("Function"), tags$th("What it does"))),
                  tags$tbody(
                    tags$tr(tags$td(tags$code("print(x)")),     tags$td("Display value")),
                    tags$tr(tags$td(tags$code("sum(x)")),       tags$td("Sum of values")),
                    tags$tr(tags$td(tags$code("mean(x)")),      tags$td("Average")),
                    tags$tr(tags$td(tags$code("min(x) / max(x)")), tags$td("Minimum / maximum")),
                    tags$tr(tags$td(tags$code("length(x)")),    tags$td("Number of elements")),
                    tags$tr(tags$td(tags$code("sqrt(x)")),      tags$td("Square root")),
                    tags$tr(tags$td(tags$code("abs(x)")),       tags$td("Absolute value")),
                    tags$tr(tags$td(tags$code("round(x, n)")),  tags$td("Round to n decimals")),
                    tags$tr(tags$td(tags$code("nchar(s)")),     tags$td("Number of characters")),
                    tags$tr(tags$td(tags$code("toupper(s)")),   tags$td("Convert to uppercase"))
                  )
                )
              ),
              column(6,
                code_block(
                  HTML(paste(
                    'x <span class="code-keyword">&lt;-</span> <span class="code-function">c</span>(<span class="code-number">4, 9, 16, 25</span>)\n\n',
                    '<span class="code-function">sum</span>(x)      <span class="code-output"># [1] 54</span>\n',
                    '<span class="code-function">mean</span>(x)     <span class="code-output"># [1] 13.5</span>\n',
                    '<span class="code-function">sqrt</span>(x)     <span class="code-output"># [1]  2  3  4  5</span>\n',
                    '<span class="code-function">max</span>(x)      <span class="code-output"># [1] 25</span>\n',
                    '<span class="code-function">length</span>(x)   <span class="code-output"># [1] 4</span>\n\n',
                    's <span class="code-keyword">&lt;-</span> <span class="code-string">"Hello, R!"</span>\n',
                    '<span class="code-function">nchar</span>(s)    <span class="code-output"># [1] 9</span>\n',
                    '<span class="code-function">toupper</span>(s)  <span class="code-output"># [1] "HELLO, R!"</span>',
                    sep = ""
                  ))
                )
              )
            ),

            tags$h5(class = "lesson-heading", "Math Functions"),
            tags$p("Common mathematical operations and transformations:"),

            code_block(
              HTML(paste(
                '<span class="code-function">round</span>(<span class="code-number">3.7</span>)      <span class="code-output"># [1] 4</span>\n',
                '<span class="code-function">ceiling</span>(<span class="code-number">3.2</span>)    <span class="code-output"># [1] 4 — round up</span>\n',
                '<span class="code-function">floor</span>(<span class="code-number">3.9</span>)      <span class="code-output"># [1] 3 — round down</span>\n',
                '<span class="code-function">log</span>(<span class="code-number">10</span>)        <span class="code-output"># natural log</span>\n',
                '<span class="code-function">log10</span>(<span class="code-number">100</span>)     <span class="code-output"># [1] 2</span>\n',
                '<span class="code-function">exp</span>(<span class="code-number">1</span>)        <span class="code-output"># e ≈ 2.718</span>',
                sep = ""
              ))
            )
          ),

          # ── Try It: Stats Explorer ────────────────────────────
          div(class = "tryit-panel",
            tags$h6("📊 Try It: Explore Functions on a Vector"),
            fluidRow(
              column(6,
                textInput(ns("fn_vector"), "Enter numbers (comma-separated):",
                          value = "4, 9, 15, 16, 23, 42"),
                actionButton(ns("btn_fn"), "▶ Compute Stats", class = "btn-run")
              ),
              column(6,
                tags$label("Summary Output:"),
                verbatimTextOutput(ns("out_fn"), placeholder = TRUE) |>
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
mod_basics_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # ── Variable Assignment ──────────────────────────────────
    output$out_var <- renderText({
      req(input$btn_var)
      isolate({
        nm  <- trimws(input$var_name)
        val <- if (nchar(trimws(input$var_text)) > 0) {
          as.character(input$var_text)
        } else {
          as.character(input$var_value)
        }
        code <- paste0(nm, " <- ", if (nchar(trimws(input$var_text)) > 0) paste0('"', val, '"') else val, "\n", "print(", nm, ")")
        safe_eval(code)
      })
    })

    # ── Type Checker ─────────────────────────────────────────
    output$out_type <- renderText({
      req(input$btn_type)
      isolate({
        val <- trimws(input$type_input)
        if (nchar(val) == 0) return("Please enter a value.")
        code <- paste0('x <- ', val, '\n',
                       'cat("Value  :", deparse(x), "\\n")\n',
                       'cat("class():", class(x), "\\n")\n',
                       'cat("typeof():", typeof(x), "\\n")')
        safe_eval(code)
      })
    })

    # ── Calculator ───────────────────────────────────────────
    output$out_calc <- renderText({
      req(input$btn_calc)
      isolate({
        a  <- input$calc_a
        b  <- input$calc_b
        op <- input$calc_op
        code <- paste0(a, " ", op, " ", b)
        result <- safe_eval(code)
        paste0(a, " ", op, " ", b, " = ", result)
      })
    })

    # ── Stats Explorer ───────────────────────────────────────
    output$out_fn <- renderText({
      req(input$btn_fn)
      isolate({
        raw  <- trimws(input$fn_vector)
        nums <- parse_nums(raw)
        if (is.null(nums)) {
          return("Invalid input. Please enter comma-separated numbers.")
        }
        code <- paste0(
          'x <- c(', paste(nums, collapse = ", "), ')\n',
          'cat("Vector  :", x, "\\n")\n',
          'cat("Length  :", length(x), "\\n")\n',
          'cat("Sum     :", sum(x), "\\n")\n',
          'cat("Mean    :", mean(x), "\\n")\n',
          'cat("Min     :", min(x), "\\n")\n',
          'cat("Max     :", max(x), "\\n")\n',
          'cat("Sqrt(x) :", sqrt(x))'
        )
        safe_eval(code)
      })
    })

  })
}
