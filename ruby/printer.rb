# @return [String]
def pr_str(x, print_readably = false)
  case x
  when List then "(#{x.map { |_x| pr_str(_x, print_readably) }.join(" ")})"
  when Vector then "[#{x.map { |_x| pr_str(_x, print_readably) }.join(" ")}]"
  when Hash then "{#{x.map { |_x, _y| "#{pr_str(_x, print_readably)} #{pr_str(_y)}" }.join(" ")}}"
  when nil then "nil"
  when Proc then "#<function>"
  when String
    if x[0] == "\u029e" then ":#{x[1..-1]}"
    else
      if print_readably then x.inspect else x end
    end
  else x.to_s
  end
end
