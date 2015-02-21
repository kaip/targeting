class Runner
  def initialize(data, expression)
    @data = data
    @expression = expression
  end

  def data_matches_expression?
    @data == JSON.parse(@expression)
  end
end