require_relative 'expression_parser'

class ExpressionEvaluator
  def initialize(data, expression)
    @data = data
    @root = ExpressionParser.new(JSON.parse(expression)).parse
  end

  def data_matches_expression?
    @root.evaluate(@data)
  end
end