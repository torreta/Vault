/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var surfaceN = parseInt(readline()); // the number of points used to draw the surface of Mars.
for (var i = 0; i < surfaceN; i++) {
    var inputs = readline().split(' ');
    var landX = parseInt(inputs[0]); // X coordinate of a surface point. (0 to 6999)
    var landY = parseInt(inputs[1]); // Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
}

var trust

// game loop
while (true) {
    var inputs = readline().split(' ');
    var X = parseInt(inputs[0]);
    var Y = parseInt(inputs[1]);
    var hSpeed = parseInt(inputs[2]); // the horizontal speed (in m/s), can be negative.
    var vSpeed = parseInt(inputs[3]); // the vertical speed (in m/s), can be negative.
    var fuel = parseInt(inputs[4]); // the quantity of remaining fuel in liters.
    var rotate = parseInt(inputs[5]); // the rotation angle in degrees (-90 to 90).
    var power = parseInt(inputs[6]); // the thrust power (0 to 4).

    // Write an action using print()
    // To debug: printErr('Debug messages...');

    if (Y > 1000  ) {
        trust = 3
    }

    if (Y < 1000  ) {
        trust = 4
    }

    if (Y < 400  ) {
        trust = 4
    }


    if (Y < 25  ) {
        trust = 0
    }
    // 2 integers: rotate power. rotate is the desired rotation angle (should be 0 for level 1), power is the desired thrust power (0 to 4).
    print('0'+" "+trust );
}
