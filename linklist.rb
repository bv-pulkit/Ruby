class LinkedList
	attr_accessor :head

	def initialize value
		@head = nil
	end

	def insert(value)
		if @head
			find_tail.next = Node.new(value)
		else
			@head = Node.new(value)
		end
	end

	def insert_after(target, value)
		target_node = find(target)
		return unless target_node
		old_next = target_node.next
		target_node.next = Node.new(value)
		target_node.next.next = old_next
	end

	def find_tail
		node = @head
		return node if !node.next
		while (node = node.next)
			return node if !node.next
		end
	end

	def find(value)
		node = @head
		return node if value == node.value
		return false if !node.next

		while (node = node.next)
			return node if node.value == value
		end
	end

	def delete(value)
		node = @head
		if node.value == value
			@head = @head.next
			return
		end

		while(node)
			next_node = node.next
			if next_node.value == value
				node.next = next_node.next
				return
			end
			node = node.next
		end
	end

	def print
		node = @head
		puts node.value
		puts node.value while node = node.next
	end

	def reverse(current = @head, prev_node = nil, next_node = nil)
			while current != nil
				next_node = current.next
				current.next = prev_node
				prev_node = current
				current = next_node
			end
			@head = prev_node
	end

end

class Node
	attr_accessor :value, :next

	def initialize(value)
		@value = value
		@next = nil
	end
end
