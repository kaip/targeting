class Runner
  def initialize(data, expression)
    @data = data
    @expression = JSON.parse(expression)
  end

  def data_matches_expression?(expression = nil)
    expression = @expression if expression.nil?
    if expression.keys.first == 'and'
      data_matches_expression?(expression.values.first.first) &&
      data_matches_expression?(expression.values.first.last)
    else
      @data[expression.keys.first] == expression.values.first
    end
  end
end