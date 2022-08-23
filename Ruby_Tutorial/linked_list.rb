require_relative "./linked_list_node.rb"

class LinkedList
	attr_accessor :head

	def initialize
		@head = nil
	end

	def find_tail
		node = @head
		while (node)
			return node if !node.next
			node = node.next
		end
	end

	def insert(value)
		if @head
			find_tail.next = LinkedListNode.new(value)
		else
			@head = LinkedListNode.new(value)
		end
	end

  def find(value)
    if @head.nil?
      return false
    end
		node = @head
				while (node)
					return node if node.value == value
					node = node.next
				end
				return false
			end

	def insert_after(target, value)
		target_node = find(target)
		unless target_node
			puts "Target does not exist"
			return
		end
		prev_node_next = target_node.next
		target_node.next = LinkedListNode.new(value)
		target_node.next.next = prev_node_next
	end

	def delete(value)
		if @head.nil?
			puts "Value does not exist in Linked List"
			return
		end
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
		puts "value does not exist in Linked List"
	end

	def print
		if @head.nil?
			puts "Linked List is Empty"
			return
		end
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
