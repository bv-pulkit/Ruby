require_relative "./linked_list_node.rb"

class LinkedList
	attr_accessor :head

	def initialize
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
		unless target_node
			puts "Target does not exist"
			return
		end
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
		return node if node.value == value
		while (node = node.next)
			return node if node.value == value
		end
		return false
	end

	def delete(value)
		node = @head
		if node.value == value
			@head = @head.next
			return
		end
		while(node.next)
			next_node = node.next
			if next_node.value == value
				node.next = next_node.next
				return
			end
			node = node.next
		end
		puts "value does not exist in linked list"
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

	CHOICE_DESCRIPTION = {}
	def self.add_choice_description(id,desc)
		CHOICE_DESCRIPTION[id] = desc
		id
	end

	module Choice
		HELP = LinkedList.add_choice_description(0, "Type 0 to see all commands")
		INSERT =  LinkedList.add_choice_description(1, "To insert a value")
		INSERT_AFTER =  LinkedList.add_choice_description(2, "To insert a value after a specified target")
		SEARCH = LinkedList.add_choice_description(3, "To search if an element is present")
		REMOVE = LinkedList.add_choice_description(4, "To remove a specific element")
		PRINT = LinkedList.add_choice_description(5, "To print all the elements of Linked List")
		REVERSE = LinkedList.add_choice_description(6, "To reverse the Linked List")
		QUIT = LinkedList.add_choice_description(7, "To quit")
	end
end
