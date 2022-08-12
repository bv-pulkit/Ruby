class Node
  attr_accessor :left, :right, :value

	def initialize(value, left = nil, right = nil)
			@left = left
	    @right = right
			@value = value
  end
end
