require 'readline'
require_relative 'reader'
require_relative 'printer'
require_relative 'env'
require_relative 'core'

def READ(x)
  read_str(x)
end

# @param [Env] env
def EVAL(x, env)
  case x
  when Array then
    if x.empty?
      x
    else
      case x[0]
      when :def! then
        env.set(x[1], EVAL(x[2], env))
        env.get(x[1])
      when :"let*" then
        new_env = Env.new(env, [], [])
        x[1].each_slice(2) do |binding, val|
          new_env.set(binding, EVAL(val, new_env))
        end
        EVAL(x[2], new_env)
      when :do then
        eval_result = eval_ast(x.drop(1), env)
        eval_result.last
      when :if then
        cond = EVAL(x[1], env)
        if cond != false && cond != nil then
          EVAL(x[2], env)
        else
          if x.length > 3
            EVAL(x[3], env)
          else
            nil
          end
        end
      when :"fn*" then
        lambda do |*args|
          new_env = Env.new(env, x[1], args)
          EVAL(x[2], new_env)
        end
      else
        eval_result = eval_ast(x, env)
        eval_result[0][*eval_result.drop(1)]
      end
    end
  else
    eval_ast(x, env)
  end
end

def PRINT(x)
  puts(pr_str(x))
end

def default_environment
  env = Env.new(nil, [], [])
  $core_ns.each_pair do |k, v|
    env.set(k, v)
  end
  env
end

def rep(x)
  @repl_env ||= default_environment
  PRINT(EVAL(READ(x), @repl_env))
end

# @param [Env] env
def eval_ast(ast, env)
  case ast
  when Symbol
    env.get(ast)
  when Array
    ast.map { |x| EVAL(x, env) }
  else
    ast
  end
end

while (buf = Readline.readline("user> ", true))
  begin
    rep(buf)
  rescue Exception => e
    puts "Error: #{e}"
    puts "\t#{e.backtrace.join("\n\t")}"
  end
end
