#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "common.h"



  char crc_ever[9];		//agregado

		/*	
		Funcion: te indica (retorna) la proxima posicion del arreglo que es distinto de cero,
			lo utilizo para la divicion por bits para poder continuar con la divicion de
			la manera correcta.
		@param apuntador a una cadena de caracteres
		*/  
		
	int posicionar (char *esta){
	int i=0; 
	int a = strlen(esta);
		
		for(i=0;i<a;i++){
			if(esta[i]=='1'){return i;}
		
		}
		//printf("la cage");	
		return -1;


	}
/*	
	Funcion: una implementacion para caracteres del XOR logico. te retorna el caracter correspondiente 0 o 1.
		ambos caracteres deben ser ceros o uno, de lo contrario retorna vacio.
	@param caracter b
	@param caracter a
*/  
	char XOR (char a,char b){

		if (a == b){return '0';}else{return '1'; }

		return '\0';
	}
/*
	create_crc:retorna el resto de la divicion binaria para poderla concatenar como crc en la trama. 
	@param *tramax: apuntador a cadena de caracter. de minimo tama�o >= al del crc.
	@param crsex: apuntador a una cadena de caracter de tama�o 8 minimo. aqui se almacenara el valor resultado
		del resto de la divicion binaria que generara el crc.
*/

	void create_crc(char *tramax,char *crsex){//tramax[100]

	int tam_trama=0;
		tam_trama = strlen(tramax);

		char *aux; //tramax.lenght	
		aux=(char*)calloc(tam_trama,sizeof(char));

		strcpy(aux,tramax);

		
	char result[8];
	int cond =1;
	int i=0; int j=0;
	int tam = strlen(crc_ever);


	while (cond){

		for (i=0;i<tam;i++){
			if(i+j<tam_trama){
			
			aux[i+j]=XOR(aux[i+j],crc_ever[i]);//hago _XOR XD

			}else{
				cond=0;// printf("entre aqui \n"); //false
							
					strcpy(result,aux+(tam_trama - (tam -1 ))); // lol +1 estrella qui para mi... XD
					strcpy(crsex,result); //copio el resultado en el vector resultado.
					//printf("aux quedo: %s \n",aux);		
					break;
				//puedo hacer el return de esta cosa aqui
			//pajazo
			}
		
		}
		
		j=posicionar(aux); //te pone a donde queda en proximo 1
		

	}


	//free (aux); //libero a aux

	
	}

/*
	comprobar:te dice cuanto dio el contador de "unos", si hay almenos 1 uno, esto esta malo 
	@param *trama: apuntador a cadena de caracter. de minimo tama�o >= al del crc. y es para evaluar si
	es toda "ceros" de lo contrario esta mala.
	
*/
	
	int comprobar (char *trama){
	
	int i=0;
	int cont = 0;
	int tam = strlen(trama);
	
		for (i=0;i<tam;i++){
			if(trama[i]!= '0'){
				cont++;
			}
		}
	
	return cont;
	
	}

	
	void testeo2 (char *tramax,char *crsex){//tramax[100]

	int tam_trama=0;
		tam_trama = strlen(tramax);

		char *aux; //tramax.lenght	
		aux=(char*)calloc(tam_trama,sizeof(char));

		strcpy(aux,tramax);

		
	char result[8];
	int cond =1;
	int i=0; int j=0;
	int tam = strlen(crc_ever);


	while (cond){

		for (i=0;i<tam;i++){
			if(i+j<tam_trama){
			
			aux[i+j]=XOR(aux[i+j],crc_ever[i]);//hago _XOR XD

			}else{
				cond=0;// printf("entre aqui \n"); //false
							
					strcpy(result,aux+(tam_trama - (tam -1 ))); // lol +1 estrella qui para mi... XD
					strcpy(crsex,result); //copio el resultado en el vector resultado.
					//printf("aux quedo: %s \n",aux);		
					break;
				//puedo hacer el return de esta cosa aqui
			//pajazo
			}
		
		}
		
		j=posicionar(aux); //te pone a donde queda en proximo 1
		

	}


	//free (aux); //libero a aux


	}

	int main(int argc, char *argv[])
	{
		char crc[9];
		//char crco[100];//probando otra declaracion
		char *crco;
		char result[8];
		int x=0;
		crco=(char*)calloc(100,sizeof(char));
		
		
		strcpy(crc_ever,"101101001"); 	//agregado
		printf("%s  es el crc \n \n",crc_ever);

		strcpy(crco,"1110100101011010011101101001010110100111011010010101101001010110100111011010010101101001010000000000");
		//printf("entro crco: %s \n",crco);	
		x=strlen(crco);
		//printf("size %i \n",x);	
		
		strcpy(result,"00000000");	
		printf("entro: %s \n",result);
		
			
		//printf("entro crco: %s \n",crco);	
		
		create_crc(crco,result);
		
		printf("salio: %s \n",result);	
		
		strcpy(crco+92,result);
		//printf("entro crco: %s \n",crco);	//aqui pruebo si esta remplazando las ultimas 8 posiciones correctamente
		
		testeo2(crco,result);
		
		printf("salio: %s \n",result);	
		
		if (comprobar( result)>0){printf("ta malo");}else{printf("ta weno");} 
		
		//free(crco);//libero a willy XD
		
		//exit(1);
		
		/*
		por cierto`por alguna razon no lo esta haciendo bien, velo quizas pilles la razon
		
		*/
	}