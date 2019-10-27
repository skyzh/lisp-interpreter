require "readline"

def READ(x)
  x
end

def EVAL(x)
  x
end

def PRINT(x)
  puts x
end

def rep(x)
  PRINT(EVAL(READ(x)))
end

while (buf = Readline.readline("user> ", true))
  rep(buf)
end
