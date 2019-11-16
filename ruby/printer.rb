# @return [String]
def pr_str(x)
  case x
  when Array then
    "(#{x.map { |_x| pr_str(_x) }.join(" ")})"
  when nil then
    "nil"
  when Proc then
    "#<function>"
  else
    x.to_s
  end
end
