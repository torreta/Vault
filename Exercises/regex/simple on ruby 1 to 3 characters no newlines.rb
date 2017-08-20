test_string = gets(nil)

regex_pattern = '^(.{3}\.?){4}$'

print !/#{regex_pattern}/.match(test_string).nil? 
