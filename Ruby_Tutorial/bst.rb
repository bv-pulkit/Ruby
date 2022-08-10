class BinarySearchTree
	attr_accessor :root, :data
		
	def initialize value
		@root = nil
	end

	def insert(value)
		new_node = Node.new(value)

		if !root
			@root = new_node
			return self
		end

		current = @root
		while current do
			return nil if current.value == value
			if (value > current.value)
				if !current.right
					current.right = new_node
					break
				else
					current = current.right
				end
			else
				if !current.left
					current.left = new_node
					break
				else
					current = current.left
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
		return if (current == nil)
		puts current.value.to_s
		preorder(current.left)
		preorder(current.right)
	end

	def postorder(current = @root)
		return if (current == nil)
		postorder(current.left)
		postorder(current.right)
		puts current.value.to_s
	end

	def inorder(current = @root)
		return if (current == nil)
		inorder(current.left)
		puts current.value.to_s
		inorder(current.right)
	end

	def level_order(current = @root)
		return if (current == nil)
		puts current.value.to_s
		level_order(current.left)
		level_order(current.right)
	end

	def data
		@data ||= []
	end

	def store_elements(current = @root)
		return if (current == nil)
		data << current.value.to_i
		store_elements(current.left)
		store_elements(current.right)
	end

	def delete(current = @root, value, parent)
		if (root ==  nil)
			return root
		elsif (value < current.value)
			delete(current.left, value, current)
		elsif (value > current.value)
			delete(current.right, value, current)
		else
		#case 1 if node has no child
			if current.left == nil && current.right == nil
				if value == parent.value
					current = nil
				elsif (value < parent.value)
					parent.left = nil
				else
					parent.right = nil
				end
		#case 2 if the node has a single child
			elsif current.left == nil
				if (value < parent.value)
					parent.left = current.right
				else
					parent.right = current.right
				end
			elsif current.right == nil
				if (value < parent.value)
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
			puts "path is"
			return
		end
		root_to_leaf(current.left, path, path_collection)
		path.pop
		root_to_leaf(current.right, path , path_collection)
	end

end

class Node
	attr_accessor :left, :right, :value

	def initialize(left = nil, right = nil, value)
		@left = left
		@right = right
		@value = value
	end
end

bst = BinarySearchTree.new(10)

puts "Enter your choice -- Type help to see all commands"
while (choice = gets.chomp)
	if choice == 'help'
		puts "Commands          Description"
		puts "insert            -- to add elements to bst"
		puts "largest           -- to print the largest element"
		puts "smallest          -- to print the smallest element"
		puts "inorder           -- to print the Inorder"
		puts "postorder         -- to print the Postorder"
		puts "level_order       -- to print the Levelorder"
		puts "preorder          -- to print the preorder"
		puts "search            -- to search if a element is present"
		puts "remove            -- to remove an element"
		puts "path              -- to print all path from root to leaf"
		puts "quit              -- to quit, all elements are stored in a file"
		puts "load              -- to read input file and insert element in bst"
	elsif choice == 'insert'
		puts "enter a value"
		value = gets.chomp.to_i
		bst.insert(value)
	elsif choice == 'preorder'
		bst.preorder
	elsif choice == 'postorder'
		bst.postorder
	elsif choice == 'inorder'
		bst.inorder
	elsif choice == 'level_order'
		bst.level_order
	elsif choice == 'largest'
		max = bst.largest
		puts max.value
	elsif choice == 'smallest'
		min bst.smallest
		puts min.value
	elsif choice == 'search'
		puts "Enter element to check"
		element = gets.chomp.to_i
		bool = bst.find(element)
		if bool == true
			puts "Element exists"
		else
			puts "Element does not Exist"
		end
	elsif choice == 'remove'
		puts "Enter element you want to remove"
		element = gets.chomp.to_i
		bst.delete(element, nil)
	elsif choice == 'path'
		bst.root_to_leaf
	elsif choice == 'quit'
		bst.store_elements
		File.write("Elements.txt", "#{bst.data}")
		break
	elsif choice == 'load'
		puts "Enter the name of file you want take input from"
		filename = gets.chomp.to_s
		File.foreach(filename){|input|
		bst.insert(input.to_i)}	
	else 
		puts "Invalid command, Please try again"
	end
	puts "Enter new choice or type quit to exit"
end
