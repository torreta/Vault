#!/bin/ruby

a0,a1,a2 = gets.strip.split(' ')
a0 = a0.to_i
a1 = a1.to_i
a2 = a2.to_i
b0,b1,b2 = gets.strip.split(' ')
b0 = b0.to_i
b1 = b1.to_i
b2 = b2.to_i

alice = 0
bob = 0

if a0 != b0
    if a0 > b0
        alice = alice + 1
    else
        bob = bob + 1
    end
end


if a1 != b1
    if a1 > b1
        alice = alice + 1
    else
        bob = bob + 1
    end
end


if a2 != a2
    if a2 > b2
        alice = alice + 1
    else
        bob = bob + 1
    end
end

puts "#{alice} #{bob}"
