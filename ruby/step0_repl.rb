require "readline"

def read(x)
  x
end

def eval(x)
  x
end

def print(x)
  p x
end

def rep(x)
  eval(read(x))
end

while (buf = Readline.readline("user> ", true))
  puts(rep(buf))
end
