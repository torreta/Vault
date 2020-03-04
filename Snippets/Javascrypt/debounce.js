//  https://www.youtube.com/watch?v=B1P3GFa7jVc/*  */
{/* <button id="myid"> click me </button> */} 

//  puedes probar en codepen 
//  esta es una funcion de orden mayor para evitar la ejecucion doble de una
//  funcion y de ese modo, por ejemplo,, prevenir doble envio de datos a un servidor por
//  multiples clicks de un usuario.
//  la manera en que funciona es que usa timeouts, los renueva si se intenta usar sin 
//  que se venza el plazo de espera

const debounce = (fn, delay) => {

    let timeoutID;
    
    return function(...args){
      if(timeoutID){
        clearTimeout(timeoutID)
      }
      
        timeoutID = setTimeout(() => {
          fn(...args)
        }, delay)
    };
  };
  
  document.getElementById("myid").addEventListener("click", debounce(e => {
    console.log("clicked")
  }, 2000 ));


