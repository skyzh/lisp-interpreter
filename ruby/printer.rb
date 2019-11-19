# @return [String]
def pr_str(x)
  case x
  when List then "(#{x.map { |_x| pr_str(_x) }.join(" ")})"
  when Vector then "[#{x.map { |_x| pr_str(_x) }.join(" ")}]"
  when Hash then "{#{x.map { |_x, _y| "#{pr_str(_x)} #{pr_str(_y)}" }.join(" ")}}"
  when nil then "nil"
  when Proc then "#<function>"
  else x.to_s
  end
end
