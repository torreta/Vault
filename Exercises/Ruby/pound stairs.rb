#!/bin/ruby
# Observe that its base and height are both equal to , and the image is drawn using
# '#' symbols and spaces. The last line is not preceded by any spaces.
# Write a program that prints a staircase of size .

n = gets.strip.to_i
$i = 0
linea = ""

while  $i < n  do
    linea = linea + " "
    $i +=1
end

$i = 0
#puts linea.size

#while $i < n  do
#    linea.insert($i,'#')
#    puts linea.reverse
#    $i +=1
#end

$y = 1
$i2 = 0
while  $i < n  do
    linea.clear
    $i2 = 0
    while  $i2  < n  do
        if($i2 < (n-$y))
            linea = linea + " "
        else
           linea = linea + "#"
        end
        $i2 +=1
    end
    puts linea
    $y +=1
    $i +=1
end
