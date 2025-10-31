# IDs de las estaciones (nombrar según los archivos en data_raw)
ids_estaciones <- c("NH0046", "NH0098", "NH0437", "NH0472", "NH0910")

# Leer y combinar todos los CSV
lista_datos <- lapply(ids_estaciones, function(id) {
  cli::cli_inform("Procesando datos de la estación: {id}")
  archivo <- file.path("data_raw", paste0(id, ".csv"))
  read_csv(archivo, show_col_types = FALSE)
})

# Combinar en un solo dataframe y agregar columna de ID de estación
datos_meteorologicos <- bind_rows(lista_datos, .id = "id_estacion")

# 1️⃣ Guardar dentro del paquete
usethis::use_data(datos_meteorologicos, overwrite = TRUE)
cli::cli_inform("✅ Dataset guardado dentro del paquete (data/datos_meteorologicos.rda)")

# 2️⃣ Guardar también como CSV en data_raw
readr::write_csv(datos_meteorologicos, "data_raw/NHCOMPLETOS.csv")
cli::cli_inform("✅ Dataset guardado como CSV en data_raw/datos_meteorologicos_completo.csv")
