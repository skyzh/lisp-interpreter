require_relative 'types'

$core_ns = {
    :+ => -> (a, b) { a + b },
    :- => -> (a, b) { a - b },
    :* => -> (a, b) { a * b },
    :/ => -> (a, b) { a / b },
    :"=" => -> (a, b) { a == b },
    :< => -> (a, b) { a < b },
    :<= => -> (a, b) { a <= b },
    :> => -> (a, b) { a > b },
    :>= => -> (a, b) { a >= b },
    :count => -> (x) { x == nil ? 0 : x.length },
    :empty? => -> (x) { x.length == 0 },
    :list => -> (*args) { List.new(args) },
    :list? => -> (x) { x.is_a? List },
    :"pr-str" => -> (*args) { args.map { |x| pr_str(x, true) }.join(" ") },
    :str => -> (*args) { args.map { |x| pr_str(x, false) }.join("") },
    :prn => -> (*args) { puts args.map { |x| pr_str(x, true) }.join(" "); nil },
    :println => -> (*args) { puts args.map { |x| pr_str(x, false) }.join(" "); nil },
    :not => -> (x) { !x }
}
