#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "common.h"

char dataFile[MAXNUMBIN];	//Tip: Pre-almacene la data del archivo de entrada
char toSend[MAX_PKT];		//Buffer de salida
char received[MAX_PKT];		//Buffer de entrada

frame myframe;			//Estructura frame a utilizar

/* Funcion que retorna un caracter dado
 * una secuencia binaria de 8 bit
 * @param argv Array de tamaño 8
 */
char traducir(char argv[]){
	char i=0,x=0;
	for (i=0;i<8;i++){
		if (argv[i]=='1'){
			x=x<<1;
			x=x|1;
		}else{
			x=x<<1;
		}
	}
	return x;
}

void createFrame(){
	//size_t n = ;
	char * pch,temp[strlen(dataFile)];
	strcpy(temp,dataFile);
	pch = strtok (temp,"|");

	strcpy(myframe.sourceMAC,pch);
	pch = strtok (NULL,"|");
	myframe.type=atoi(pch);
	pch = strtok (NULL,"|");
	strcpy(myframe.crc,pch);
	pch = strtok (NULL,"|");
	myframe.p.id=atoi(pch);
	pch = strtok (NULL,"|");
	myframe.p.ttl=atoi(pch);
	pch = strtok (NULL,"|");
	myframe.p.protocol=atoi(pch);
	pch = strtok (NULL,"|");
	strcpy(myframe.p.ipSource,pch);
	pch = strtok (NULL,"|");
	myframe.p.s.portSource=atoi(pch);
	pch = strtok (NULL,"|");
	myframe.p.s.seq=(seq_number)atoi(pch);
	pch = strtok (NULL,"|");
	myframe.p.s.ack=(seq_number)atoi(pch);
}

write_files(FILE *f, FILE *f_A ){
	fprintf(f,"%s",received);
	short i=0,n=strlen(received);
	for (i=0;i<n;i+=8){
		fprintf(f_A,"%c",traducir(received+i));
	}
}

int main(int argc, char *argv[])
{
 /**** Aquí debe de empezar a desarrollar su programa ****/
  FILE *fin=NULL;
  fin=fopen("server.info","r");
  fscanf(fin,"%s\n",dataFile);
  fclose(fin);
  createFrame();
  
  size_t n = strlen(dataFile),i=0,max;
  for(i=0;i<n;i++)
	dataFile[i]='\0';

	FILE *fous[argc-1],*fous_Ascii[argc-1];
	char name[128];
	int conex,ans;
	char *aux=NULL;
	for (i=0;i<argc-1;i++){
		sprintf(name,"dataClient%d.out",i);
		fous[i]=fopen(name,"w");
		sprintf(name,"dataClient%dAscii.out",i);
		fous_Ascii[i]=fopen(name,"w");
	}
	for (i=0;i<argc-1;i++){
		conex = initServer(argc, argv);
		while (1){
			ans = receiveMessagePhy(received,conex);
			if (received[0] == FIN){
				strcpy(toSend,received);
				
				
				sendMessagePhy(toSend,conex);
				
				
				closeConnection(conex);
				
				
				
				fprintf(fous[i],"\n");
				fprintf(fous_Ascii[i],"\n");
				break;
			}else{
				strcpy(toSend,received);
				write_files(fous[i],fous_Ascii[i]);
				sendMessagePhy(toSend,conex);
			}
		}
		if (i+2<=argc){
		aux=argv[1];
		argv[1]=argv[i+2];
		argv[i+2]=aux;
		}
	}	
	
	
	for (i=0;i<argc-1;i++){
		fclose(fous[i]);
		fclose(fous_Ascii[i]);
	}	
  return 0;
}

