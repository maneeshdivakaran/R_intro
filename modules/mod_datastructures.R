# ============================================================
# modules/mod_datastructures.R — Data Structures Module
# Topics: Vectors, Matrices, Lists, Data Frames
# ============================================================

mod_datastructures_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:960px; margin:0 auto; padding:.5rem 1rem 2rem;",

      div(class = "r-card r-card-info",
        tags$span(class = "badge-module", "Module 2"),
        tags$h3(class = "section-title", "🗂 Data Structures"),
        tags$p(class = "section-subtitle",
          "Understand R's main data containers: vectors, matrices, lists, and data frames.")
      ),

      navset_tab(

        # ──────────────────────────────────────────────────────
        # Tab 1: Vectors
        # ──────────────────────────────────────────────────────
        nav_panel("Vectors",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "What is a Vector?"),
            tags$p(
              "A vector is the most basic data structure in R — it holds a sequence of values
               of the ", tags$strong("same type"), ". Create vectors with ", tags$code("c()"), "."
            ),

            code_block(HTML(paste(
              '<span class="code-comment"># Numeric vector</span>\n',
              'scores <span class="code-keyword">&lt;-</span> <span class="code-function">c</span>(<span class="code-number">85, 92, 78, 95, 88</span>)\n\n',
              '<span class="code-comment"># Character vector</span>\n',
              'names <span class="code-keyword">&lt;-</span> <span class="code-function">c</span>(<span class="code-string">"Alice", "Bob", "Carol"</span>)\n\n',
              '<span class="code-comment"># Accessing elements (1-indexed!)</span>\n',
              'scores[<span class="code-number">1</span>]       <span class="code-output"># [1] 85</span>\n',
              'scores[<span class="code-number">2</span>:<span class="code-number">4</span>]     <span class="code-output"># [1] 92 78 95</span>\n',
              'scores[<span class="code-number">-1</span>]      <span class="code-output"># removes first element</span>\n\n',
              '<span class="code-comment"># Vector arithmetic (vectorized!)</span>\n',
              'scores + <span class="code-number">5</span>      <span class="code-output"># adds 5 to every element</span>\n',
              'scores * <span class="code-number">2</span>      <span class="code-output"># doubles every element</span>',
              sep = ""
            ))),

            callout_info("ℹ️",
              "R is <strong>1-indexed</strong> — the first element is at position <code>[1]</code>,
               unlike Python which starts at <code>[0]</code>."
            ),

            tags$h5(class = "lesson-heading", "Named Vectors"),
            tags$p(
              "Give vector elements names for easier access using the ", tags$code("="),
              " syntax within ", tags$code("c()"), "."
            ),

            code_block(HTML(paste(
              '<span class="code-comment"># Create a named vector</span>\n',
              'scores <span class="code-keyword">&lt;-</span> <span class="code-function">c</span>(math<span class="code-keyword">=</span><span class="code-number">95</span>, english<span class="code-keyword">=</span><span class="code-number">88</span>, science<span class="code-keyword">=</span><span class="code-number">92</span>)\n\n',
              '<span class="code-comment"># Access by name</span>\n',
              'scores[<span class="code-string">"math"</span>]        <span class="code-output"># [1] 95</span>\n',
              '<span class="code-function">names</span>(scores)    <span class="code-output"># [1] "math" "english" "science"</span>\n',
              'scores[<span class="code-function">c</span>(<span class="code-string">"math"</span>, <span class="code-string">"science"</span>)]  <span class="code-output"># [1] 95 92</span>',
              sep = ""
            ))
            )
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Build & Explore a Vector"),
            fluidRow(
              column(5,
                textInput(ns("vec_input"), "Enter numbers (comma-separated):",
                          value = "10, 20, 30, 40, 50"),
                numericInput(ns("vec_idx"), "Access element at index:", value = 2, min = 1),
                actionButton(ns("btn_vec"), "▶ Explore", class = "btn-run")
              ),
              column(7,
                tags$label("Vector Output:"),
                verbatimTextOutput(ns("out_vec"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 2: Matrices
        # ──────────────────────────────────────────────────────
        nav_panel("Matrices",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "What is a Matrix?"),
            tags$p(
              "A matrix is a 2-dimensional vector (rows × columns). All elements must be the same type."
            ),

            code_block(HTML(paste(
              '<span class="code-comment"># Create a 3×3 matrix</span>\n',
              'm <span class="code-keyword">&lt;-</span> <span class="code-function">matrix</span>(<span class="code-number">1</span>:<span class="code-number">9</span>, nrow = <span class="code-number">3</span>, ncol = <span class="code-number">3</span>)\n',
              'm\n',
              '<span class="code-output">#      [,1] [,2] [,3]</span>\n',
              '<span class="code-output"># [1,]    1    4    7</span>\n',
              '<span class="code-output"># [2,]    2    5    8</span>\n',
              '<span class="code-output"># [3,]    3    6    9</span>\n\n',
              '<span class="code-comment"># Access element [row, col]</span>\n',
              'm[<span class="code-number">2</span>, <span class="code-number">3</span>]     <span class="code-output"># [1] 8</span>\n',
              'm[<span class="code-number">1</span>, ]      <span class="code-output"># first row</span>\n',
              'm[ , <span class="code-number">2</span>]     <span class="code-output"># second column</span>\n\n',
              '<span class="code-comment"># Matrix info</span>\n',
              '<span class="code-function">dim</span>(m)      <span class="code-output"># [1] 3 3</span>\n',
              '<span class="code-function">nrow</span>(m)     <span class="code-output"># [1] 3</span>\n',
              '<span class="code-function">ncol</span>(m)     <span class="code-output"># [1] 3</span>',
              sep = ""
            )))
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Create a Matrix"),
            fluidRow(
              column(4,
                numericInput(ns("mat_nrow"), "Rows:", value = 3, min = 1, max = 6),
                numericInput(ns("mat_ncol"), "Cols:", value = 3, min = 1, max = 6),
                selectInput(ns("mat_fill"), "Fill with:",
                  choices = c("1:n (sequence)" = "seq",
                              "Random integers" = "rand",
                              "All zeros" = "zeros")),
                actionButton(ns("btn_mat"), "▶ Create Matrix", class = "btn-run")
              ),
              column(8,
                tags$label("Matrix Output:"),
                verbatimTextOutput(ns("out_mat"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 3: Lists
        # ──────────────────────────────────────────────────────
        nav_panel("Lists",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "What is a List?"),
            tags$p(
              "A list can hold elements of ", tags$strong("different types"), " — including other
               lists! Use ", tags$code("list()"), " to create one."
            ),

            code_block(HTML(paste(
              '<span class="code-comment"># A list with mixed types</span>\n',
              'student <span class="code-keyword">&lt;-</span> <span class="code-function">list</span>(\n',
              '  name    = <span class="code-string">"Alice"</span>,\n',
              '  age     = <span class="code-number">21</span>,\n',
              '  grades  = <span class="code-function">c</span>(<span class="code-number">85, 90, 92</span>),\n',
              '  passed  = <span class="code-keyword">TRUE</span>\n',
              ')\n\n',
              '<span class="code-comment"># Access by name ($ syntax)</span>\n',
              'student$name          <span class="code-output"># [1] "Alice"</span>\n',
              'student$grades[<span class="code-number">1</span>]    <span class="code-output"># [1] 85</span>\n\n',
              '<span class="code-comment"># Access by index [[ ]]</span>\n',
              'student[[<span class="code-number">2</span>]]         <span class="code-output"># [1] 21</span>\n\n',
              '<span class="code-comment"># List info</span>\n',
              '<span class="code-function">length</span>(student)    <span class="code-output"># [1] 4</span>\n',
              '<span class="code-function">names</span>(student)     <span class="code-output"># [1] "name" "age" "grades" "passed"</span>',
              sep = ""
            ))),

            callout_tip("💡",
              "Use <code>[[]]</code> to access a list element's actual value.
               <code>[]</code> returns a sub-list."
            ),

            tags$h5(class = "lesson-heading", "Modifying Lists"),
            tags$p("Add, remove, or replace list elements dynamically:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Add a new element</span>\n',
              'student$email <span class="code-keyword">&lt;-</span> <span class="code-string">"alice@example.com"</span>\n\n',
              '<span class="code-comment"># Remove an element (set to NULL)</span>\n',
              'student$passed <span class="code-keyword">&lt;-</span> <span class="code-keyword">NULL</span>\n\n',
              '<span class="code-comment"># Replace element</span>\n',
              'student$age <span class="code-keyword">&lt;-</span> <span class="code-number">22</span>',
              sep = ""
            )))
            ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Create a Student Profile"),
            fluidRow(
              column(5,
                textInput(ns("list_name"),  "Student name:",  value = "Bob"),
                numericInput(ns("list_age"), "Age:", value = 20, min = 10, max = 100),
                textInput(ns("list_grades"), "Grades (comma-sep):", value = "80,85,90"),
                actionButton(ns("btn_list"), "▶ Create List", class = "btn-run")
              ),
              column(7,
                tags$label("List Output:"),
                verbatimTextOutput(ns("out_list"), placeholder = TRUE) |>
                  tagAppendAttributes(class = "output-box")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 4: Data Frames
        # ──────────────────────────────────────────────────────
        nav_panel("Data Frames",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "What is a Data Frame?"),
            tags$p(
              "A data frame is like a table (spreadsheet). Each column is a vector, and
               all columns have the same length. It's the most common structure for datasets."
            ),

            code_block(HTML(paste(
              '<span class="code-comment"># Create a data frame</span>\n',
              'students <span class="code-keyword">&lt;-</span> <span class="code-function">data.frame</span>(\n',
              '  name   = <span class="code-function">c</span>(<span class="code-string">"Alice", "Bob", "Carol"</span>),\n',
              '  age    = <span class="code-function">c</span>(<span class="code-number">20, 22, 21</span>),\n',
              '  grade  = <span class="code-function">c</span>(<span class="code-string">"A", "B", "A"</span>),\n',
              '  score  = <span class="code-function">c</span>(<span class="code-number">95, 82, 91</span>)\n',
              ')\n\n',
              '<span class="code-comment"># Explore the data frame</span>\n',
              '<span class="code-function">head</span>(students)    <span class="code-output"># first 6 rows</span>\n',
              '<span class="code-function">nrow</span>(students)   <span class="code-output"># number of rows</span>\n',
              '<span class="code-function">ncol</span>(students)   <span class="code-output"># number of columns</span>\n',
              '<span class="code-function">str</span>(students)    <span class="code-output"># structure overview</span>\n',
              '<span class="code-function">summary</span>(students)<span class="code-output"># statistical summary</span>',
              sep = ""
            ))),

            tags$h5(class = "lesson-heading", "Common Data Frame Operations"),
            tags$p("Essential functions for exploring data frames:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Get structure (types and preview)</span>\n',
              '<span class="code-function">str</span>(iris)         <span class="code-output"># shows column types</span>\n\n',
              '<span class="code-comment"># Statistical summary</span>\n',
              '<span class="code-function">summary</span>(iris)     <span class="code-output"># min, max, mean, etc</span>\n\n',
              '<span class="code-comment"># View first/last rows</span>\n',
              '<span class="code-function">head</span>(iris, <span class="code-number">3</span>)      <span class="code-output"># first 3 rows</span>\n',
              '<span class="code-function">tail</span>(iris, <span class="code-number">3</span>)      <span class="code-output"># last 3 rows</span>\n\n',
              '<span class="code-comment"># Dimensions</span>\n',
              '<span class="code-function">dim</span>(iris)        <span class="code-output"># [rows, cols]</span>\n',
              '<span class="code-function">nrow</span>(iris)       <span class="code-output"># number of rows</span>\n',
              '<span class="code-function">ncol</span>(iris)       <span class="code-output"># number of columns</span>',
              sep = ""
            )))
          ),

          fluidRow(
            column(6,
              div(class = "tryit-panel",
                tags$h6("🧪 Explore the iris Dataset"),
                tags$p(style = "font-size:.85rem; margin-bottom:.6rem;",
                  "The ", tags$code("iris"), " dataset is built into R. Use the controls below:"),
                numericInput(ns("df_rows"), "Show first N rows:", value = 6, min = 1, max = 150),
                selectInput(ns("df_col"), "Summarise column:",
                  choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
                actionButton(ns("btn_df"), "▶ Explore", class = "btn-run")
              )
            ),
            column(6,
              tags$label("Output:"),
              verbatimTextOutput(ns("out_df"), placeholder = TRUE) |>
                tagAppendAttributes(class = "output-box"),
              br(),
              div(class = "r-card", style = "padding:.8rem;",
                tags$h6(style = "font-weight:600; margin-bottom:.5rem;",
                  "iris data preview:"),
                DTOutput(ns("tbl_iris"))
              )
            )
          )
        )

      ) # end navset_tab
    )
  )
}

# ── Server ────────────────────────────────────────────────────
mod_datastructures_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # ── Vector Explorer ──────────────────────────────────────
    output$out_vec <- renderText({
      req(input$btn_vec)
      isolate({
        raw  <- trimws(input$vec_input)
        idx  <- input$vec_idx
        nums <- parse_nums(raw)
        if (is.null(nums)) return("Invalid numbers.")
        code <- paste0(
          'x <- c(', paste(nums, collapse = ", "), ')\n',
          'cat("Vector     :", x, "\\n")\n',
          'cat("Length     :", length(x), "\\n")\n',
          'cat("Element[', idx, ']:", x[', idx, '], "\\n")\n',
          'cat("Sum        :", sum(x), "\\n")\n',
          'cat("Mean       :", mean(x), "\\n")\n',
          'cat("x * 2      :", x * 2)'
        )
        safe_eval(code)
      })
    })

    # ── Matrix Creator ────────────────────────────────────────
    output$out_mat <- renderText({
      req(input$btn_mat)
      isolate({
        nr   <- max(1, min(6, input$mat_nrow))
        nc   <- max(1, min(6, input$mat_ncol))
        fill <- input$mat_fill
        data_expr <- switch(fill,
          "seq"  = paste0("1:", nr * nc),
          "rand" = paste0("sample(1:99, ", nr * nc, ", replace=TRUE)"),
          "zeros"= paste0("rep(0, ", nr * nc, ")")
        )
        code <- paste0(
          'm <- matrix(', data_expr, ', nrow=', nr, ', ncol=', nc, ')\n',
          'cat("Matrix (', nr, 'x', nc, '):\\n")\n',
          'print(m)\n',
          'cat("dim:", dim(m), "\\n")\n',
          'cat("sum:", sum(m), "  mean:", round(mean(m),2))'
        )
        safe_eval(code)
      })
    })

    # ── List Creator ─────────────────────────────────────────
    output$out_list <- renderText({
      req(input$btn_list)
      isolate({
        nm     <- gsub('"', '', trimws(input$list_name))
        age    <- input$list_age
        grades_raw <- parse_nums(input$list_grades)
        if (is.null(grades_raw)) grades_raw <- c(80, 85, 90)
        grades_str <- paste(grades_raw, collapse = ", ")
        code <- paste0(
          'student <- list(\n',
          '  name   = "', nm, '",\n',
          '  age    = ', age, ',\n',
          '  grades = c(', grades_str, ')\n',
          ')\n',
          'cat("Name  :", student$name, "\\n")\n',
          'cat("Age   :", student$age, "\\n")\n',
          'cat("Grades:", student$grades, "\\n")\n',
          'cat("Avg   :", mean(student$grades), "\\n")\n',
          'cat("Class :", class(student), "\\n")\n',
          'cat("Length:", length(student))'
        )
        safe_eval(code)
      })
    })

    # ── Data Frame Explorer ───────────────────────────────────
    output$out_df <- renderText({
      req(input$btn_df)
      isolate({
        n   <- max(1, min(150, input$df_rows))
        col <- input$df_col
        safe_eval(paste0(
          'x <- iris$', col, '\n',
          'cat("Column: ', col, '\\n")\n',
          'cat("Min   :", min(x), "\\n")\n',
          'cat("Max   :", max(x), "\\n")\n',
          'cat("Mean  :", round(mean(x),3), "\\n")\n',
          'cat("Median:", median(x), "\\n")\n',
          'cat("SD    :", round(sd(x),3), "\\n")'
        ))
      })
    })

    output$tbl_iris <- renderDT({
      datatable(
        head(iris, 10),
        options = list(
          pageLength = 5,
          dom        = "tp",
          scrollX    = TRUE
        ),
        class  = "compact stripe",
        rownames = FALSE
      )
    })

  })
}
