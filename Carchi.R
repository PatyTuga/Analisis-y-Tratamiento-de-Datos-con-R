#### Consultas SQL - Visulaización ####

# Datos
library(haven)
library(foreign)
data<-read_sav("SPSS_Carchi_Poblacion.sav")
str(data)
X <- c(dim(data))
X[1]
dim(data1)


library(dplyr)
library(data.table)
datat<- tbl_df(data)
datat <- data.table(data)

class(data)
View(data)

#media y desviaci?n estandar de la edad de las personas de la poblaci?n
md<-data  %>%  summarise(media=mean(P03), desviacion=sd(P03))
class(md)
md
md[1,1]
md[1,2]
  
# Consultas con sentencias SQL
library(sqldf)
glimpse(data)

View(data)
data %>%  select(1,4,5,6)
data %>% sum(na.rm=TRUE)

glimpse(data1)
View(data1)
data %>%  select(1,2)
#numero de habitantes
habitantes<-sqldf("SELECT COUNT(I01)
      FROM data")
habitantes[1]


#numero de Hombres y mujeres
hm <- sqldf("SELECT  COUNT(P01) AS GENERO
      FROM data
      GROUP BY P01")
hm
hm[1,1]
hm[2,1]

#1 es HOMBRE Y 2 es MUJER 

sqldf("SELECT  I02 , COUNT(P01) AS GENERO
      FROM data
      GROUP BY P01")

data$P01<-as.numeric(data$P01)
data$P01<-as.numeric(data$P01)

#numero de hombres por cantones 
sqldf("SELECT  I02 AS CANTONES, COUNT(P01) AS GENERO
      FROM data
      WHERE  P01==1
      GROUP BY I02")



#SABE LEER Y ESCRIBIR
le<-sqldf("SELECT  COUNT(P19) AS LEE_ESCRIBE
      FROM data
      GROUP BY P19")
le
le[2,1]
le[3,1]
#1 SI Y 2 NO


#nivel de estudios
sqldf("SELECT  COUNT(P23) AS NIVEL_EDUCACION
      FROM data
      GROUP BY P23"))
# 1=Ninguno
#2=Centro de alfabetizaci?n
#3=Pre escolar
#4=Primario
#5=Secundaria
#6=Educaci?n Basica
#7=Educaci?n Media
#8=Ciclo Postbachillerato 
#9=Superior
#10=Postgrado

URB<-sqldf("SELECT URP AS URB_RURAL, SUM(I01) AS POBLADO
      FROM data
      GROUP BY URP")
URB[1,2]
URB[2,2]

sqldf("SELECT P11P AS PROV_NACIO, COUNT(I01) AS PERSONAS
      FROM data
      GROUP BY P11P")


#1=Azuay (Capital: Cuenca)
#2=Bol\'ivar (Capital: Guaranda)
#3=Ca\~nar (Capital: Azogues)
#4=Carchi (Capital: Tulc?n)
#5=Chimborazo (Capital: Riobamba)
#6=Cotopaxi (Capital: Latacunga)
#7=El Oro (Capital: Machala)
#8=Esmeraldas (Capital: Esmeraldas)
#9=Gal\'apagos (Capital: Puerto Baquerizo)
#10=Guayas (Capital: Guayaquil)
#11=Imbabura (Capital: Ibarra)
#12=Loja (Capital: Loja)
#13=Los R\'ios (Capital: Babahoyo)
#14=Manab\'i (Capital: Portoviejo)
#15=Morona Santiago (Capital: Macas)
#16=Napo (Capital: Tena)
#17=Orellana (Capital: Francisco de Orellana)
#18=Pastaza (Capital: Puyo)
#19=Pichincha (Capital: Quito)
#20=Santa Elena (Capital: Santa Elena)
#21=Santo Domingo de los Tsachilas (Capital: Santo Domingo)
#22=Sucumbios (Capital: Nueva Loja)
#23=Tungurahua (Capital: Ambato)
#24=Zamora (Capital: Zamora)
#88= Exterior
#90=Zonas No Delimitadas

#numero de personas mayores de 65 a;os que tienen o no discapacidad
mayores<-data %>% filter(P03>65)
sqldf("SELECT COUNT(P08) AS DISCAPACIDAD
      FROM mayores
      GROUP BY P08")
dim(mayores)# numero de personas mayores


#menores de edad que se encuentran estudiando
menores<-data %>% filter(P03<18)
dim(menores)
menor_estudia<-sqldf("SELECT COUNT(P21) AS MENORES_DE_EDAD_ASISTIENDO_A_CAPACITACION
      FROM menores
      GROUP BY P21")
menor_estudia[2,1]#si estudia
menor_estudia[3,1]#no estudia

# veamos entre hombres y mujeres se encuentran estudiando
hombres<-data %>% filter(P01==1)
hombres_estudian<-sqldf("SELECT COUNT(P21) AS HOMBRES_ASISTIENDO_A_CAPACITACION
      FROM hombres
      GROUP BY P21")

mujeres<-data %>% filter(P01==2)
mujeres_estudian<-sqldf("SELECT COUNT(P21) AS MUJERES_ASISTIENDO_A_CAPACITACION
      FROM mujeres
      GROUP BY P21")
dim(data)
dim(hombres)
dim(mujeres)

#tipo de actividad q  realiza

actividad <- sqldf("SELECT  TIPOACT AS ACTIVIDAD, COUNT(I01) AS PERSONAS
      FROM data
      GROUP BY TIPOACT")
actividad

#1=Trabaja al menos una hora
#2=No trabaj\'o, pero si tiene trabajo
#3=Trabaj\'o al menos una hora en servicios
#4=Trabaj\'o al menos una hora en negocio familiar
#5=Trabaj\'o al menos una hora en labores agr\'icolas
#6=Cesante
#7=Busca trabajo por primera vez
#8=Rentista
#9=Jubilado
#10=Estudiante
#11=Quehaceres dom\'esticos
#12=Discapacitado
#13=otra actividad


#EL ESTADO CIVIL de la poblacion
sqldf("SELECT  P34 AS ESTADO_CIVIL, COUNT(I01) AS PERSONAS
      FROM data
      GROUP BY P34")
#1=Casado/a
#2=Unido/a
#3=Separado/a
#4=Divorciado/a
#5=Viudo/a
#6=Soltero/a

# Las personas que se encuentran en auje con la tecnolog\'ia
per_tecno<-data %>% filter(P20T==1) %>% filter(P20I==1) %>% filter(P20C==1)
tot<-sqldf("SELECT COUNT(I01) AS PERSONAS_TECNOLOGIA 
      FROM per_tecno
      GROUP BY I01")
tot
tot[1,1]

#
clases<-unlist(lapply(data,class))=="labelled"
clases[clases==TRUE]
clases[clases==FALSE]

