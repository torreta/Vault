#!/bin/ruby
# An array is a type of data structure that stores elements of the same type
# in a contiguous block of memory. In an array, , of size , each memory
# location has some unique index,  (where ), that can be referenced as
#  (you may also see it written as ).
#
# Given an array, , of  integers, print each element in reverse order
# as a single line of space-separated integers.
#
# Note: If you've already solved our C++ domain's Arrays Introduction
# challenge, you may want to skip this.
#
# from hackerrank, just to practice
# Sample Input
#
# 4
# 1 4 3 2
# Sample Output
#
# 2 3 4 1

n = gets.strip.to_i
arr = gets.strip
arr = arr.split(' ').map(&:to_i)

print arr.reverse.join(' ')
