require_relative "./bst.rb"
require_relative "./linked_list.rb"

bst = BinarySearchTree.new()
ll = LinkedList.new()

puts "Select your Data Structure. Type '1' for BST, '2' for LinkedList"
ds_type = gets.to_i
if ds_type == 1
	puts "Enter your choice -- Type 0 to see all commands"
	while (choice = gets.to_i)
		begin
			if BinarySearchTree::Choice::HELP == choice
				puts "Commands -- Description"
				BinarySearchTree::CHOICE_DESCRIPTION.each do |choice, desc|
					puts "#{choice} -- #{desc}"
				end
			elsif BinarySearchTree::Choice::INSERT == choice
				puts "enter a value"
				value = gets.to_i
				bst.insert(value)
			elsif BinarySearchTree::Choice::PREORDER == choice
				ans = bst.preorder
				raise "BST is empty" if !ans
				puts ans
			elsif BinarySearchTree::Choice::POSTORDER == choice
				ans = bst.postorder
				raise "BST is empty" if !ans
				puts ans
			elsif BinarySearchTree::Choice::INORDER == choice
				ans = bst.inorder
				raise "BST is empty" if !ans
				puts ans
			elsif BinarySearchTree::Choice::LEVEL_ORDER == choice
				ans = bst.level_order
				raise "BST is empty" if !ans
				ans.each do |level|
					print level
					puts ''
				end
			elsif BinarySearchTree::Choice::LARGEST == choice
				max = bst.largest
				raise "Cannot find largest element as the tree is empty" if !max
				puts max.value
			elsif BinarySearchTree::Choice::SMALLEST == choice
				min = bst.smallest
				raise "Cannot find smallest element as the tree is empty" if !min
				puts min.value
			elsif BinarySearchTree::Choice::SEARCH == choice
				puts "Enter element to check"
				element = gets.to_i
				raise "Invalid Input" if !element
				bool = bst.find(element)
				a = bool ? "Element exists" : "Element does not Exist"
				puts a
			elsif BinarySearchTree::Choice::REMOVE == choice
				puts "Enter element you want to remove"
				element = gets.to_i
				bst.delete(nil, element)
			elsif BinarySearchTree::Choice::PATH == choice
				bst.root_to_leaf
			elsif BinarySearchTree::Choice::QUIT == choice
				File.write("Elements.txt", "PreOrder :")
				File.write("Elements.txt", "#{bst.preorder}", mode:'a')
				File.write("Elements.txt", "\nPostOrder :", mode:'a')
				File.write("Elements.txt", "#{bst.postorder}", mode:'a')
				File.write("Elements.txt", "\nInOrder :", mode:'a')
				File.write("Elements.txt", "#{bst.inorder}", mode:'a')
				File.write("Elements.txt", "\nLevelOrder :", mode:'a')
				File.write("Elements.txt", "#{bst.level_order}", mode:'a')
				break
			elsif BinarySearchTree::Choice::LOAD == choice
				puts "Enter the name of file you want take input from"
				filename = gets.chomp.to_s
				raise "Failed to load as the input file name does not exist" if File.exists?(filename)
				File.foreach(filename){ |input| bst.insert(input.to_i) }
			else
				puts "Invalid choice, Please try again"
			end
			puts "Enter new choice or type #{BinarySearchTree::Choice::QUIT} to exit"
		rescue => e 
			puts e.message
			puts "Enter new choice or type  #{BinarySearchTree::Choice::QUIT} to exit"
		end
	end

elsif ds_type == 2
	puts "Enter your choice -- Type 0 to see all commands"
	while (choice = gets.to_i)
		begin
			if LinkedList::Choice::HELP == choice
				puts "Commands -- Description"
				LinkedList::CHOICE_DESCRIPTION.each do |choice,desc|
					puts "#{choice} -- #{desc}"
				end
			elsif LinkedList::Choice::INSERT == choice
				puts "enter a value"
				value = gets.to_i
				ll.insert(value)
			elsif LinkedList::Choice::INSERT_AFTER == choice
				puts "Enter the target value you want to insert after"
				target = gets.to_i
				puts "Enter the value to want to insert"
				value = gets.to_i
				ll.insert_after(target, value)
			elsif LinkedList::Choice::SEARCH == choice
				puts "Enter element to check"
				element = gets.to_i
				raise "Invalid Input" if !element
				bool = ll.find(element)
				a = bool ? "Element exists" : "Element does not Exist"
				puts a
			elsif LinkedList::Choice::REMOVE == choice
				puts "Enter element you want to remove"
				element = gets.to_i
				ll.delete(element)
			elsif LinkedList::Choice::PRINT == choice
				ll.print
			elsif LinkedList::Choice::REVERSE == choice
				ll.reverse
			elsif LinkedList::Choice::QUIT == choice
				break
			else
				puts "Invalid choice, Please try again"
			end
			puts "Enter new choice or type #{LinkedList::Choice::QUIT} to exit"
		rescue
			puts "Enter new choice or type  #{LinkedList::Choice::QUIT} to exit"
		end
	end
else
	puts "Oops!! Wrong Choice"
end
