#!/bin/ruby
# Given an array of integers, calculate which fraction of its elements
# are positive, which fraction of its elements are negative,
# and which fraction of its elements are zeroes, respectively.
# Print the decimal value of each fraction on a new line./

n = gets.strip.to_i
arr = gets.strip
arr = arr.split(' ').map(&:to_i)

divisor = arr.length + 0.0

negativos = 0.0
positivos = 0.0
zeros = 0.0

 arr.each do |i|
     if(i == 0) then
         zeros = zeros +1
     end
     if(i > 0) then
         positivos = positivos + 1
     end
     if(i < 0) then
         negativos = negativos +1
     end
 end

    puts (positivos / divisor)
    puts (negativos / divisor)
    puts (zeros / divisor)
