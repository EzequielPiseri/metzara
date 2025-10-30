library(dplyr)
library(tidyr)
library(cli)

tabla_resumen_temperatura <- function(ids_estaciones) {

  lista_datos <- list()

  for (id in ids_estaciones) {
    ruta <- paste0("datos/", id, ".csv")
    datos <- leer_estacion(id, ruta)
    datos$id <- id
    lista_datos[[id]] <- datos
  }


  todas_las_estaciones <- bind_rows(lista_datos)


  resumen <- todas_las_estaciones %>%
    group_by(id) %>%
    summarise(
      Media = mean(temperatura_abrigo_150cm, na.rm = TRUE),
      Desviacion_Estandar = sd(temperatura_abrigo_150cm, na.rm = TRUE),
      Maxima = max(temperatura_abrigo_150cm, na.rm = TRUE),
      Minima = min(temperatura_abrigo_150cm, na.rm = TRUE)
    )


  resumen_largo <- resumen %>%
    pivot_longer(
      cols = c(Maxima, Minima),
      names_to = "Tipo",
      values_to = "Temperatura"
    )

  cli_inform("Tabla resumen de temperatura generada para {length(ids_estaciones)} estación(es).")

  return(resumen_largo)
}

# Ejemplo:

#tabla_resumen_temperatura(c("estacion_NH0437", "estacion_NH0472", "estacion_NH0098"))
