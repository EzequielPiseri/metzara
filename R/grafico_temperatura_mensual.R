
#' Genera un grafico de temperatura media mensual por estacion
#'
#' Esta funcion recibe un conjunto de datos con observaciones diarias (o con fecha)
#' de temperatura por estacion, calcula la temperatura media mensual para cada
#' estacion y devuelve un objeto `ggplot` listo para visualizar.
#'
#' @param datos Data frame (tibble) con, al menos, las columnas:
#' `id` (identificador de estacion), `fecha` (clase Date) y
#' `temperatura_abrigo_150cm` (numerica).
#'
#' @param colores Vector de colores opcional para asignar manualmente a cada
#' estacion. Si se omite, la funcion selecciona automaticamente una paleta
#' aleatoria con tantos colores como estaciones haya.
#'
#' @param titulo Cadena de texto con el titulo del grafico. Por defecto, "Temperatura".
#'
#' @return Un objeto `ggplot` con la temperatura media mensual por estacion.
#'
#' @details
#' La funcion agrega por mes (segun la columna `fecha`) y promedia
#' `temperatura_abrigo_150cm` para cada combinacion de `id` y `mes`.
#' Si `colores` se provee, su longitud debe ser igual al numero de estaciones
#' distintas en `datos`. En caso contrario, se seleccionan colores aleatorios.
#'
#' Utiliza `dplyr`, `lubridate`, `ggplot2` y `cli`.
#'
#' @examples
#' \dontrun{
#' # Suponiendo que ya leiste varias estaciones y las combinaste en 'df'
#' # df tiene columnas: id, fecha, temperatura_abrigo_150cm
#' p <- grafico_temperatura_mensual(df, titulo = "Temperatura media mensual")
#' print(p)
#' }
#'
#' @export
#' @importFrom dplyr mutate group_by summarise
#' @importFrom lubridate month
#' @importFrom ggplot2 ggplot aes geom_line geom_point scale_x_continuous labs
#' @importFrom ggplot2 scale_color_manual theme_minimal theme element_text
#' @importFrom cli cli_abort cli_inform
#' @importFrom grDevices colors
grafico_temperatura_mensual <- function(datos, colores = NULL, titulo = "Temperatura") {

  if (!all(c("id", "fecha", "temperatura_abrigo_150cm") %in% names(datos))) {
    cli::cli_abort("El data.frame debe contener las columnas: 'id', 'fecha' y 'temperatura_abrigo_150cm'.")
  }

  datos <- datos |>
    dplyr::mutate(mes = lubridate::month(.data$fecha))

  promedio_mensual <- datos |>
    dplyr::group_by(.data$id, .data$mes) |>
    dplyr::summarise(
      temperatura_media = mean(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  # Colores
  if (is.null(colores)) {
    n_estaciones <- length(unique(promedio_mensual$id))
    # elegir n_estaciones colores aleatorios de la paleta base
    base_cols <- grDevices::colors()
    colores <- base_cols[sample.int(length(base_cols), n_estaciones)]
    cli::cli_inform("No se especificaron colores. Se eligieron {n_estaciones} colores aleatorios.")
  }

  g <- ggplot2::ggplot(
    promedio_mensual,
    ggplot2::aes(x = .data$mes, y = .data$temperatura_media, color = .data$id)
  ) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::geom_point(size = 2) +
    ggplot2::scale_x_continuous(breaks = 1:12, labels = month.abb) +
    ggplot2::labs(
      x = "Mes",
      y = "Temperatura media (deg C)",
      color = "Estacion",
      title = titulo
    ) +
    ggplot2::scale_color_manual(values = colores) +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    )

  cli::cli_inform("Grafico generado correctamente.")
  return(g)
}

#Ejemplo:
#  todas_las_estaciones <- bind_rows(
#    leer_estacion("estacion_NH0437", "datos/estacion_NH0437.csv"),
#    leer_estacion("estacion_NH0472", "datos/estacion_NH0472.csv")
#  )

#Generar el gr\u00E1fico con colores definidos:
#  grafico_temperatura_mensual(todas_las_estaciones,
#                              colores = c("tomato", "steelblue"),
#                              titulo = "Promedio mensual de temperatura")

#O dejar que elija colores aleatorios:
#  grafico_temperatura_mensual(todas_las_estaciones)
