#!/bin/ruby
# Given five positive integers, find the minimum and maximum values
# that can be calculated by summing exactly four of the # # five integers.
# Then print the respective minimum and maximum values as a single
# line of two space-separated long integers.

arr = gets.strip
arr = arr.split(' ').map(&:to_i)

original = arr

sum = original.max(4) {|a, b| a <=> b }
res = original.min(4) {|a, b| a <=> b }

puts "#{res.sum} #{sum.sum}"
