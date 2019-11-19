require_relative 'types'

class Reader
  # @param [[String]] tokens
  def initialize(tokens)
    @tokens = tokens
    @token_cnt = 0
  end

  def next
    token = @tokens[@token_cnt]
    @token_cnt = @token_cnt + 1
    token
  end

  def peek
    @tokens[@token_cnt]
  end
end


# @param [String] str
def read_str(str)
  read_from(Reader.new(tokenize(str)))
end

# @param [Reader] r
# @param [String] left
# @param [String] right
def read_list(r, left, right, constructor)
  data = constructor.new

  if r.next != left
    raise "expected '#{left}'"
  end

  while (token = r.peek) != right
    unless token
      raise "expected '#{right}', got EOF"
    end
    data.push(read_from(r))
  end

  r.next
  data
end

# @param [String] token
# @return String
def parse_str(token)
  token[1..-2].gsub(/\\./, {"\\\\" => "\\", "\\n" => "\n", "\\\"" => '"'})
end

# @param [Reader] r
def read_atom(r)
  token = r.next

  case token
  when /^-?[0-9]+$/ then token.to_i
  when /^-?[0-9][0-9.]*$/ then token.to_f
  when /^"(?:\\.|[^\\"])*"$/ then parse_str(token)
  when /^"/ then raise "expected '\"', got EOF"
  when /^:/ then "\u029e#{token[1..-1]}"
  when "nil" then nil
  when "true" then true
  when "false" then false
  else token.to_sym
  end
end

# @param [Reader] r
def read_from(r)
  case r.peek
  when '(' then read_list(r, '(', ')', List)
  when '[' then read_list(r, '[', ']', Vector)
  when '{' then Hash[read_list(r, '{', '}', Array).each_slice(2).to_a]
  else read_atom(r)
  end
end

TOKEN_REGEX = /[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/

# @param [String] x
# @return [[String]]
def tokenize(x)
  x.scan(TOKEN_REGEX)
      .map { |token| token[0] }
      .select { |token| token != "" }
end
