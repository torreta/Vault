  /*
      FLUJO:

      - me llega un mensaje:

      1. verifico datos: para saber si la tarea esta bien formada... y tiene su info completa.

      2.1. si esta bien formada, la proceso...

          2.1.1. verifico el tipo de tarea:
              
              2.1.1.1. si es un ACK, busco la tarea y la aplico el cambio de estado. (recibida, completada)

              2.1.1.2. si es una tarea, verifico el source.
                  
                  - mia? ignoro.

                  - remota? creo el task, aviso que lo recibi proceso, digo que lo complete

      2.2. si no esta bien formada
          
      - la ignoro e inserto en el log.

  */
