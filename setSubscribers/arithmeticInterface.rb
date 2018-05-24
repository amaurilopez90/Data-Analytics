####################################################################################################
# => Name: Amauri Lopez
# => Description: Reads in csv files containing subscriber information to a magazine
# =>              Information includes a subscriber name and a subscriber ID number.
# =>              Stores this information into a subscriber object and creates a set 
# =>              of subscribers for that file. The program can then perform Union,
# =>              Intersection, and Cartesian Product functions on two sets. 
#
# => Filename: arithmeticInterface.rb
# => Description: This Module extends the UserInterface class and holds it's functions relating to
# =>              the interface regarding the Union, Intersection, and Cartesian Product functionality
# 
# => Last Data modified on: 9/26/2017
#####################################################################################################
module ArithmeticInterface

    ####################################################################################
	# => Definition: getTheTwoSets()
	# => Description: This function prompts the user to select two sets from the list of
	# =>              available sets. If the sected set does not exist, or if the selected
	# =>              set is empty, then the user is prompted again.
	# => Parameters:
	# =>        - available_set_list: list of sets that are currently available to the user
	#
	# => Precondition: Assumes that each set that is available is a valid set object.
	# 
	# => Postcondition: Returns both set objects that the user has selected as an array
	####################################################################################
	def getTheTwoSets(available_set_list)
		if available_set_list.length < 2                 #if the list does not contain at least 2 sets, then display the sets and don't do anything
			puts "There arent enough sets to do that"
			availablesets()
		end
		i = 1
		available_set_list.each do |key, set|            #display each set that can be selected
			puts "#{i}.'#{key}'"
			i += 1
		end
		puts "Choose the first set (ex. '15.csv')"
		puts "or 'exit' to go back to menu"
		print "Type the set name: "
		selected_set1 = gets.chomp()
		if selected_set1 == "exit"
			mainmenu()                                   #exit to main menu if they enter "exit"
		end
		if not (available_set_list.key?(selected_set1))
			puts "That set does not exist in the list"   #if the input from the user does not match a set in the available list, then prompt the user again
			getTheTwoSets(available_set_list)
		else
			if available_set_list[selected_set1].isEmpty?() #check if that set is empty or not. If it is then tell the user that they cannot use it.
				puts "That set cannot be used because it is empty"
				getTheTwoSets()
			end
			set1 = available_set_list[selected_set1]     #store the first set
		end
		puts "Choose the second set (ex. 'testset1.csv')"
		puts "or 'exit' to go back to menu"
		print "Type the set name: "
		selected_set2 = gets.chomp()
		if selected_set2 == "exit"
			mainmenu()
		end
		if not (available_set_list.key?(selected_set2))
			puts "That set does not exist in the list"
			getTheTwoSets(available_set_list)
		else
			if available_set_list[selected_set2].isEmpty?()
				puts "That set cannot be used because it is empty"
				getTheTwoSets()
			end
			set2 = available_set_list[selected_set2]      #store the second set
		end

		return set1, set2
	end

    ####################################################################################
	# => Definition: doUnion()
	# => Description: This function calls the getTheTwoSets function to retreive the two
	# =>              selected sets for the Union. This function then calls the union method
	# =>              on the two sets as well as the display method on the result to print
	# =>              out the unified set.
	# => Parameters:
	# =>        - available_set_list: list of sets that are currently available to the user
	#
	# => Precondition: Assumes that each set that is available is a valid set object.
	# 
	# => Postcondition: Creates a set that holds the result of the Union between two
	# =>                selected sets and displays that set.
	####################################################################################
	def doUnion(available_set_list)
		selected_sets = getTheTwoSets(available_set_list) #get the two sets from the user

		#call the Union
		set1UNIONset2 = selected_sets[0].union(selected_sets[1]) #get the union between two sets
		set1UNIONset2.display()                                  #display the set
		mainmenu()                                               #go back to main menu
	end

	####################################################################################
	# => Definition: doIntersection()
	# => Description: This function calls the getTheTwoSets function to retreive the two
	# =>              selected sets for the Intersection. This function then calls the 
	# =>              Intersection method on the two sets as well as the display method
	# =>              on the result to print out the set.
	# => Parameters:
	# =>        - available_set_list: list of sets that are currently available to the user
	#
	# => Precondition: Assumes that each set that is available is a valid set object.
	# 
	# => Postcondition: Creates a set that holds the result of the Intersection between two
	# =>                selected sets and displays that set.
	####################################################################################
	def doIntersection(available_set_list)
		selected_sets = getTheTwoSets(available_set_list) #get the two sets from the user

		#call the Intersection
		set1INTERSECTIONset2 = selected_sets[0].intersection(selected_sets[1])
		set1INTERSECTIONset2.display()
		mainmenu()
	end

	####################################################################################
	# => Definition: doProduct()
	# => Description: This function calls the getTheTwoSets function to retreive the two
	# =>              selected sets for the Cartesian Product. This function then calls the 
	# =>              Product method on the two sets as well as the display method
	# =>              on the result to print out the set.
	# => Parameters:
	# =>        - available_set_list: list of sets that are currently available to the user
	#
	# => Precondition: Assumes that each set that is available is a valid set object.
	# 
	# => Postcondition: Creates a set that holds the result of the Cartesian Product between
	# =>                two selected sets and displays that set.
	####################################################################################
	def doProduct(available_set_list)
		selected_sets = getTheTwoSets(available_set_list) #get the two sets from the user

		#call the Cartesian Product
		set1PRODUCTset2 = selected_sets[0].product(selected_sets[1])
		set1PRODUCTset2.display()
		mainmenu()
	end

	####################################################################################
	# => Definition: addNewSub()
	# => Description: This function handles the case in which the user wants to add a new
	# =>              subscriber to an existing set. This creates a new subscriber object
	# =>              and calls the addElement function.
	# => Parameters:
	# =>        - available_set_list: list of sets that are currently available to the user
	#
	# => Precondition: Assumes that each set that is available is a valid set object.
	# 
	# => Postcondition: Edits an existing set to include a new subscriber information.
	####################################################################################
	def addNewSub(available_set_list)
		if available_set_list.length == 0
			puts "There arent any sets to add subscribers to" #if there is no available set to edit, then inform the user and go back to main menu
			availablesets()
		else 
			i = 1
			available_set_list.each do |key, set|             #display the available sets
			puts "#{i}.'#{key}'"
			i += 1
			end
			puts "Choose a set to add from available sets (ex. '15.csv')"
			puts "or type 'exit' to go to menu"
			print "Type set name: "
			response = gets.chomp()
			if response == "exit"                             #exit to main menu if they enter "exit"
				mainmenu()
			end
			if not (available_set_list.key?(response))
				puts "That set does not exist in the list"     #prompt the user again if they enter an invalid response
				addNewSub(available_set_list)
			else
				set = available_set_list[response]             #get the selected set
			end
			puts "Enter the Susbcriber info: "
			print "Enter Subscriber ID, it should be an Integer (ex '123456789'): " #get the subscriber ID
			sub_ID = gets.chomp()

			if sub_ID == "exit"
				mainmenu()
			end
			#check if input was an integer
			begin 
				int = Integer(sub_ID) #this will fail if it is not a valid integer
			rescue 
				puts "Sub_ID is not a valid integer." #if the ID is not a valid integer then prompt the user again
				addNewSub()
			end
			puts "Enter the Susbcriber info: "
			print "Enter Subscriber Name, prefered to be in CAPS (ex. AMAURI LOPEZ): " #get the subscriber name
			sub_name = gets.chomp()
			if sub_name == "exit"
				mainmenu()
			end
			set.addElement(Subscriber.new(sub_ID, sub_name))    #make a new subscriber object with that ID and name and add the element to the set
			mainmenu()
		end
	end
end