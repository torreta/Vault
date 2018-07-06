# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# largo
@l = gets.to_i
# alto
@h = gets.to_i
# texto a a traducir
@t = gets.chomp
# normal letters to comparre
normal_letters =  "ABCDEFGHIJKLMNOPQRSTUVWXYZ?".split('')

# now big letters array
ascii_letters = Array.new(@h)
i = 0
@h.times do
    ascii_letters[i] = Array.new(normal_letters.length);
    i = i + 1
end

# STDERR.puts normal_letters.class
# linea de texto a transformar
i = 0

@h.times do

    row = gets.chomp
    j = 0
    (row.length/@l).times do
        ascii_letters[i][j] = row[(j*@l)..((j*@l)+(@l-1))];
        # STDERR.puts  ("i:"+i.to_s+" j:"+j.to_s);
        # STDERR.puts  ascii_letters[i][j]
        j = j +1
    end

    i=i+1
end

letter_indexes = Array.new()

# find the index of a letters to make use of the array later.
i = 0
j = 0
@t.length.times do

#   STDERR.puts  @t[i]
   j = 0

   normal_letters.each do |letter|
    if(@t[i].upcase == letter)
        letter_indexes.push(j)
    end
    j=j+1
   end

    #   if the size hasnt changed means it didndt push a letter
    #   that means a match on letter wasnt found so we must push
    #   the special character "?"
   if letter_indexes.length - 1 < i
        letter_indexes.push(26) # "?"
   end

    i=i+1
end



# ahora que tengo el indice de cada letra puedo empezar a imprimirlos
# linea por linea, de arriba a abajo, como una impresora

i = 0
@h.times do

    buffer_line = ""

    letter_indexes.each do |indice|

        if indice.nil? == false
            buffer_line = buffer_line + ascii_letters[i][indice]
        end

    end
    i = i +1
    # STDERR.puts buffer_line
    puts buffer_line
end


# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

# puts "answer"
