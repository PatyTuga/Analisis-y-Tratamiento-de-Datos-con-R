#FUNCIONES
est<-function(vector){
  vari<-list()
  vari$min<-min(vector,na.rm = TRUE)
  vari$p5<-quantile(vector,probs = c(0.05))
  vari$mediana<-median(vector)
  vari$p95<-quantile(vector,probs = c(0.95))
  vari$max<-max(vector)
  return(unlist(vari))
}

est(data$P03)#variable edad
class(data$P03)
#selecionar las variable numericas para usar la funcion

columnas<-which(unlist<-(lapply(data,class))=="numeric")
class(columnas)

subdata<-data[,columnas]
#hay que quitar los valores perdidos
lapply(subdata, est)
