#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "common.h"

char dataFile[MAXNUMBIN];	//Para pre-almacenar los datos del archivo de entrada
char toSend[MAX_PKT];		//Buffer para los datos a ser enviados
char received[MAX_PKT];		//Buffer para los datos a ser recibidos
int connection;			//La conexión
int ptr;
int numBin = 0;

frame myframe;			//Global frame

/* crea el mensaje actual a ser enviado */
void makeFrame()
{
  int i = 0;
  
  while(i < MAX_PKT)
  {
    if(ptr >= numBin - 1) break;
    toSend[i] = dataFile[ptr];
    i++;
    ptr++;
  }
  if(i < MAX_PKT)
  {
    if(i == 0){ toSend[0] = 0x01;
    i++;
    }
    while(i < MAX_PKT)
    {
      toSend[i] = 0x00;
      i++;
    }
  }
}

/* Pre almacena la data del archivo de entrada */
void fillDataFile(FILE *f)
{
  int i = 0;
  
  while(!feof(f))
  {
    dataFile[i] = fgetc(f);
    i++;
    numBin++;
  }
}

/* Carga la configuración */
void loadConfig()
{
  FILE *fileconfig = fopen("client.info", "r");
  
  if(!fileconfig){ puts("Error al abrir el archivo de configuración, saliendo del programa..."); exit(0); }
  
  char number[5];
  int i;
  
  fgets(myframe.destMAC, 13, fileconfig);
  getc(fileconfig);
  fgets(myframe.sourceMAC, 13, fileconfig);
  getc(fileconfig);
  
  char c;
  
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    number[i] = c;
    i++;
  }
  myframe.type = atoi(number);
  
  fgets(myframe.crc, 10, fileconfig);
  getc(fileconfig);
  
  memset(number, 0x00, 5);
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    number[i] = c;
    i++;
  }
  myframe.p.id = atoi(number);
  
  memset(number, 0x00, 5);
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    number[i] = c;
    i++;
  }
  myframe.p.ttl = atoi(number);
  
  memset(number, 0x00, 5);
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    number[i] = c;
    i++;
  }
  myframe.p.protocol = atoi(number);
  
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    myframe.p.ipDest[i] = c;
    i++;
  }
  
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    myframe.p.ipSource[i] = c;
    i++;
  }
  
  memset(number, 0x00, 5);
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    number[i] = c;
    i++;
  }
  myframe.p.s.portDest = atoi(number);
  
  memset(number, 0x00, 5);
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '|') break;
    number[i] = c;
    i++;
  }
  myframe.p.s.seq = atoi(number);
  
  memset(number, 0x00, 5);
  i = 0;
  while(TRUE)
  {
    c = getc(fileconfig);
    if(c == '.') break;
    number[i] = c;
    i++;
  }
  myframe.p.s.ack = atoi(number);
  
  myframe.payloadTemp = "Hello World";
  myframe.p.hl = 20;
  myframe.p.tl = 200;
  myframe.p.s.portSource = 2000;
  myframe.p.s.type = syn;
  myframe.ack = 0;
  myframe.tam = 1;
}

// The main
int main(int argc, char *argv[])
{
  //files
  FILE *filein  = fopen("data.in", "r");
  FILE *fileout = fopen("data.out", "w");
  
  loadConfig(); // Se carga la configuración

  if(!filein){ puts("ERROR: No se pudo abrir el archivo de entrada"); exit(0); }
  
  ptr = 0;
  
  fillDataFile(filein);	//Se pre-almacena los datos del archivo de entrada
  
  fclose(filein);
  
  //Se inicializa el cliente
  connection = initClient(argc, argv);
  
  int frame;
  
  while (TRUE)
  {
    makeFrame();					//Creo el frame
    sendMessagePhy(toSend, connection);			//Envio
    frame = receiveMessagePhy(received, connection);	//Recibo
    if(frame == FIN){ puts("Se terminó la conexión... Bye...!"); break; }
    else if(frame == FRAME) fprintf(fileout, "%s", received);
    else if(frame == LOST){
      fprintf(fileout, "%s", received);
    }
    
  }
  
  fflush(filein);
  fflush(fileout);
  
  closeConnection(connection);
  close(fileout);
  
  return 0;
}

