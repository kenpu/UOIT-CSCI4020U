import re
from collections import defaultdict

class Inputstream:
  def __init__(self, string):
    self.buf = list(string)
  def peek(self):
    return self.buf[0]
  def next(self):
    return self.pop(0)
  def size(self):
    return len(self.buf)

def print_grammar(G):
  """ Print out a grammar in the format of:
      Head -> (alternation) | (alternation) | ...
  """
  sym = None
  for (head, body) in sorted(G):
    if head is not sym:
      # print out a new rule
      sym = head
      print
      print "%s -> %s"  % (head, (" ".join(body) if body else "\\epsilon")),
    else:
      # print out an alternation
      print " | %s" % (" ".join(body) if body else "\\epsilon"),
  print 

def grammar_symbols(G):
  symbols = []
  for (head, body) in G:
    symbols.append(head)
    symbols.extend(body)
  return set(symbols)

epsilon = '\\epsilon'
end     = '$'

def is_terminal(X):
  return not re.match('^[A-Z]', X) and X not in [epsilon, end]

def recursive_descending_parse(G, start, input, **F):
  parse_table = F['parse_table']
  c = input.peek()
  (head, body) = parse_table[start,c]
  for X in body:
    if not is_terminal(X):
      recursive_descending_parse(G, X, input)
    else:
      c = input.next()
      if not X == c:
        raise Exception("Parsing failed.")

def build_parse_table(G, start):
  """
  Builds the predictive parsing table (algorithm 4.31 in text)
  """
  first_sets = build_first_sets(G)
  follow_sets = build_follow_sets(G, start, first_sets)

  M = dict()
  for (head, body) in G:
    for c in FIRST(body, first_sets):
      if is_terminal(c):
        # TODO: catch violations of LL(1) conditions
        # assert M[head, c] != (head, body)
        M[head, c] = (head, body)
    if epsilon in FIRST(body, first_sets):
      for b in follow_sets[head]:
        M[head, b] = (head, body)
  return M

def add(F, c, sym):
  if c in F[sym]:
    return False
  else:
    F[sym].append(c)
    return True
def addall(F, c_list, sym):
  modified = False
  for c in c_list:
    modified = modified or add(F, c, sym)
  return modified


def build_first_sets(G):
  """
  Building the first_sets of all the symbols of G (Section 4.4.2)
  """
  F = defaultdict(list)
  while True:
    modified = False

    for X in grammar_symbols(G):
      if is_terminal(X):
        modified = modified or add(F, X, X)

    for (X, body) in G:
      if not body:
        modified = modified or add(F, epsilon, X)
      else:
        for (i, Y) in enumerate(body):
          modified = modified or addall(F, [x for x in F[Y] if not x==epsilon], X)
          if not epsilon in F[Y]:
            break
        if all(epsilon in F[Y] for Y in body):
          modified = modified or add(F, epsilon, F[X])

    if not modified:
      break

  return F

def FIRST(body, F):
  first_set = []
  for X in body:
    first_set.extend(x for x in F[X] if not x == epsilon)
    if epsilon not in F[X]:
      break
  if all(epsilon in F[X] for X in body):
    first_set.append(epsilon)

  return set(first_set)

def build_follow_sets(G, start, first_sets):
  F = defaultdict(list)
  while True:
    modified = False
    modified = modified or add(F, end, start)
    # applying rules
    for (A, body) in G:
      for (i, B) in enumerate(body):
        if not is_terminal(B):
          beta = body[i+1:]
          if beta:
            modified = modified or addall(F, 
                       [x for x in FIRST(beta, first_sets) if not x == epsilon], B)
            if epsilon in FIRST(beta, first_sets):
              modified = modified or addall(F, F[A], B)
          else:
            modified = modified or addall(F, F[A], B)
    if not modified:
      break
  return F

