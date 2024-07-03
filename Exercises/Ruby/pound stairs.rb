#!/bin/ruby
# Write a program that prints a staircase of size n.

n = gets.strip.to_i

(1..n).each do |i|
    spaces = ' ' * (n - i)
    hashes = '#' * i
    puts spaces + hashes
end