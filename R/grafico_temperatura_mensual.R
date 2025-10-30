library(dplyr)
library(ggplot2)
library(lubridate)
library(cli)

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
