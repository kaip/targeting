class ExpressionEvaluator
  def initialize(data, expression)
    @data = data
    @expression = JSON.parse(expression)
  end

  def data_matches_expression?(expression = nil)
    expression = @expression if expression.nil?
    case expression.keys.first
    when 'and'
      data_matches_expression?(expression.values.first.first) &&
      data_matches_expression?(expression.values.first.last)
    when 'not'
      !data_matches_expression?(expression.values.first)
    when 'or'
      data_matches_expression?(expression.values.first.first) ||
      data_matches_expression?(expression.values.first.last)
    else
      @data[expression.keys.first] == expression.values.first
    end
  end
end