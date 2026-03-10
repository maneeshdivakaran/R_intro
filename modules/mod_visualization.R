# ============================================================
# modules/mod_visualization.R — Data Visualization Module
# Topics: ggplot2 — scatter, bar, histogram, boxplot, line
# ============================================================

mod_visualization_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(style = "max-width:1000px; margin:0 auto; padding:.5rem 1rem 2rem;",

      div(class = "r-card r-card-success",
        tags$span(class = "badge-module", "Module 5"),
        tags$h3(class = "section-title", "📊 Data Visualization with ggplot2"),
        tags$p(class = "section-subtitle",
          "Create beautiful, informative charts using the ggplot2 package — R's gold standard for visualization.")
      ),

      # ── ggplot2 Basics Explanation ──────────────────────────
      div(class = "r-card",
        tags$h5(class = "lesson-heading", "How ggplot2 Works"),
        tags$p("ggplot2 uses a ", tags$strong('"Grammar of Graphics"'),
               " — you build plots in layers:"),

        fluidRow(
          column(6,
            code_block(HTML(paste(
              '<span class="code-keyword">library</span>(ggplot2)\n\n',
              '<span class="code-comment"># Template</span>\n',
              '<span class="code-function">ggplot</span>(data = <em>dataset</em>,\n',
              '       aes(x = <em>x_var</em>, y = <em>y_var</em>)) +\n',
              '  <span class="code-function">geom_XXX</span>()  +  <span class="code-comment"># the plot type</span>\n',
              '  <span class="code-function">labs</span>(title = <span class="code-string">"My Chart"</span>) +\n',
              '  <span class="code-function">theme_minimal</span>()',
              sep = ""
            )))
          ),
          column(6,
            tags$table(
              class = "table table-sm",
              style = "font-size:.86rem;",
              tags$thead(tags$tr(tags$th("Geom"), tags$th("Chart Type"))),
              tags$tbody(
                tags$tr(tags$td(tags$code("geom_point()")),     tags$td("Scatter plot")),
                tags$tr(tags$td(tags$code("geom_bar()")),       tags$td("Bar chart")),
                tags$tr(tags$td(tags$code("geom_histogram()")), tags$td("Histogram")),
                tags$tr(tags$td(tags$code("geom_boxplot()")),   tags$td("Box plot")),
                tags$tr(tags$td(tags$code("geom_line()")),      tags$td("Line chart")),
                tags$tr(tags$td(tags$code("geom_density()")),   tags$td("Density curve"))
              )
            )
          )
        )
      ),

      navset_tab(

        # ──────────────────────────────────────────────────────
        # Tab 1: Interactive Plot Builder
        # ──────────────────────────────────────────────────────
        nav_panel("🎨 Interactive Plot Builder",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "Build Any Plot — Live"),
            tags$p("Configure the chart below and see the result instantly.")
          ),

          fluidRow(
            # Left Controls
            column(3,
              div(class = "r-card", style = "padding:1rem;",
                tags$h6(style = "font-weight:700; margin-bottom:.8rem;", "⚙️ Controls"),

                selectInput(ns("plot_dataset"), "Dataset:",
                  choices = c("iris", "mtcars")),

                selectInput(ns("plot_type"), "Chart Type:",
                  choices = c(
                    "Scatter Plot"     = "scatter",
                    "Bar Chart"        = "bar",
                    "Histogram"        = "histogram",
                    "Box Plot"         = "boxplot",
                    "Density Plot"     = "density",
                    "Line Chart"       = "line"
                  )),

                uiOutput(ns("plot_axis_ui")),

                selectInput(ns("plot_color"), "Color by:",
                  choices = c("None" = "none")),

                selectInput(ns("plot_theme"), "Theme:",
                  choices = c(
                    "Minimal"     = "minimal",
                    "Classic"     = "classic",
                    "Light"       = "light",
                    "Dark"        = "dark",
                    "BW"          = "bw"
                  )),

                textInput(ns("plot_title"), "Chart Title:", value = "My R Chart"),

                checkboxInput(ns("plot_smooth"), "Add trend line", value = FALSE)
              )
            ),

            # Right: Plot + Code
            column(9,
              plotOutput(ns("main_plot"), height = "420px"),
              br(),
              div(class = "r-card", style = "padding:.8rem;",
                tags$h6(style = "font-weight:600; margin-bottom:.4rem;",
                  "📋 Generated Code:"),
                verbatimTextOutput(ns("plot_code")) |>
                  tagAppendAttributes(
                    style = "background:#1E293B; color:#A7F3D0; font-family:monospace;
                             font-size:.8rem; padding:.8rem; border-radius:8px;"
                  )
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 2: Scatter Plot Lesson
        # ──────────────────────────────────────────────────────
        nav_panel("Scatter Plot",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "geom_point() — Scatter Plot"),
            tags$p("Show the relationship between two numeric variables:"),
            code_block(HTML(paste(
              '<span class="code-function">ggplot</span>(iris, <span class="code-function">aes</span>(x = Sepal.Length,\n',
              '              y = Petal.Length,\n',
              '              color = Species)) +\n',
              '  <span class="code-function">geom_point</span>(size = <span class="code-number">2.5</span>, alpha = <span class="code-number">0.7</span>) +\n',
              '  <span class="code-function">geom_smooth</span>(method = <span class="code-string">"lm"</span>, se = <span class="code-keyword">FALSE</span>) +\n',
              '  <span class="code-function">labs</span>(title = <span class="code-string">"Sepal vs Petal Length"</span>,\n',
              '       x = <span class="code-string">"Sepal Length"</span>,\n',
              '       y = <span class="code-string">"Petal Length"</span>) +\n',
              '  <span class="code-function">theme_minimal</span>()',
              sep = ""
            )))
          ),
          div(class = "r-card",
            plotOutput(ns("scatter_plot"), height = "380px")
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 3: Bar Chart Lesson
        # ──────────────────────────────────────────────────────
        nav_panel("Bar Chart",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "geom_bar() / geom_col() — Bar Charts"),
            code_block(HTML(paste(
              '<span class="code-comment"># Count bars (automatic)</span>\n',
              '<span class="code-function">ggplot</span>(iris, <span class="code-function">aes</span>(x = Species,\n',
              '              fill = Species)) +\n',
              '  <span class="code-function">geom_bar</span>() +\n',
              '  <span class="code-function">labs</span>(title = <span class="code-string">"Count per Species"</span>) +\n',
              '  <span class="code-function">theme_minimal</span>() +\n',
              '  <span class="code-function">scale_fill_brewer</span>(palette = <span class="code-string">"Set2"</span>)',
              sep = ""
            )))
          ),
          div(class = "r-card",
            fluidRow(
              column(4,
                selectInput(ns("bar_var"), "Y variable (mean):",
                  choices = c("Sepal.Length", "Sepal.Width",
                              "Petal.Length", "Petal.Width"),
                  selected = "Sepal.Length"),
                actionButton(ns("btn_bar"), "▶ Update Chart", class = "btn-run")
              ),
              column(8,
                plotOutput(ns("bar_plot"), height = "340px")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 4: Histogram
        # ──────────────────────────────────────────────────────
        nav_panel("Histogram",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "geom_histogram() — Distribution"),
            code_block(HTML(paste(
              '<span class="code-function">ggplot</span>(iris, <span class="code-function">aes</span>(x = Sepal.Length,\n',
              '              fill = Species)) +\n',
              '  <span class="code-function">geom_histogram</span>(bins = <span class="code-number">20</span>,\n',
              '                  alpha = <span class="code-number">0.6</span>,\n',
              '                  position = <span class="code-string">"identity"</span>) +\n',
              '  <span class="code-function">labs</span>(title = <span class="code-string">"Distribution of Sepal Length"</span>) +\n',
              '  <span class="code-function">theme_minimal</span>()',
              sep = ""
            )))
          ),
          div(class = "r-card",
            fluidRow(
              column(4,
                selectInput(ns("hist_var"), "Variable:",
                  choices = c("Sepal.Length", "Sepal.Width",
                              "Petal.Length", "Petal.Width"),
                  selected = "Sepal.Length"),
                sliderInput(ns("hist_bins"), "Number of bins:", min = 5, max = 40, value = 20),
                actionButton(ns("btn_hist"), "▶ Update", class = "btn-run")
              ),
              column(8,
                plotOutput(ns("hist_plot"), height = "340px")
              )
            )
          )
        ),

        # ──────────────────────────────────────────────────────
        # Tab 5: Box Plot
        # ──────────────────────────────────────────────────────
        nav_panel("Box Plot",
          div(class = "r-card",
            tags$h5(class = "lesson-heading", "geom_boxplot() — Distribution Summary"),
            tags$p(
              "A box plot shows: median, quartiles (IQR), and outliers.
               Great for comparing distributions across groups."
            ),
            code_block(HTML(paste(
              '<span class="code-function">ggplot</span>(iris, <span class="code-function">aes</span>(x = Species,\n',
              '              y = Petal.Length,\n',
              '              fill = Species)) +\n',
              '  <span class="code-function">geom_boxplot</span>(alpha = <span class="code-number">0.7</span>) +\n',
              '  <span class="code-function">geom_jitter</span>(width = <span class="code-number">0.15</span>,\n',
              '               alpha = <span class="code-number">0.4</span>) +\n',
              '  <span class="code-function">labs</span>(title = <span class="code-string">"Petal Length by Species"</span>) +\n',
              '  <span class="code-function">theme_minimal</span>()',
              sep = ""
            )))
          ),
          div(class = "r-card",
            fluidRow(
              column(4,
                selectInput(ns("box_var"), "Y variable:",
                  choices = c("Sepal.Length", "Sepal.Width",
                              "Petal.Length", "Petal.Width"),
                  selected = "Petal.Length"),
                checkboxInput(ns("box_jitter"), "Show individual points", value = TRUE),
                actionButton(ns("btn_box"), "▶ Update", class = "btn-run")
              ),
              column(8,
                plotOutput(ns("box_plot"), height = "340px")
              )
            )
          )
        )

      ) # end navset_tab
    )
  )
}

# ── Server ────────────────────────────────────────────────────
mod_visualization_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ── Helper: get dataset ───────────────────────────────────
    get_data <- reactive({
      req(input$plot_dataset)
      if (input$plot_dataset == "mtcars") mtcars else iris
    })

    # ── Dynamic axis UI ───────────────────────────────────────
    output$plot_axis_ui <- renderUI({
      req(input$plot_type)
      df    <- get_data()
      nms   <- names(df)
      nums  <- nms[sapply(df, is.numeric)]
      cats  <- nms[!sapply(df, is.numeric)]
      type  <- input$plot_type

      switch(type,
        "bar"       = selectInput(ns("plot_x"), "X axis (group):", choices = c(cats, nums)),
        "histogram" = selectInput(ns("plot_x"), "Variable:", choices = nums),
        "density"   = selectInput(ns("plot_x"), "Variable:", choices = nums),
        "boxplot"   = tagList(
          selectInput(ns("plot_x"), "X axis (group):", choices = c(cats, nums)),
          selectInput(ns("plot_y"), "Y axis (numeric):", choices = nums, selected = nums[2])
        ),
        tagList(
          selectInput(ns("plot_x"), "X axis:", choices = nums),
          selectInput(ns("plot_y"), "Y axis:", choices = nums, selected = nums[2])
        )
      )
    })

    # Update color options based on dataset
    observe({
      req(input$plot_dataset)
      df   <- get_data()
      cats <- c("None" = "none", names(df)[!sapply(df, is.numeric)])
      updateSelectInput(session, "plot_color", choices = cats)
    })

    # ── Main interactive plot ─────────────────────────────────
    output$main_plot <- renderPlot({
      req(input$plot_type, input$plot_theme, input$plot_title)
      df    <- get_data()
      type  <- input$plot_type
      title <- if (nchar(trimws(input$plot_title)) > 0) input$plot_title else "My R Chart"
      thm   <- switch(input$plot_theme,
        "minimal" = theme_minimal(),
        "classic" = theme_classic(),
        "light"   = theme_light(),
        "dark"    = theme_dark(),
        "bw"      = theme_bw()
      )

      color_col <- if (!is.null(input$plot_color) && input$plot_color != "none")
                     input$plot_color else NULL

      # Build base plot using .data[[col]] (modern ggplot2 approach)
      if (type %in% c("histogram", "density")) {
        req(input$plot_x)
        x_col <- input$plot_x
        base_aes <- if (!is.null(color_col))
          aes(x = .data[[x_col]], fill = .data[[color_col]], color = .data[[color_col]])
        else
          aes(x = .data[[x_col]])
        p <- ggplot(df, base_aes)
        if (type == "histogram") {
          p <- p + geom_histogram(bins = 25, alpha = 0.7,
                                  position = if (!is.null(color_col)) "identity" else "stack",
                                  show.legend = !is.null(color_col))
        } else {
          p <- p + geom_density(alpha = 0.4)
        }
      } else if (type == "bar") {
        req(input$plot_x)
        x_col  <- input$plot_x
        fill_c <- color_col %||% x_col
        p <- ggplot(df, aes(x = .data[[x_col]], fill = .data[[fill_c]])) +
          geom_bar() + guides(fill = guide_legend(title = x_col))
      } else if (type == "boxplot") {
        req(input$plot_x, input$plot_y)
        xc <- input$plot_x; yc <- input$plot_y
        fc <- color_col %||% xc
        p <- ggplot(df, aes(x = .data[[xc]], y = .data[[yc]], fill = .data[[fc]])) +
          geom_boxplot(alpha = 0.7)
      } else {
        req(input$plot_x, input$plot_y)
        x_col <- input$plot_x; y_col <- input$plot_y
        base_aes <- if (!is.null(color_col))
          aes(x = .data[[x_col]], y = .data[[y_col]], color = .data[[color_col]])
        else
          aes(x = .data[[x_col]], y = .data[[y_col]])
        p <- ggplot(df, base_aes)
        if (type == "scatter") {
          p <- p + geom_point(size = 2.2, alpha = 0.7)
          if (isTRUE(input$plot_smooth))
            p <- p + geom_smooth(method = "lm", se = TRUE, alpha = 0.15)
        } else {
          p <- p + geom_line(linewidth = 0.9)
        }
      }

      p + labs(title = title) + thm +
        theme(plot.title = element_text(face = "bold", size = 13))
    })

    # ── Generated code display ────────────────────────────────
    output$plot_code <- renderText({
      req(input$plot_type, input$plot_dataset, input$plot_theme, input$plot_title)
      ds    <- input$plot_dataset
      type  <- input$plot_type
      title <- input$plot_title
      color <- if (!is.null(input$plot_color) && input$plot_color != "none")
                 paste0(", color = ", input$plot_color) else ""
      thm   <- paste0("theme_", input$plot_theme, "()")

      switch(type,
        "scatter"   = {
          req(input$plot_x, input$plot_y)
          paste0(
            "ggplot(", ds, ", aes(x = ", input$plot_x, ",\n",
            "              y = ", input$plot_y, color, ")) +\n",
            "  geom_point(size = 2.2, alpha = 0.7) +\n",
            if (isTRUE(input$plot_smooth)) "  geom_smooth(method = \"lm\", se = TRUE) +\n" else "",
            "  labs(title = \"", title, "\") +\n",
            "  ", thm
          )
        },
        "bar"       = {
          req(input$plot_x)
          paste0(
            "ggplot(", ds, ", aes(x = ", input$plot_x,
            ", fill = ", input$plot_x, ")) +\n",
            "  geom_bar() +\n",
            "  labs(title = \"", title, "\") +\n",
            "  ", thm
          )
        },
        "histogram" = {
          req(input$plot_x)
          paste0(
            "ggplot(", ds, ", aes(x = ", input$plot_x, color, ")) +\n",
            "  geom_histogram(bins = 25, alpha = 0.7) +\n",
            "  labs(title = \"", title, "\") +\n",
            "  ", thm
          )
        },
        "boxplot"   = {
          req(input$plot_x, input$plot_y)
          paste0(
            "ggplot(", ds, ", aes(x = ", input$plot_x, ",\n",
            "              y = ", input$plot_y, color, ")) +\n",
            "  geom_boxplot(alpha = 0.7) +\n",
            "  labs(title = \"", title, "\") +\n",
            "  ", thm
          )
        },
        "density"   = {
          req(input$plot_x)
          paste0(
            "ggplot(", ds, ", aes(x = ", input$plot_x, color, ")) +\n",
            "  geom_density(alpha = 0.4) +\n",
            "  labs(title = \"", title, "\") +\n",
            "  ", thm
          )
        },
        "line"      = {
          req(input$plot_x, input$plot_y)
          paste0(
            "ggplot(", ds, ", aes(x = ", input$plot_x, ",\n",
            "              y = ", input$plot_y, color, ")) +\n",
            "  geom_line(linewidth = 0.9) +\n",
            "  labs(title = \"", title, "\") +\n",
            "  ", thm
          )
        }
      )
    })

    # ── Scatter lesson plot ────────────────────────────────────
    output$scatter_plot <- renderPlot({
      ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
        geom_point(size = 2.5, alpha = 0.7) +
        geom_smooth(method = "lm", se = TRUE, alpha = 0.12) +
        labs(title = "Sepal Length vs Petal Length by Species",
             x = "Sepal Length (cm)", y = "Petal Length (cm)") +
        scale_color_brewer(palette = "Set1") +
        theme_minimal(base_size = 13) +
        theme(plot.title = element_text(face = "bold"))
    })

    # ── Bar chart lesson plot ─────────────────────────────────
    bar_var <- eventReactive(input$btn_bar, input$bar_var, ignoreNULL = FALSE)

    output$bar_plot <- renderPlot({
      var <- bar_var()
      req(var)
      df  <- iris |>
        dplyr::group_by(Species) |>
        dplyr::summarise(Mean = mean(.data[[var]]), .groups = "drop")

      ggplot(df, aes(x = Species, y = Mean, fill = Species)) +
        geom_col(width = 0.6) +
        geom_text(aes(label = round(Mean, 2)), vjust = -0.4, size = 3.5) +
        labs(title = paste("Mean", var, "by Species"),
             y = paste("Mean", var), x = "") +
        scale_fill_brewer(palette = "Set2") +
        theme_minimal(base_size = 12) +
        theme(plot.title = element_text(face = "bold"),
              legend.position = "none")
    })

    # ── Histogram lesson plot ─────────────────────────────────
    hist_var  <- eventReactive(input$btn_hist, input$hist_var,  ignoreNULL = FALSE)
    hist_bins <- eventReactive(input$btn_hist, input$hist_bins, ignoreNULL = FALSE)

    output$hist_plot <- renderPlot({
      var  <- hist_var()
      bins <- hist_bins()
      req(var, bins)
      ggplot(iris, aes(x = .data[[var]], fill = Species)) +
        geom_histogram(bins = bins, alpha = 0.65, position = "identity", color = "white") +
        labs(title = paste("Distribution of", var),
             x = var, y = "Count") +
        scale_fill_brewer(palette = "Set1") +
        theme_minimal(base_size = 12) +
        theme(plot.title = element_text(face = "bold"))
    })

    # ── Box plot lesson plot ──────────────────────────────────
    box_var    <- eventReactive(input$btn_box, input$box_var,    ignoreNULL = FALSE)
    box_jitter <- eventReactive(input$btn_box, input$box_jitter, ignoreNULL = FALSE)

    output$box_plot <- renderPlot({
      var    <- box_var()
      jitter <- box_jitter()
      req(var)
      p <- ggplot(iris, aes(x = Species, y = .data[[var]], fill = Species)) +
        geom_boxplot(alpha = 0.7, outlier.shape = NA) +
        labs(title = paste(var, "by Species"), x = "", y = var) +
        scale_fill_brewer(palette = "Pastel1") +
        theme_minimal(base_size = 12) +
        theme(plot.title = element_text(face = "bold"), legend.position = "none")
      if (jitter)
        p <- p + geom_jitter(width = 0.15, alpha = 0.4, size = 1.5)
      p
    })

  })
}

# ── Null coalescing helper ────────────────────────────────────
`%||%` <- function(x, y) if (!is.null(x) && x != "none") x else y
