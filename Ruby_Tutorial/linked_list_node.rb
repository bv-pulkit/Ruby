require_relative 'node.rb'

class LinkedListNode < Node
	attr_accessor :value, :next

	def initialize(value)
		@value = value
		@next = nil
	end
end
