class EqualityNode
  def initialize(key, value)
    @key = key
    @value = value
  end

  def evaluate(data)
    data[@key] == @value
  end
end

class AndNode
  def initialize(child_nodes)
    @child_nodes = child_nodes
  end

  def evaluate(data)
    @child_nodes.all? {|node| node.evaluate(data) }
  end
end

class OrNode
  def initialize(child_nodes)
    @child_nodes = child_nodes
  end

  def evaluate(data)
    @child_nodes.any? {|node| node.evaluate(data) }
  end
end

class NotNode
  def initialize(child_nodes)
    @child_nodes = child_nodes
  end

  def evaluate(data)
    !@child_nodes.first.evaluate(data)
  end
end

