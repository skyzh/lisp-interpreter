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
def read_list(r)
  data = []

  if r.next != "("
    raise "expected '('"
  end

  while (token = r.peek) != ")"
    unless token
      raise "expected ')', got EOF"
    end
    data.push(read_from(r))
  end

  r.next

  data
end

# @param [Reader] r
def read_atom(r)
  token = r.next

  case token
  when /^-?[0-9]+$/ then
    token.to_i
  when /^-?[0-9][0-9.]*$/ then
    token.to_f
  when /^"(?:\\.|[^\\"])*"$/ then
    token
  when "nil" then
    nil
  when "true" then
    true
  when "false" then
    false
  else
    token.to_sym
  end
end

# @param [Reader] r
def read_from(r)
  if r.peek == "("
    read_list(r)
  else
    read_atom(r)
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
