# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

@n = gets.to_i # Number of elements which make up the association table.
@q = gets.to_i # Number Q of file names to be analyzed.

# Arrays to push mimetypes and extensions
@mymes = Array.new()
@extensions = Array.new()

@n.times do
    # ext: file extension
    # mt: MIME type.
    ext, mt = gets.split(" ")

    @extensions.push(ext.downcase)
    @mymes.push(mt)
end

    STDERR.puts("Extentions")
    STDERR.puts(@extensions)
    STDERR.puts("Mymes")
    STDERR.puts(@mymes)

#arrays to push filenames an save to iterate later.
@fileNames = Array.new()

@q.times do
    fname = gets.chomp # One file name per line.
    @fileNames.push(fname)
end

 STDERR.puts("--------------FILES")
 STDERR.puts(@fileNames)

# new detecting if the file has the name of its extention on the array i made
# and print the type (detect, use that index to print for the other array.)

STDERR.puts("--------------RESULTS")


@to_compare = Array.new()

@fileNames.each do |fname|

    @to_compare = fname.split(".")

    if ( (fname.include? ".") && (fname[-1,1] != ".") && @extensions.index(@to_compare.last().downcase) )
        puts (@mymes[@extensions.index(@to_compare.last().downcase)])
    else
        puts"UNKNOWN"
    end

end
