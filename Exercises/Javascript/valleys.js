// Complete the countingValleys function below.
function countingValleys(n, s) {
    var pasos = n;
    var point_height = 0;
    let valles = 0;

    for (let i = 0; i<= pasos ; i++ ){
        //sacar el caracter
        if (s.substr(i,1) == 'U') {
            point_height++;
        }
        if (s.substr(i,1) == 'D') {
            //en caso de que bajes de nivel del mar
            if (point_height == 0) {
                valles++;
            }
             point_height--;
        }
    }
    return valles;
    

}
