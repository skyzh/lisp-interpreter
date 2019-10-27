require 'readline'
require_relative 'reader'
require_relative 'printer'

def READ(x)
  read_str(x)
end

def EVAL(x)
  x
end

def PRINT(x)
  puts(pr_str(x))
end

def rep(x)
  PRINT(EVAL(READ(x)))
end

while (buf = Readline.readline("user> ", true))
  begin
    rep(buf)
  rescue Exception => e
    puts "Error: #{e}"
    puts "\t#{e.backtrace.join("\n\t")}"
  end
end
