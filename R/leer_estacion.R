library(readr)
library(cli)

#' Lee y descarga datos meteorológicos de una estación
#'
#' Esta función descarga (si no existe previamente) y lee un archivo CSV con datos
#' meteorológicos correspondientes a una estación específica, usando un identificador
#' predefinido. Si el archivo no existe en la ruta indicada, se crea el directorio
#' y se descarga automáticamente desde una fuente remota.
#'
#' @param id_estacion Cadena de texto con el identificador de la estación.
#' Los valores válidos son: `"estacion_NH0472"`, `"estacion_NH0910"`,
#' `"estacion_NH0046"`, `"estacion_NH0098"` y `"estacion_NH0437"`.
#'
#' @param ruta Cadena de texto con la ruta local donde se guardará o leerá el archivo CSV.
#' Por ejemplo, `"datos/NH0472.csv"`.
#'
#' @return Un data frame (`tibble`) con los datos meteorológicos de la estación especificada.
#'
#' @details
#' La función valida el identificador de estación, crea la carpeta de destino si no existe,
#' descarga el archivo en caso necesario y luego lee el contenido en formato CSV.
#' Utiliza los paquetes `readr` para la lectura de datos y `cli` para mostrar mensajes informativos.
#'
#' @examples
#' \dontrun{
#' # Descargar y leer los datos de la estación NH0472
#' datos_ejemplo <- leer_estacion("estacion_NH0472", "datos/NH0472.csv")
#'
#' # Mostrar las primeras filas
#' head(datos_ejemplo)
#' }
#'
#' @export
leer_estacion <- function(id_estacion, ruta) {

  # Definición de URLs de las estaciones
  urls <- list(
    estacion_NH0472 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv",
    estacion_NH0910 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv",
    estacion_NH0046 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv",
    estacion_NH0098 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv",
    estacion_NH0437 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv"
  )

  # Validación del ID de estación
  if (!id_estacion %in% names(urls)) {
    cli_abort("El id de estación '{id_estacion}' no es válido. Usá uno de: {toString(names(urls))}")
  }

  url <- urls[[id_estacion]]

  directorio <- dirname(ruta)

  # Creación del Directorio si no existe
  if (!dir.exists(directorio)) {
    cli_inform("La carpeta '{directorio}' no existe. Creándola...")
    dir.create(directorio, recursive = TRUE)
    cli_inform("Carpeta '{directorio}' creada.")
  }

  # Descarga o Lectura del Archivo
  if (!file.exists(ruta)) {
    cli_inform("El archivo no existe en la ruta indicada. Descargando datos de la estación {id_estacion}...")
    download.file(url, ruta, mode = "wb")
    cli_inform("Descarga completada en '{ruta}'.")
  } else {
    cli_inform("El archivo ya existe en la ruta indicada. Leyendo archivo '{ruta}'...")
  }

  # Lectura y Retorno de Datos
  datos <- suppressMessages(readr::read_csv(ruta))
  cli_inform("Lectura completada. El dataset de la estación {id_estacion} tiene {nrow(datos)} filas y {ncol(datos)} columnas.")

  return(datos)
}

# datos_ejemplo <- leer_estacion("estacion_NH0472", "datos/NH0472.csv")
