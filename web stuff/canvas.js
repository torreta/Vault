
var d = document.getElementById("dibujito");
var lienzo = d.getContext("2d");
var lineas = 30;
var l = 0;
var yi, xf;
while (l < lineas)
{
  yi = 10 * l;
  xf = 10 * (l + 1);
dibujarLinea("#0000ff", 0, yi, xf, 300);
console.log("linea " + l);
  l = l + 1;
}
var m = 0;
var yy, xx;
while (m < lineas)
{
  yy = 10 * m;
  xx = 10 * (m + 1);
dibujarLinea("#0000ff", xx, 0, 300, yy);
console.log("linea " + m);
  m = m + 1;
}
var ll = 0;
var yil, xfl;
while (ll < lineas)
{
  yil = 10 * ll;
  xfl = 10 * (ll + 1);
dibujarLinea("#00ff00", yil, xfl, 0, 300 );
console.log("linea " + ll);
  ll = ll + 1;
}
var lll = 0;
var yill, xfll;
while (lll < lineas)
{
  yill = 10 * lll;
  xfll = 10 * (lll + 1);
dibujarLinea("#ff0000", 300,0,yill,xfll);
console.log("linea " + lll);
  lll = lll + 1;
}
var ls = 0;
var yis, xfs;
while (ls < lineas)
{
  yis = 10 * ls;
  xfs = 10 * (ls + 1);
dibujarLinea("#ff0000", 250, yis, 150, xfs, );
console.log("linea " + ls);
  ls = ls + 1;
}
dibujarLinea("#aaf", 1, 1, 1, 300);
dibujarLinea("#aaf", 1, 1, 300, 1);
dibujarLinea("#aaf", 1, 300, 300, 300);
dibujarLinea("aaf",300,300,300,1);

function dibujarLinea(color, xinicial, yinicial, xfinal, yfinal)
{
lienzo.beginPath();
lienzo.strokeStyle = color;
lienzo.moveTo(xinicial, yinicial);
lienzo.lineTo(xfinal, yfinal);
lienzo.stroke();
lienzo.closePath();
}
