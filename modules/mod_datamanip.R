# ============================================================
# modules/mod_datamanip.R — Data Manipulation Module
# Topics: filter, select, mutate, summarise, arrange (dplyr)
# ============================================================

mod_datamanip_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:960px; margin:0 auto; padding:.5rem 1rem 2rem;",

      div(class = "r-card r-card-purple",
        tags$span(class = "badge-module", "Module 4"),
        tags$h3(class = "section-title", "🔧 Data Manipulation with dplyr"),
        tags$p(class = "section-subtitle",
          "Use the powerful dplyr package to filter, select, transform, and summarise data frames.")
      ),

      callout_info("📦",
        "All examples use the <strong>iris</strong> and <strong>mtcars</strong> datasets,
         which come built into R. Load dplyr with <code>library(dplyr)</code>."
      ),

      navset_tab(

        # ──────────────────────────────────────────────────────
        # Tab 1: filter()
        # ──────────────────────────────────────────────────────
        nav_panel("filter()",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "filter() — Subset Rows"),
            tags$p("Keep only the rows that match a condition:"),

            code_block(HTML(paste(
              '<span class="code-keyword">library</span>(dplyr)\n\n',
              '<span class="code-comment"># Keep only setosa species</span>\n',
              'setosa <span class="code-keyword">&lt;-</span> iris <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">filter</span>(Species == <span class="code-string">"setosa"</span>)\n\n',
              '<span class="code-comment"># Multiple conditions</span>\n',
              'big_petals <span class="code-keyword">&lt;-</span> iris <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">filter</span>(Petal.Length <span class="code-keyword">&gt;</span> <span class="code-number">5</span>,\n',
              '         Sepal.Width  <span class="code-keyword">&gt;</span> <span class="code-number">3</span>)\n\n',
              '<span class="code-comment"># OR condition</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">filter</span>(Species <span class="code-keyword">%in%</span>\n',
              '  <span class="code-function">c</span>(<span class="code-string">"setosa"</span>, <span class="code-string">"virginica"</span>))',
              sep = ""
            )))
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Filter the iris Dataset"),
            fluidRow(
              column(4,
                checkboxGroupInput(ns("f_species"), "Species:",
                  choices  = c("setosa", "versicolor", "virginica"),
                  selected = c("setosa", "versicolor", "virginica")
                ),
                sliderInput(ns("f_petal"),  "Petal Length ≥:",
                  min = 1, max = 7, value = 1, step = 0.1),
                sliderInput(ns("f_sepal"),  "Sepal Width ≥:",
                  min = 2, max = 4.5, value = 2, step = 0.1),
                actionButton(ns("btn_filter"), "▶ Filter", class = "btn-run")
              ),
              column(8,
                verbatimTextOutput(ns("out_filter_summary")) |>
                  tagAppendAttributes(class = "output-box"),
                br(),
                DTOutput(ns("tbl_filter"))
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 2: select()
        # ──────────────────────────────────────────────────────
        nav_panel("select()",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "select() — Choose Columns"),
            tags$p("Keep only the columns you need:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Select specific columns</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">select</span>(Species, Sepal.Length)\n\n',
              '<span class="code-comment"># Drop columns with -</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">select</span>(-Petal.Width)\n\n',
              '<span class="code-comment"># Select columns that start with "Petal"</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">select</span>(<span class="code-function">starts_with</span>(<span class="code-string">"Petal"</span>))\n\n',
              '<span class="code-comment"># Rename while selecting</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">select</span>(Type = Species,\n',
              '               Sepal.Length)',
              sep = ""
            )))
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Select Columns from iris"),
            fluidRow(
              column(4,
                checkboxGroupInput(ns("sel_cols"), "Choose columns to keep:",
                  choices  = c("Sepal.Length", "Sepal.Width",
                               "Petal.Length", "Petal.Width", "Species"),
                  selected = c("Sepal.Length", "Petal.Length", "Species")
                ),
                actionButton(ns("btn_select"), "▶ Select", class = "btn-run")
              ),
              column(8,
                verbatimTextOutput(ns("out_select_info")) |>
                  tagAppendAttributes(class = "output-box"),
                br(),
                DTOutput(ns("tbl_select"))
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 3: mutate()
        # ──────────────────────────────────────────────────────
        nav_panel("mutate()",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "mutate() — Add / Transform Columns"),
            tags$p("Create new columns or modify existing ones:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Add a new calculated column</span>\n',
              'iris <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">mutate</span>(\n',
              '    Petal.Area = Petal.Length * Petal.Width,\n',
              '    Large      = Petal.Length <span class="code-keyword">&gt;</span> <span class="code-number">4</span>\n',
              '  )\n\n',
              '<span class="code-comment"># Use case_when for categories</span>\n',
              'iris <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">mutate</span>(\n',
              '    Size = <span class="code-function">case_when</span>(\n',
              '      Sepal.Length <span class="code-keyword">&gt;</span> <span class="code-number">6.5</span> ~ <span class="code-string">"Large"</span>,\n',
              '      Sepal.Length <span class="code-keyword">&gt;</span> <span class="code-number">5.5</span> ~ <span class="code-string">"Medium"</span>,\n',
              '      <span class="code-keyword">TRUE</span>                 ~ <span class="code-string">"Small"</span>\n',
              '    )\n',
              '  )',
              sep = ""
            )))
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Add a Calculated Column"),
            fluidRow(
              column(4,
                selectInput(ns("mut_col1"), "Column A:",
                  choices = c("Sepal.Length", "Sepal.Width",
                              "Petal.Length", "Petal.Width"),
                  selected = "Petal.Length"),
                selectInput(ns("mut_op"), "Operation:",
                  choices = c("Multiply (*)" = "*",
                              "Add (+)"      = "+",
                              "Divide (/)"   = "/",
                              "Subtract (-)" = "-")),
                selectInput(ns("mut_col2"), "Column B:",
                  choices = c("Sepal.Length", "Sepal.Width",
                              "Petal.Length", "Petal.Width"),
                  selected = "Petal.Width"),
                textInput(ns("mut_newname"), "New column name:", value = "New_Column"),
                actionButton(ns("btn_mutate"), "▶ mutate()", class = "btn-run")
              ),
              column(8,
                verbatimTextOutput(ns("out_mutate_info")) |>
                  tagAppendAttributes(class = "output-box"),
                br(),
                DTOutput(ns("tbl_mutate"))
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 4: group_by + summarise
        # ──────────────────────────────────────────────────────
        nav_panel("group_by + summarise()",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "group_by() + summarise() — Aggregate Data"),
            tags$p("Group rows and compute summaries per group:"),

            code_block(HTML(paste(
              'iris <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">group_by</span>(Species) <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">summarise</span>(\n',
              '    count        = <span class="code-function">n</span>(),\n',
              '    mean_sepal   = <span class="code-function">mean</span>(Sepal.Length),\n',
              '    mean_petal   = <span class="code-function">mean</span>(Petal.Length),\n',
              '    max_sepal    = <span class="code-function">max</span>(Sepal.Length)\n',
              '  )\n\n',
              '<span class="code-comment"># Multiple groups</span>\n',
              'mtcars <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">group_by</span>(cyl, am) <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">summarise</span>(avg_mpg = <span class="code-function">mean</span>(mpg))',
              sep = ""
            )))
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Summarise iris by Species"),
            fluidRow(
              column(4,
                checkboxGroupInput(ns("sum_vars"), "Summarise these columns:",
                  choices  = c("Sepal.Length", "Sepal.Width",
                               "Petal.Length", "Petal.Width"),
                  selected = c("Sepal.Length", "Petal.Length")
                ),
                checkboxGroupInput(ns("sum_fns"), "Using these functions:",
                  choices  = c("mean", "median", "sd", "min", "max"),
                  selected = c("mean", "sd")
                ),
                actionButton(ns("btn_summ"), "▶ Summarise", class = "btn-run")
              ),
              column(8,
                DTOutput(ns("tbl_summ"))
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 5: arrange()
        # ──────────────────────────────────────────────────────
        nav_panel("arrange()",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "arrange() — Sort Rows"),
            tags$p("Sort data by one or more columns:"),

            code_block(HTML(paste(
              '<span class="code-comment"># Sort ascending (default)</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">arrange</span>(Sepal.Length)\n\n',
              '<span class="code-comment"># Sort descending</span>\n',
              'iris <span class="code-keyword">|&gt;</span> <span class="code-function">arrange</span>(<span class="code-function">desc</span>(Petal.Length))\n\n',
              '<span class="code-comment"># Sort by multiple columns</span>\n',
              'iris <span class="code-keyword">|&gt;</span>\n',
              '  <span class="code-function">arrange</span>(Species, <span class="code-function">desc</span>(Sepal.Length))',
              sep = ""
            )))
          ),

          div(class = "tryit-panel",
            tags$h6("🧪 Try It: Sort the iris Dataset"),
            fluidRow(
              column(4,
                selectInput(ns("arr_col"), "Sort by column:",
                  choices = c("Sepal.Length", "Sepal.Width",
                              "Petal.Length", "Petal.Width", "Species")),
                selectInput(ns("arr_dir"), "Direction:",
                  choices = c("Ascending" = "asc", "Descending" = "desc")),
                numericInput(ns("arr_n"), "Show top N rows:", value = 10, min = 1, max = 150),
                actionButton(ns("btn_arr"), "▶ arrange()", class = "btn-run")
              ),
              column(8,
                verbatimTextOutput(ns("out_arr_info")) |>
                  tagAppendAttributes(class = "output-box"),
                br(),
                DTOutput(ns("tbl_arr"))
              )
            )
          )
        )

      ) # end navset_tab
    )
  )
}

# ── Server ────────────────────────────────────────────────────
mod_datamanip_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # ── filter() ─────────────────────────────────────────────
    filtered_data <- eventReactive(input$btn_filter, {
      req(input$f_species)
      iris |>
        filter(Species %in% input$f_species,
               Petal.Length >= input$f_petal,
               Sepal.Width  >= input$f_sepal)
    }, ignoreNULL = FALSE)

    output$out_filter_summary <- renderText({
      df <- filtered_data()
      paste0("Rows returned: ", nrow(df), " of ", nrow(iris))
    })

    output$tbl_filter <- renderDT({
      datatable(filtered_data(),
        options = list(pageLength = 5, scrollX = TRUE, dom = "tip"),
        class = "compact stripe", rownames = FALSE)
    })

    # ── select() ─────────────────────────────────────────────
    selected_data <- eventReactive(input$btn_select, {
      req(length(input$sel_cols) > 0)
      iris[, input$sel_cols, drop = FALSE]
    }, ignoreNULL = FALSE)

    output$out_select_info <- renderText({
      df <- selected_data()
      paste0("Columns: ", paste(names(df), collapse = ", "),
             "\nRows: ", nrow(df))
    })

    output$tbl_select <- renderDT({
      datatable(head(selected_data(), 20),
        options = list(pageLength = 5, scrollX = TRUE, dom = "tip"),
        class = "compact stripe", rownames = FALSE)
    })

    # ── mutate() ─────────────────────────────────────────────
    mutated_data <- eventReactive(input$btn_mutate, {
      col1 <- input$mut_col1
      col2 <- input$mut_col2
      op   <- input$mut_op
      nm   <- make.names(input$mut_newname)
      df   <- iris
      new_col <- switch(op,
        "*" = df[[col1]] * df[[col2]],
        "+" = df[[col1]] + df[[col2]],
        "/" = df[[col1]] / df[[col2]],
        "-" = df[[col1]] - df[[col2]]
      )
      df[[nm]] <- round(new_col, 3)
      df
    }, ignoreNULL = FALSE)

    output$out_mutate_info <- renderText({
      df  <- mutated_data()
      nm  <- make.names(input$mut_newname)
      new <- df[[nm]]
      paste0("New column '", nm, "' added.\n",
             "Min: ", round(min(new),3),
             "  Max: ",  round(max(new),3),
             "  Mean: ", round(mean(new),3))
    })

    output$tbl_mutate <- renderDT({
      df <- mutated_data()
      datatable(head(df, 15),
        options = list(pageLength = 5, scrollX = TRUE, dom = "tip"),
        class = "compact stripe", rownames = FALSE)
    })

    # ── summarise() ──────────────────────────────────────────
    output$tbl_summ <- renderDT({
      req(input$btn_summ)
      req(length(input$sum_vars) > 0, length(input$sum_fns) > 0)

      fns  <- input$sum_fns
      vars <- input$sum_vars

      # Build a named list of function references
      fn_list        <- lapply(fns, match.fun)
      names(fn_list) <- fns

      result <- tryCatch({
        iris |>
          dplyr::group_by(Species) |>
          dplyr::summarise(
            dplyr::across(dplyr::all_of(vars), fn_list, .names = "{.col}_{.fn}"),
            .groups = "drop"
          )
      }, error = function(e) {
        # Fallback: manual summarise if across fails
        rows <- lapply(levels(iris$Species), function(sp) {
          sub_df <- iris[iris$Species == sp, vars, drop=FALSE]
          res <- data.frame(Species=sp, stringsAsFactors=FALSE)
          for (v in vars) for (f in fns) {
            res[[paste0(v,"_",f)]] <- round(do.call(match.fun(f), list(sub_df[[v]])), 3)
          }
          res
        })
        do.call(rbind, rows)
      })

      num_cols <- which(sapply(result, is.numeric))
      dt <- datatable(result,
        options = list(scrollX = TRUE, dom = "t"),
        class = "compact stripe", rownames = FALSE)
      if (length(num_cols) > 0) dt <- formatRound(dt, columns = num_cols, digits = 3)
      dt
    })

    # ── arrange() ────────────────────────────────────────────
    arranged_data <- eventReactive(input$btn_arr, {
      col <- input$arr_col
      dir <- input$arr_dir
      n   <- max(1, min(150, input$arr_n))
      df  <- if (dir == "desc") iris[order(-rank(iris[[col]])), ]
             else iris[order(iris[[col]]), ]
      head(df, n)
    }, ignoreNULL = FALSE)

    output$out_arr_info <- renderText({
      df  <- arranged_data()
      col <- input$arr_col
      dir <- input$arr_dir
      paste0("Sorted by: ", col, " (", dir, ")\n",
             "Showing: ", nrow(df), " rows")
    })

    output$tbl_arr <- renderDT({
      datatable(arranged_data(),
        options = list(pageLength = 5, scrollX = TRUE, dom = "tip"),
        class = "compact stripe", rownames = FALSE)
    })

  })
}
