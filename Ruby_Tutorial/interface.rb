require_relative "./bst.rb"

bst = BinarySearchTree.new()

puts "Enter your choice -- Type 0 to see all commands"
while (choice = gets.to_i)
	begin
	if choice == BinarySearchTree::Choice::HELP
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
	elsif choice == BinarySearchTree::Choice::INSERT
		puts "enter a value"
		value = gets.to_i
		bst.insert(value)
	elsif choice == BinarySearchTree::Choice::PREORDER
		ans = bst.preorder(store = [])
		puts ans
	elsif choice == BinarySearchTree::Choice::POSTORDER
		ans = bst.postorder(store = [])
		puts ans
	elsif choice == BinarySearchTree::Choice::INORDER
		ans = bst.inorder(store = [])
		puts ans
	elsif choice == BinarySearchTree::Choice::LEVEL_ORDER
		ans = bst.level_order
		puts ans
	elsif choice == BinarySearchTree::Choice::LARGEST
		max = bst.largest
		puts max.value
	elsif choice == BinarySearchTree::Choice::SMALLEST
		min = bst.smallest
		puts min.value
	elsif choice == BinarySearchTree::Choice::SEARCH
		puts "Enter element to check"
		element = gets.to_i
		bool = bst.find(element)
		if bool
			puts "Element exists"
		else
			puts "Element does not Exist"
		end
	elsif choice == BinarySearchTree::Choice::REMOVE
		puts "Enter element you want to remove"
		element = gets.to_i
		bst.delete(nil, element)
	elsif choice == BinarySearchTree::Choice::PATH
		bst.root_to_leaf
	elsif choice == BinarySearchTree::Choice::QUIT
		File.write("Elements.txt", "PreOrder :")
		File.write("Elements.txt", "#{bst.preorder(store = [])}", mode:'a')
		File.write("Elements.txt", "\nPostOrder :", mode:'a')
		File.write("Elements.txt", "#{bst.postorder(store = [])}", mode:'a')
		File.write("Elements.txt", "\nInOrder :", mode:'a')
		File.write("Elements.txt", "#{bst.inorder(store = [])}", mode:'a')
		File.write("Elements.txt", "\nLevelOrder :", mode:'a')
		File.write("Elements.txt", "#{bst.level_order}", mode:'a')
	break
	elsif choice == BinarySearchTree::Choice::LOAD
		puts "Enter the name of file you want take input from"
		filename = gets.chomp.to_s
		File.foreach(filename){ |input| bst.insert(input.to_i) }
	else
		puts "Invalid choice, Please try again"
	end
		puts "Enter new choice or type 11 to exit"
	rescue
		puts "Binary Search Tree is empty"
	end
end
