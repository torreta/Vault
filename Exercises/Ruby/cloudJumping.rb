# Complete the jumpingOnClouds function below.
def jumpingOnClouds(c)

    cant_nubes = c.size;
    cant_saltos = 0;
    posicion = 0;
    se_sumo = false; #uso booleano
       
    while (posicion <= cant_nubes - 1) do
            puts("aqui datos")
            puts("saltos " + cant_saltos.to_s)
            puts("posicion " + posicion.to_s)
            puts("lo que esta en ese lugar " + c[posicion].to_s)

        #identificar si puedo saltar + 1 o +2
        if(posicion + 2 < cant_nubes  ) #no se salga del array
          puts("evaluado + 2")
            if(c[ posicion + 2 ].to_s == "0" )
              puts("evaluado +2 sirve")
                se_sumo = true; #true
                # actualizar posicion
                posicion = posicion + 2;
                # subir el contador de pasos 
                cant_saltos = cant_saltos + 1;
            end
        end
        if((posicion + 1 < cant_nubes)) #no se salga del array
          puts("evaluado + 1")
            if( se_sumo == false )
              if(c[ posicion + 1 ].to_s == "0" )
                puts("evaluado +1 sirve")
                se_sumo = true
                # actualizar posicion
                posicion = posicion + 1;
                # subir el contador de pasos 
                cant_saltos = cant_saltos + 1;
              end
            else
              puts("ya se sumo no hago nada")
            end
        end

        # reseteo el hecho que ya sume
        if(se_sumo == false)
         puts("sumo porque no sumo")
          posicion = posicion +1;
        end
        # 0 0 1 0 0 1 0
        se_sumo = false
    end

    return cant_saltos

end