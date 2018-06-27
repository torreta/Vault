#!/bin/ruby
# Given a square matrix of size , calculate the absolute difference between the sums of its diagonals.
#
# Input Format
#
# The first line contains a single integer, . The next  lines denote the matrix's rows, with each line containing space-separated integers describing the columns.
#
# Constraints
#
# Output Format
#
# Print the absolute difference between the two sums of the matrix's diagonals as a single integer.
#
# Sample Input
#
# 3
# 11 2 4
# 4 5 6
# 10 8 -12
# Sample Output
#
# 15



n = gets.strip.to_i
a = Array.new(n)
for a_i in (0..n-1)
    a_t = gets.strip
    a[a_i] = a_t.split(' ').map(&:to_i)
end

diag1 = 0
diag2 = 0
res = 0

for a_i in (0..n-1)
    diag1 = diag1 + a[a_i][a_i]
    diag2 = diag2 + a[n-1 - a_i][a_i]
end

if(diag1 >= diag2)
   sum = diag1 - diag2
else
    sum = diag2 - diag1
end


puts sum
