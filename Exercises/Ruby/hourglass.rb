#!/bin/ruby

require 'json'
require 'stringio'

# Complete the hourglassSum function below.
def hourglassSum(arr)

     max = -99 #why 99? because, i need to register a maximun even if the numbers are negative 
     sum = 0
    for i in 0..(arr.size()-2-1)
        for y in 0..(arr.size()-2-1)

            a = arr[i][y]
            b = arr[i][y+1]
            c = arr[i][y+2]
            d = arr[i+1][y+1]
            e = arr[i+2][y]
            f = arr[i+2][y+1]
            g = arr[i+2][y+2]

            sum = a + b + c + d + e + f + g

            if max <= sum
                max = sum
                puts i
                puts y
            end

            sum = 0

        end

    end

    return max
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

arr = Array.new(6)

6.times do |i|
    arr[i] = gets.rstrip.split(' ').map(&:to_i)
end

result = hourglassSum arr

fptr.write result
fptr.write "\n"

fptr.close()
