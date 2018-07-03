/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var n = parseInt(readline()); // the number of temperatures to analyse
var inputs = readline().split(' ');
var closestPos = 999999;
var closestNeg = -999999;
var closest = 0;
var cant = 0;

for (var i = 0; i < n; i++) {
    var t = parseInt(inputs[i]); // a temperature expressed as an integer ranging from -273 to 5526

    printErr(t)

    // if positive
    if (t >= 0 && t <= closestPos ){
        closestPos = t;
    }

    // if negative
    if (t < 0 && t > closestNeg ){
        closestNeg = t;
    }

    cant++;

}

// Write an action using print()
// To debug: printErr('Debug messages...');

  printErr(closestPos +" "+ closestNeg+" "+cant)

    // closest of the two
    if (closestPos <= -closestNeg) {
        closest = closestPos
    }

    if(closestPos > -closestNeg){
        closest = closestNeg
    }

    if (cant === 0) {
        closest = 0
    }

print(closest);
