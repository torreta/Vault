// https://www.youtube.com/watch?v=9NPPsP-4LBg
{/* <button id="myid"> click me </button> */} 


//  puedes probar en codepen 
//  esta es una funcion de orden mayor para evitar la ejecucion doble de una
//  funcion y de ese modo, por ejemplo,, prevenir doble envio de datos a un servidor por
//  multiples clicks de un usuario.
//  la manera en que funciona es que usa timeouts, 
//  evita que se disparen eventos por un tiempo establecido

const throttle = (fn, delay) => {
    let last = 0;
    return (...args) => {
      const now = new Date().getTime();
      if (now - last < delay) {
        return;
      }
      last = now;
      return fn(...args);
    };
  };
  
  document.getElementById("myid").addEventListener(
    "click",
    throttle(e => {
      console.log("I was clicked");
    }, 5000)
  );
  