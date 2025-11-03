
# ----------------------------------------------------- -------------------
# Integrar indicadores ----------------------------------------------------
# ------------------------------------------------------------------------

# IRAG POR SEMANA --------------------------------------------------------

irag_semana <- UCIRAG_HSM %>%
  group_by(anio = isoyear(FECHA_MINIMA), semana = isoweek(FECHA_MINIMA)) %>%
  summarise(valor = n(), .groups = "drop") %>%
  mutate(indicador = "IRAG_SEMANA",
         unidad = "n",
         descripcion = "Casos de IRAG e IRAG extendida por semana epidemiológica")

# TASA LETALIDAD------------------------------------


letalidad_irag <- LETALIDAD_POR_EDAD %>%
  group_by(EDAD_UC_IRAG) %>%
  summarise(
    numerador = sum(fallecidos, na.rm = TRUE),
    denominador = sum(casos_totales, na.rm = TRUE),
    valor = numerador / denominador * 100,
    .groups = "drop"
  ) %>%
  mutate(
    indicador = "LETALIDAD_IRAG",
    unidad = "%",
    descripcion = "Tasa de letalidad por grupo de edad en IRAG e IRAG extendida"
  )


# Positividad Virus total para el período -------------------------------------------------------

positividad_virus <- DATA_VIRUS_EDAD %>%
  group_by(EDAD_UC_IRAG) %>%
  summarise(
    numerador = sum(casos_influenza + casos_vsr + casos_covid, na.rm = TRUE),
    denominador = sum(casos_influenza + casos_vsr + casos_covid + casos_negativos, na.rm = TRUE),
    valor = (numerador / denominador) * 100,
    .groups = "drop"
  ) %>%
  mutate(
    indicador = "POSITIVIDAD_VIRUS_SEMANA",
    unidad = "%",
    descripcion = "Determinaciones positivas por virus y semana epidemiológica"
  )




# UNIFICAR INDICADORES EN UNA TABLA - INPUT -------------------------------



indicadores_resumen <- bind_rows(irag_semana, letalidad_irag, positividad_virus)

