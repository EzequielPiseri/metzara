
#' Genera un resumen estadístico de temperatura para una o más estaciones
#'
#' Esta función lee los datos meteorológicos de una o más estaciones, combinando la información
#' descargada mediante `leer_estacion()`. Calcula estadísticas básicas de temperatura para cada
#' estación (media, desviación estándar, valores máximos y mínimos) y devuelve los resultados
#' en formato largo.
#'
#' @param ids_estaciones Vector de texto con los identificadores de las estaciones cuyas
#' temperaturas se desean resumir. Por ejemplo:
#' `c("estacion_NH0098", "estacion_NH0437", "estacion_NH0472")`.
#'
#' @return Un data frame (`tibble`) con el resumen de temperatura por estación,
#' con las siguientes columnas:
#' \itemize{
#'   \item `id`: Identificador de la estación.
#'   \item `Tipo`: Tipo de valor (`"Maxima"` o `"Minima"`).
#'   \item `Temperatura`: Valor correspondiente de temperatura.
#' }
#'
#' @details
#' La función recorre las estaciones indicadas, leyendo los archivos CSV locales (o descargándolos
#' si no existen) mediante `leer_estacion()`. Luego, combina todos los datos en un único conjunto
#' y calcula, para cada estación, las temperaturas media, desviación estándar, máxima y mínima.
#' Finalmente, reestructura la tabla a formato largo para facilitar la visualización o el análisis.
#'
#' Utiliza los paquetes `dplyr`, `tidyr` y `cli` para el manejo y procesamiento de los datos.
#'
#' @examples
#' \dontrun{
#' # Generar un resumen de temperatura para tres estaciones
#' resumen <- tabla_resumen_temperatura(
#'   ids_estaciones = c("estacion_NH0098", "estacion_NH0437", "estacion_NH0472")
#' )
#'
#' # Ver las primeras filas del resumen
#' head(resumen)
#' }
#'
#' @export
tabla_resumen_temperatura <- function(ids_estaciones) {

  lista_datos <- list()

  for (id in ids_estaciones) {
    ruta <- paste0("datos/", id, ".csv")
    datos <- leer_estacion(id, ruta)
    datos$id <- id
    lista_datos[[id]] <- datos
  }

  todas_las_estaciones <- dplyr::bind_rows(lista_datos)

  resumen <- todas_las_estaciones %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(
      Media              = mean(temperatura_abrigo_150cm, na.rm = TRUE),
      Desviacion_Estandar= stats::sd(temperatura_abrigo_150cm, na.rm = TRUE),
      Maxima             = max(temperatura_abrigo_150cm, na.rm = TRUE),
      Minima             = min(temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  resumen_largo <- tidyr::pivot_longer(
    resumen,
    cols = c(Maxima, Minima),
    names_to = "Tipo",
    values_to = "Temperatura"
  )

  cli::cli_inform("Tabla resumen de temperatura generada para {length(ids_estaciones)} estación(es).")
  return(resumen_largo)
}

# Ejemplo:

#tabla_resumen_temperatura(c("estacion_NH0437", "estacion_NH0472", "estacion_NH0098"))
