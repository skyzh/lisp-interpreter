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
    :list => -> (*args) { args },
    :list? => -> (x) { x.is_a? Array },
    :prn => -> (x) { puts pr_str(x); nil }
}
