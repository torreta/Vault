#include <stdio.h>
#include "common.h"
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#define TRUE 1
#define FALSE 0

char buf1[MAX_PKT], buf2[MAX_PKT]; 
int tamArchivo = 0,lector = 0,finarchivo=0,w=3,final=0,k=0,ack1=0;
char archivo[10000],entrada[1000],salida[1000];

char itoascii(int z){
    if(z==0) return '0';
    if(z==1) return '1';
    if(z==2) return '2';
    if(z==3) return '3';
    if(z==4) return '4';
    if(z==5) return '5';
    if(z==6) return '6';
    if(z==7) return '7';
    if(z==8) return '8';
    if(z==9) return '9';
    return '\0';
}
int ctoi(char z){
    if(z=='0') return 0;
    if(z=='1') return 1;
    if(z=='2') return 2;
    if(z=='3') return 3;
    if(z=='4') return 4;
    if(z=='5') return 5;
    if(z=='6') return 6;
    if(z=='7') return 7;
    if(z=='8') return 8;
    if(z=='9') return 9;
    return -1;
}

void leerArchivo(char *namefile)
{
  FILE *f_in = fopen(namefile,"r");
  char x;
  int i = 0;
  if(!f_in){ printf("Error al leer el archivo de entrada"); exit(0); }    
  while(1)
  {
    x = getc(f_in);
    if(x == EOF) break;
    archivo[i] = x;
    i++;
  }
  tamArchivo = i;
  fclose(f_in);
}

int nro_Tramas(int tope){
	int random= (rand()%tope)+1;
	return random;
}

void armarTrama(int inicio)
{
	int i,j,a,nt,cerro,finfor=0;
	char separada[20];
  memset(buf1, 0, MAX_PKT);
	nt=nro_Tramas(w);		
  buf1[0]='A';buf1[1]='C';buf1[2]='K';
  buf1[3]=itoascii(inicio);buf1[4]=' ';
	if(finarchivo==1){
		nt=0;
	}
	buf1[5]=itoascii(nt);buf1[6]=' ';
	j=6;
	for(i=0;i<nt;i++)
	{

  int cont = 0;
  while(cont<20){
    if(lector != tamArchivo){
      buf1[j+cont+1] = archivo[lector];
			//salida[k]= buf1[j+cont+1];
      cont++;//k++;
      lector++;
    }else if(cont == 0){
			finarchivo=1;
      break;
    }else if(cont > 0){
      buf1[j+cont+1] = ' ';
			//salida[k]= buf1[j+cont+1];
      cont++;//k++;
    }
  }
	if(finarchivo!=1){
		for(a=0;a<20;a++){
			separada[a]=buf1[j+a];
		}
		cerro=kumasum(separada);
		cerro=completar(cerro);
		buf1[j+cont+1]=itoascii(cerro/100); cerro=cerro%100;
		buf1[j+cont+2]=itoascii(cerro/10);
		buf1[j+cont+3]=itoascii(cerro%10);
		j=j+23;
		}
	}
}

int kumasum(char trama[]){
	int suma=0,i,a,largo;
	for(i=0;i<20;i++){
		suma=suma+trama[i];
	}
//	printf("la suma de la trama en ASCII es %d\n",suma);
	return suma;
}


int verificar(int a,int b){
	if(((a+b) % 717)==0)
		return 1;
	else
	return 0;
}

int completar (int a){
int resto=0;
	if ((a%2)==0){
		resto=a%717+1;
	}else{
		resto=a%717;	
	}
	return (resto);
}

int separarTramas(char trama[]){
		int a,b,c,d,mala=10;
		b= ctoi(trama[5]);d=0;
		for(a=0;a<b;a++){
			for(c=0;c<20;c++){
				if(trama[c+d]=='#') {
					//printf("la posicion %d es un #\n",c+d-7);
					if(mala>((c+d+7)/20)) {
						mala=(c+d+7)/20;
					}
				}	
			}
			d=d+20;
		}
		if(mala<10){
			printf("La trama %d está erronea %s\n",mala,trama);
			return mala+1;
		}else{
			printf("Se recibieron la(s) trama(s) correctamente %s\n",trama);
			return 0;
		}
}

int picarTramas(char trama[]){
	char aux[MAX_PKT];int a,b,c,d,cagada=10;
	for	(a=0;a<ctoi(trama[5]);a++){
		for(b=0;b<20;b++){
			aux[b]=trama[6+(a*23)+b];
		}
		c=kumasum(aux);
		c=completar(c);
		printf("el numero es %c%c%c\n",trama[6+(a*23)+b+1],trama[6+(a*23)+b+2],trama[6+(a*23)+b+3]);
		d=ctoi(trama[6+(a*23)+b+1])*100+ctoi(trama[6+(a*23)+b+2])*10+ctoi(trama[6+(a*23)+b+3]);
		//if(verificar(c,d)==0){
		if(c!=d){
			if (cagada>a){
				cagada=a;
				printf("La trama %d está erronea %s. %d es distinto de %d\n",a,trama,c,d);
			}
		}
	}
	if(cagada<10){	
			return cagada+1;
		}else{
			printf("Se recibieron la(s) trama(s) correctamente %s\n",trama);
			return 0;
		}
}

int main(int argc, char *argv[])
{

  int j,malas,a,b,d,e,reenviar=0,ant=10;
  int clientes = 0;
  int conexion;
  int ret;
  leerArchivo("entradaS.txt");
	char* torre;
  
  for(j=0; j<argc-2; j=j+2){

    argv[2]=argv[j+2];
    argv[1]=argv[j+1];
    
    char buff[3];
    char namefile[20];
    
    Itoa(clientes, buff, 10);    

    strcpy(namefile, "salidaC");
    strcat(namefile, buff);
    strcat(namefile,".txt");
    
    FILE *f_out = fopen(namefile,"w");
    
    /* Inicialia el servidor */
    conexion = init_servidor(argc,argv);
    printf("Conexion con -> %d\n",conexion);
    
    while(TRUE){
    
      ret = from_physical_layer(buf2,conexion);				//Se recibe del cliente
      if(ret == FRAME){
				if(buf2[5]=='0' && finarchivo==1){
					final=1;
				}				
//			malas=separarTramas(buf2);				
				malas=picarTramas(buf2);
//			printf("Se recibió la trama correctamente -> %s\n", buf2);
				memset(entrada,0,1000);
				if(malas!=0){
					reenviar=1;
//					e=0;
//					for(a=7+ctoi(buf2[5])*23;a<(7+(23*malas));a++){
//						for(d=0;d<20;d++){
//							entrada[e]=buf2[7+(a*23)+d];
//							e++;
//						}
						//entrada[a]=buf2[a+7];
//					}
				}else{
					e=0;
					for(a=0;a<(ctoi(buf2[5]));a++){
						for(d=0;d<20;d++){
							entrada[e]=buf2[7+(a*23)+d];
							e++;
						}
						//entrada[a]=buf2[a+7];
					}
					reenviar=0;
				}
//				for(a=0;a<(w-malas)*23;a++){
//					entrada[a]=buf2[a+7];
//				}
//		if(ant!=buf2[3]){
			if(malas>0){
				ack1=ack1+malas-1;
				if(ack1==-1)  ack1=3;
				ack1=ack1%4;
			}else{
				ack1=(ack1+ctoi(buf2[5]))%4;
			}
			fprintf(f_out, "%s", entrada);
		  armarTrama(ack1);				//Armo la trama
//		}
			ant=buf2[3];
      }else if(NOFRAME == ret){
		     	if(buf2[5]=='0' && finarchivo==1){
						final=1;
					}
	printf("La trama no fue recibida -> %s\n", buf2);
//	fprintf(f_out, "%s", buf2);
	
      }else if(ret == FINCONEX){
	
	printf("Se terminó la conexion con -> %d\n", conexion);
//	buf2[0] = 0x01;
//  buf2[1] = '\0';
	
	break;
      }
//  armarTrama(ack1);				//Armo la trama
  printf("Se enviará la trama -> %s\n", buf1);
	to_physical_layer(buf1, conexion);			//Envio la trama
//  fprintf(f_out, "\n");
if(final==1) break;

//      printf("Mensaje a enviar -> %s\n",buf2);
//      to_physical_layer(buf2, conexion);		/* Se envía el mensaje [Replica de la trama recibida por el cliente] */
    }	    
    /* Se cierra la conexion */
    fclose(f_out);
    close(conexion);
    
    clientes++;

    
  }
  

  return 0;
}
