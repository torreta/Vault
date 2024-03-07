#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "common.h"

#define Tam_trama 360
#define w_max 3



char dataFile[MAXNUMBIN];	//Tip: Pre-almacene la data del archivo de entrada
char toSend[MAX_PKT];		//Buffer de salida
char received[MAX_PKT];		//Buffer de entrada
int w=3;
frame myframe;			//Estructura frame a utilizar

char bitstohex(char *bits){
		/*
			no creo que haga falta mas explicacion mas que le pases un buffer de 4 char 0's o 1's
			y te devuelve el valor hexa de ese buffer
		*/
		
		if((bits[0]=='0')&&(bits[1]=='0')&&(bits[2]=='0')&&(bits[3]=='0')){return '0';}
		if((bits[0]=='0')&&(bits[1]=='0')&&(bits[2]=='0')&&(bits[3]=='1')){return '1';}
		if((bits[0]=='0')&&(bits[1]=='0')&&(bits[2]=='1')&&(bits[3]=='0')){return '2';}
		if((bits[0]=='0')&&(bits[1]=='0')&&(bits[2]=='1')&&(bits[3]=='1')){return '3';}
		if((bits[0]=='0')&&(bits[1]=='1')&&(bits[2]=='0')&&(bits[3]=='0')){return '4';}
		if((bits[0]=='0')&&(bits[1]=='1')&&(bits[2]=='0')&&(bits[3]=='1')){return '5';}
		if((bits[0]=='0')&&(bits[1]=='1')&&(bits[2]=='1')&&(bits[3]=='0')){return '6';}
		if((bits[0]=='0')&&(bits[1]=='1')&&(bits[2]=='1')&&(bits[3]=='1')){return '7';}
		if((bits[0]=='1')&&(bits[1]=='0')&&(bits[2]=='0')&&(bits[3]=='0')){return '8';}
		if((bits[0]=='1')&&(bits[1]=='0')&&(bits[2]=='0')&&(bits[3]=='1')){return '9';}
		if((bits[0]=='1')&&(bits[1]=='0')&&(bits[2]=='1')&&(bits[3]=='0')){return 'A';}
		if((bits[0]=='1')&&(bits[1]=='0')&&(bits[2]=='1')&&(bits[3]=='1')){return 'B';}
		if((bits[0]=='1')&&(bits[1]=='1')&&(bits[2]=='0')&&(bits[3]=='0')){return 'C';}
		if((bits[0]=='1')&&(bits[1]=='1')&&(bits[2]=='0')&&(bits[3]=='1')){return 'D';}
		if((bits[0]=='1')&&(bits[1]=='1')&&(bits[2]=='1')&&(bits[3]=='0')){return 'E';}
		if((bits[0]=='1')&&(bits[1]=='1')&&(bits[2]=='1')&&(bits[3]=='1')){return 'F';}
		
	return '\0';
}

char* hextobit(char hex){
		
		/*
			esta fucion le pasas un char y te retorna un mini buffer de 4 posiciones con la representacion
			en hexa del char que le diste.
		*/
		char *hexy = NULL;
		hexy = (char*)calloc(4,sizeof(char));
		
		if(hex=='0'){ hexy[0]='0';hexy[1]='0';hexy[2]='0';hexy[3]='0';	return hexy;}
		if(hex=='1'){ hexy[0]='0';hexy[1]='0';hexy[2]='0';hexy[3]='1';	return hexy;}
		if(hex=='2'){ hexy[0]='0';hexy[1]='0';hexy[2]='1';hexy[3]='0';	return hexy;}
		if(hex=='3'){ hexy[0]='0';hexy[1]='0';hexy[2]='1';hexy[3]='1';	return hexy;}
		if(hex=='4'){ hexy[0]='0';hexy[1]='1';hexy[2]='0';hexy[3]='0';	return hexy;}
		if(hex=='5'){ hexy[0]='0';hexy[1]='1';hexy[2]='0';hexy[3]='1';	return hexy;}
		if(hex=='6'){ hexy[0]='0';hexy[1]='1';hexy[2]='1';hexy[3]='0';	return hexy;}
		if(hex=='7'){ hexy[0]='0';hexy[1]='1';hexy[2]='1';hexy[3]='1';	return hexy;}
		if(hex=='8'){ hexy[0]='1';hexy[1]='0';hexy[2]='0';hexy[3]='0';	return hexy;}
		if(hex=='9'){ hexy[0]='1';hexy[1]='0';hexy[2]='0';hexy[3]='1';	return hexy;}
		if(hex=='A'){ hexy[0]='1';hexy[1]='0';hexy[2]='1';hexy[3]='0';	return hexy;}
		if(hex=='B'){ hexy[0]='1';hexy[1]='0';hexy[2]='1';hexy[3]='1';	return hexy;}
		if(hex=='C'){ hexy[0]='1';hexy[1]='1';hexy[2]='0';hexy[3]='0';	return hexy;}
		if(hex=='D'){ hexy[0]='1';hexy[1]='1';hexy[2]='0';hexy[3]='1';	return hexy;}
		if(hex=='E'){ hexy[0]='1';hexy[1]='1';hexy[2]='1';hexy[3]='0';	return hexy;}
		if(hex=='F'){ hexy[0]='1';hexy[1]='1';hexy[2]='1';hexy[3]='1';	return hexy;}
		
	return NULL;
}

void createFrame(){
	//size_t n = ;
	char * pch,temp[strlen(dataFile)];
	strcpy(temp,dataFile);
	pch = strtok (temp,"|");

	strcpy(myframe.destMAC,pch);
	pch = strtok (NULL,"|");
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
	strcpy(myframe.p.ipDest,pch);
	pch = strtok (NULL,"|");
	strcpy(myframe.p.ipSource,pch);
	pch = strtok (NULL,"|");
	myframe.p.s.portDest=atoi(pch);
	pch = strtok (NULL,"|");
	myframe.p.s.seq=(seq_number)atoi(pch);
	pch = strtok (NULL,"|");
	myframe.p.s.ack=(seq_number)atoi(pch);
}
#define BUG
 int main(int argc, char *argv[])
{
 	/**** Aquí debe de empezar a desarrollar su programa ****/
  FILE *fin=NULL, *fout=NULL;
  int conex, ans;
  fin=fopen("client.info","r");
  fscanf(fin,"%s\n",dataFile);
  fclose(fin);
  createFrame();
  
  size_t n = strlen(dataFile),i=0,max;
  for(i=0;i<n;i++)
	dataFile[i]='\0';
  
  conex = initClient(argc, argv);
  
  fin=fopen("data.in","r");
  fscanf(fin,"%s",dataFile);
  fclose(fin);

  n = MAX_PKT >> 2;
  max=strlen(dataFile);
  
  fout=fopen("data.out","w"); //aqui empiezo mi envio, recepcion
  if (max > 0){
		for (i=0;i<max;i+=n){
		
		strncpy(toSend,dataFile+i,n);
		//armo el header de la trama aqui?
		
		
		sendMessagePhy(toSend,conex);
		
		
		ans=receiveMessagePhy(received,conex);
		
		fprintf(fout,"%s",received);
	}	
	toSend[0]=2;
	sendMessagePhy(toSend,conex);
	ans=receiveMessagePhy(received,conex);
	closeConnection(conex);
	fclose(fout);
	}
  return 0;
}
