# 0. Limpiar todo
rm(list=ls())

# 1. Cargar paquetes ------------------------
if (!require("pacman")) install.packages("pacman")  #si falta pacman, instalar

pacman::p_load(
  tidyverse,
  haven,
  glue,
  stringr,
  lubridate,
  readxl,
  data.table,
  readxl
)

carpeta <- list.dirs(path = glue("//Buvmfswinp01/seet_enut/ii_enut/4_recoleccion/data/sm99"),
                     full.names = TRUE, recursive = FALSE) %>%
  tail(1)

ruta <- glue::glue(
  "{carpeta}/paradata.zip")

##Descomprimo paradata
paradata <- unzip(ruta, "paradata.tab")

###Abro archivo
ruta_archivo <- "paradata.tab"

#1. Procesar base de paradatos ------

paradata <- fread(ruta_archivo)



filtrada <- paradata[interview__id=='53fb5b4bb4b04626a010b08236bcbfd1']


nrow(filtrada)

###17213 filas
# AnswerRemoved               AnswerSet     ApproveBySupervisor      ClosedBySupervisor              CommentSet 
# 2                    1300                       1                       3                       4 
# Completed        InterviewCreated     InterviewerAssigned    InterviewModeChanged             KeyAssigned 
# 3                       1                       1                       1                       1 
# OpenedBySupervisor                  Paused QuestionDeclaredInvalid   QuestionDeclaredValid   ReceivedByInterviewer 
# 3                       6                       1                   13138                       2 
# ReceivedBySupervisor    RejectedBySupervisor                 Resumed      SupervisorAssigned        VariableDisabled 
# 3                       2                       6                       1                    1094 
# VariableEnabled             VariableSet 
# 533                    1107 

filtrada2 <- filtrada %>% 
  filter(between(order,40,55)) %>% 
  mutate(responsible = '999999999-0',
         parameters = reduce(list(
           c("Elena Eugenia villalobos maita", "Arnold"),
           c("karina milinsen tarquen villalobos", "Blanco"),
           c("marta noemi tarque villalobos", "Claudia"),
           c("marcos josue tarquen villalobos", "David"),
           c("Ariel velazques villalobos", "Evelyn"),
           c("juan velazques villalobos", "Francisco")
         ), ~ str_replace(.x, .y[1], .y[2]), .init = parameters))

	
saveRDS(filtrada2, 'C:/Users/JEGALDAMESH/OneDrive - Instituto Nacional de Estadisticas/Tesis Seminario de Grado/paradata_f.rds')

