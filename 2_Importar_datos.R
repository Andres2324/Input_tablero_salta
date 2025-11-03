


# Importación de los datos/CHEQUER FUENTE DENTRO DE LA CARPETA ------------------------------------------------


UCIRAG_HSM <- import(here("Tableros Salta/BD UC-IRAG/NOMINAL/UC_IRAG_HSM.csv"))


UCIRAG_HSM <- import(here("Tableros Salta/BD UC-IRAG/NOMINAL/UC_IRAG_HSM.csv"),   
                     encoding = "Latin-1" # PARA QUE TOME LOS VALORES EN CASTELLANO DE UN CSV  #EL ENCODING FACILITA LA LECTURA DE LAS VARIABLES
)

UCIRAG_HSM_AGRUPADA <- import(
  here("Tableros Salta/BD UC-IRAG/AGRUPADA/UC IRAG - Carga Agrupada-Salta-HOSPITAL SEÑOR DEL MILAGRO.xlsx")
)



# Exploración de datos--------------------------------------------------



# names(UCIRAG_HSM)
# 
# tabyl(UCIRAG_HSM, CLASIFICACION_MANUAL)
# 
# tabyl(UCIRAG_HSM, CLASIFICACION_MANUAL, SEPI_FECHA_MINIMA)
# 
# tabyl(UCIRAG_HSM, FECHA_MINIMA)