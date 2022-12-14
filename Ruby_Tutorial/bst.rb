require_relative 'node.rb'

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
				return
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
	end

	def find(value, current = @root)
		return false if !current
		return true if current.value == value
		return find(value, current.left) if value < current.value
		return find(value, current.right) if value > current.value
	end

	def largest(current = @root)
		while current do
			return current if current.right.nil?
			current = current.right
		end
	end

	def smallest(current = @root)
		while current do
			return current if current.left.nil?
			current = current.left
		end
	end
	
	def preorder(store = [], current = @root)
		return store if current.nil?
		store << current.value
		preorder(store, current.left)
		preorder(store, current.right)
	end

	def postorder(store = [], current = @root)
		return store if current.nil?
		postorder(store, current.left)
		postorder(store, current.right)
		store << current.value
	end

	def inorder(store = [], current = @root)
		return store if current.nil?
		inorder(store, current.left)
		store << current.value
		inorder(store, current.right)
	end

	def level_order(current = @root)
		result = []
		return result if current.nil?
		queue = [current]
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
		result
	end

	def delete(parent, value, current = @root)
		if current.nil?
			raise "ELement doess not exist"
			return
		elsif value < current.value
			delete(current, value, current.left)
		elsif value > current.value
			delete(current, value, current.right)
		else
		#case 1 if node has no child
			if current.left.nil? && current.right.nil?
				if value == @root.value
					@root = nil
				elsif value < parent.value
					parent.left = nil
				else
					parent.right = nil
				end
		#case 2 if the node has a single child
			elsif current.left.nil?
				if value == @root.value
					@root = @root.right
				elsif value < parent.value
					parent.left = current.right
				else
					parent.right = current.right
				end
			elsif current.right.nil?
				if value == @root.value
					@root = @root.left
				elsif value < parent.value
					parent.left = current.left
				else
					parent.right = current.left
				end
		#case 3 if node has 2 childs
			else
				@minval = self.smallest(current)
				temp = @minval.value
				delete(nil, temp)
				current.value = temp
			end
		end
	end

	def root_to_leaf(current = @root, path = [], path_collection = [])
		if @root.nil?
			raise "Tree is empty, cannot print path"
			return
		end
		return if current.nil?
		path << current.value
		if current.left.nil? && current.right.nil?
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


		CHOICE_DESCRIPTION = {}
		def self.add_choice_description(id,desc)
			CHOICE_DESCRIPTION[id] = desc
			id
		end

	module Choice
		HELP = BinarySearchTree.add_choice_description(0, "Type 0 to see all commands")
		INSERT =  BinarySearchTree.add_choice_description(1, "To insert a value")
		LARGEST =  BinarySearchTree.add_choice_description(2, "To find rhe largest element")
		SMALLEST =  BinarySearchTree.add_choice_description(3, "To find the smallest value")
		INORDER = BinarySearchTree.add_choice_description(4, "To print the Inorder")
		POSTORDER = BinarySearchTree.add_choice_description(5, "To print rhe Postorder")
		LEVEL_ORDER = BinarySearchTree.add_choice_description(6, "To print the level order")
		PREORDER = BinarySearchTree.add_choice_description(7, "To print the Postorder")
		SEARCH = BinarySearchTree.add_choice_description(8, "To search if an element is present")
		REMOVE = BinarySearchTree.add_choice_description(9, "To remove a specific element")
		PATH = BinarySearchTree.add_choice_description(10, "To print all pathn from root to leaf")
		QUIT = BinarySearchTree.add_choice_description(11, "To quit, all elements are stored in a file")
		LOAD = BinarySearchTree.add_choice_description(12, "To read input from a file and insert elements into a BST")
	end
end
