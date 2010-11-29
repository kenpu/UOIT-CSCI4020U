from grammar import *
from pprint import pprint
"""
terminals
  +, *, id, (, )
non-terminals
  E T E' T' F 
"""
G = [
  ('E', ['T',"E'"]),   # E -> T E'
  ("E'", ['+', 'T', "E'"]),
  ("E'", []),          # E' -> + T E' | epsilon
  ("T", ['F', "T'"]),
  ("T'", ["*", "F", "T'"]),
  ("T'", []),
  ("F", [ '(', 'E', ')' ]),
  ("F", [ 'id' ])
]

print_grammar(G)

print "Symbols of G are:"
print grammar_symbols(G)

print "\nThe first-sets of grammar symbols are:"
first_sets = build_first_sets(G)
pprint(dict(first_sets))

follow_sets = build_follow_sets(G, 'E', first_sets)

print "\nThe follow-sets of grammar symbols are:"
pprint(dict(follow_sets))


print "\nThe predictive parsing table is:"
M = build_parse_table(G, 'E')
pprint(M)


