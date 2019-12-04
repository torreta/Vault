# Convert ["a", nil, "b", "c", nil] and ["d", nil, "e", "f"] into ["af", "be", "cd"] using Ruby in one sentence
# Consegui otras respuestas en internet asi que descidi tomar una menos comun
["a", nil, "b", "c", nil].compact.map{ |letra| letra.to_s + ["d", nil, "e", "f"].compact.pop().to_s}

