
#' Genera un gráfico de temperatura media mensual por estación
#'
#' Esta función recibe un conjunto de datos con observaciones diarias (o con fecha)
#' de temperatura por estación, calcula la **temperatura media mensual** para cada
#' estación y devuelve un objeto `ggplot` listo para visualizar.
#'
#' @param datos Data frame (`tibble`) con, al menos, las columnas:
#' `id` (identificador de estación), `fecha` (clase Date) y
#' `temperatura_abrigo_150cm` (numérica).
#'
#' @param colores Vector de colores opcional para asignar manualmente a cada
#' estación. Si se omite, la función selecciona automáticamente una paleta
#' aleatoria con tantos colores como estaciones haya.
#'
#' @param titulo Cadena de texto con el título del gráfico. Por defecto, `"Temperatura"`.
#'
#' @return Un objeto `ggplot` con la temperatura media mensual por estación.
#'
#' @details
#' La función agrega por mes (según la columna `fecha`) y promedia
#' `temperatura_abrigo_150cm` para cada combinación de `id` y `mes`.
#' Si `colores` se provee, su longitud debe ser igual al número de estaciones
#' distintas en `datos`. En caso contrario, se seleccionan colores aleatorios.
#'
#' Utiliza `dplyr`, `lubridate`, `ggplot2` y `cli`.
#'
#' @examples
#' \dontrun{
#' # Suponiendo que ya leíste varias estaciones y las combinaste en 'df'
#' # df tiene columnas: id, fecha, temperatura_abrigo_150cm
#' p <- grafico_temperatura_mensual(df, titulo = "Temperatura media mensual")
#' print(p)
#' }
#'
#' @export
#' @importFrom dplyr mutate group_by summarise n_distinct
#' @importFrom lubridate month
#' @importFrom ggplot2 ggplot aes geom_line geom_point scale_x_continuous labs
#' @importFrom ggplot2 scale_color_manual theme_minimal theme element_text
#' @importFrom cli cli_abort cli_inform
grafico_temperatura_mensual <- function(datos, colores = NULL, titulo = "Temperatura") {

  if (!all(c("id", "fecha", "temperatura_abrigo_150cm") %in% names(datos))) {
    cli_abort("El data.frame debe contener las columnas: 'id', 'fecha' y 'temperatura_abrigo_150cm'.")
  }


  datos <- datos %>%
    mutate(mes = month(fecha))


  promedio_mensual <- datos %>%
    group_by(id, mes) %>%
    summarise(
      temperatura_media = mean(temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  # (desafío)
  if (is.null(colores)) {
    n_estaciones <- length(unique(promedio_mensual$id))
    colores <- sample(colors(), n_estaciones)
    cli_inform("No se especificaron colores. Se eligieron {n_estaciones} colores aleatorios.")
  }


  g <- ggplot(promedio_mensual, aes(x = mes, y = temperatura_media, color = id)) +
    geom_line(linewidth = 1) +
    geom_point(size = 2) +
    scale_x_continuous(breaks = 1:12, labels = month.abb) +
    labs(
      x = "Mes",
      y = "Temperatura media (°C)",
      color = "Estación",
      title = titulo
    ) +
    scale_color_manual(values = colores) +
    theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom"
    )

  cli_inform("Gráfico generado correctamente.")
  return(g)
}
#Ejemplo:
#  todas_las_estaciones <- bind_rows(
#    leer_estacion("estacion_NH0437", "datos/estacion_NH0437.csv"),
#    leer_estacion("estacion_NH0472", "datos/estacion_NH0472.csv")
#  )

#Generar el gráfico con colores definidos:
#  grafico_temperatura_mensual(todas_las_estaciones,
#                              colores = c("tomato", "steelblue"),
#                              titulo = "Promedio mensual de temperatura")

#O dejar que elija colores aleatorios:
#  grafico_temperatura_mensual(todas_las_estaciones)
