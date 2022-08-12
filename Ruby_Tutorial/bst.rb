require_relative '../modules/choice_constant.rb'

class BinarySearchTree
	attr_accessor :root, :data
		
	def initialize
		@root = nil
	end

	def insert(value)
		new_node = Node.new(value)
		if !root
			@root = new_node
			return
		end
		current = @root
		while current do
			if current.value == value
				puts "This value already exists"
				return nil
			end
			if value > current.value
				if current.right
					current = current.right
				else
					current.right = new_node
					return
				end
			else
				if current.left
					current = current.left
				else
					current.left = new_node
					return
				end
			end
		end
		return self
	end

	def find(value, current = @root)
		return false if !current
		return true if current.value == value
		return find(value, current.left) if value < current.value
		return find(value, current.right) if value > current.value
	end

	def largest(current = @root)
		while current do
			return current if current.right == nil
			current = current.right
		end
	end

	def smallest(current = @root)
		while current do
			return current if current.left == nil
			current = current.left
		end
	end
	
	def preorder(current = @root)
		return if current.nil?
		puts current.value
		preorder(current.left)
		preorder(current.right)
	end

	def postorder(current = @root)
		return if current.nil?
		postorder(current.left)
		postorder(current.right)
		puts current.value
	end

	def inorder(current = @root)
		return if current.nil?
		inorder(current.left)
		puts current.value
		inorder(current.right)
	end

	def level_order(current = @root)
		result = []
		return result if current.nil?
		queue = []
		queue << current
		until queue.empty?
			level_size = queue.length
			level = []
			level_size.times do
				node = queue.shift
				level << node.value
				queue << node.left unless node.left.nil?
				queue << node.right unless node.right.nil?
			end
			result << level
		end
		print result
		puts ''
	end

	def data
		@data ||= []
	end

	def store_elements(current = @root)
		return if current.nil?
		data << current.value
		preorder(current.left)
		preorder(current.right)
	end

	def delete(parent, value, current = @root)
		if @root.nil?
			return root
		elsif value < current.value
			delete(current, value, current.left)
		elsif value > current.value
			delete(current, value, current.right)
		else
		#case 1 if node has no child
			if current.left.nil? && current.right.nil?
				if value == parent.value
					current = nil
				elsif value < parent.value
					parent.left = nil
				else
					parent.right = nil
				end
		#case 2 if the node has a single child
			elsif current.left.nil?
				if value < parent.value
					parent.left = current.right
				else
					parent.right = current.right
				end
			elsif current.right.nil?
				if value < parent.value
					parent.left = current.left
				else
					parent.right = current.left
				end
		#case 3 if node has 2 childs
			else
				@minval = self.smallest(current)
				temp = @minval.value
				delete(temp, nil)
				current.value = temp
			end
		end
	end

	def root_to_leaf(current = @root, path = [], path_collection = [])
		return if current.nil?
		path << current.value
		if current.left == nil && current.right == nil
			path_collection << path.dup
			print path
			puts ''
			return
		end
		if @root.left
		 root_to_leaf(current.left, path, path_collection)
		 path.pop
		end
		root_to_leaf(current.right, path, path_collection)
	end
end

class Node
	attr_accessor :left, :right, :value

	def initialize(value, left = nil, right = nil)
		@left = left
		@right = right
		@value = value
	end
end

bst = BinarySearchTree.new()

puts "Enter your choice -- Type 0 to see all commands"
while (choice = gets.to_i)
	if choice == ChoiceConstants::HELP
		puts "Commands          Description"
		puts "1                 -- to add elements to bst"
		puts "2                 -- to print the largest element"
		puts "3                 -- to print the smallest element"
		puts "4                 -- to print the Inorder"
		puts "5                 -- to print the Postorder"
		puts "6                 -- to print the Levelorder"
		puts "7                 -- to print the preorder"
		puts "8                 -- to search if a element is present"
		puts "9                 -- to remove an element"
		puts "10                -- to print all path from root to leaf"
		puts "11                -- to quit, all elements are stored in a file"
		puts "12                -- to read input file and insert element in bst"
	elsif choice == ChoiceConstants::INSERT
		puts "enter a value"
		value = gets.to_i
		bst.insert(value)
	elsif choice == ChoiceConstants::PREORDER
		bst.preorder
	elsif choice == ChoiceConstants::POSTORDER
		bst.postorder
	elsif choice == ChoiceConstants::INORDER
		bst.inorder
	elsif choice == ChoiceConstants::LEVEL_ORDER 
		bst.level_order
	elsif choice == ChoiceConstants::LARGEST 
		max = bst.largest
		puts max.value
	elsif choice == ChoiceConstants::SMALLEST 
		min = bst.smallest
		puts min.value
	elsif choice == ChoiceConstants::SEARCH 
		puts "Enter element to check"
		element = gets.to_i
		bool = bst.find(element)
		if bool
			puts "Element exists"
		else
			puts "Element does not Exist"
		end
	elsif choice == ChoiceConstants::REMOVE
		puts "Enter element you want to remove"
		element = gets.to_i
		bst.delete(nil, element)
	elsif choice == ChoiceConstants::PATH
		bst.root_to_leaf
	elsif choice == ChoiceConstants::QUIT
		bst.store_elements
		File.write("Elements.txt", "PreOrder")
		File.write("Elements.txt", "#{bst.data}")
		break
	elsif choice == ChoiceConstants::LOAD
		puts "Enter the name of file you want take input from"
		filename = gets.chomp.to_s
		File.foreach(filename){ |input| bst.insert(input.to_i) }	
	else 
		puts "Invalid choice, Please try again"
	#rescue puts "Error! Binary Search Tree is empty"
	end
	puts "Enter new choice or type 11 to exit"
end
