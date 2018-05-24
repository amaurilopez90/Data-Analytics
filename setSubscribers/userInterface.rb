####################################################################################################
# => Name: Amauri Lopez
# => Description: Reads in csv files containing subscriber information to a magazine
# =>              Information includes a subscriber name and a subscriber ID number.
# =>              Stores this information into a subscriber object and creates a set 
# =>              of subscribers for that file. The program can then perform Union,
# =>              Intersection, and Cartesian Product functions on two sets. 
# => 
# => Filename: userInterface.rb
# => Description: This file is dedicated to the UserInterface class and its functions
# =>              This file imports the ArithmeticInterface module which extends the UserInterface class
# =>              and requires the setsdata, subscriber, setsarithmetic, and arithmeticInterface files 
#  
# => Last Data modified on: 9/25/2017
#####################################################################################################
#import required files
require_relative 'setsdata'
require_relative 'subscriber'
require_relative 'setsarithmetic'
require_relative 'arithmeticInterface'

class UserInterface
	attr_accessor :available_set_list #accessors to instance variable @available_set_list
	include ArithmeticInterface       #include the ArithmeticInterface module in 'arithmeticInterface'

	####################################################################################
	# => Definition: initialize()
	# => Description: Serves as the class constructor for the UserInerface Class
	# =>              Creates a new Hash to store the list of available sets
	####################################################################################
	def initialize()
		@available_set_list = Hash.new
	end

	####################################################################################
	# => Definition: mainmenu()
	# => Description: Prints out the main menu for the user interface which displays
	# =>              the available options the user can choose.
	# =>              It asks the user for the input of their selection, and calls a 
	# =>              corresponding function to handle that action. If the user inputs
	# =>              an incorrect response, then the main menu is displayed again
	# 
	# => Postcondition: The corresponding function to handle the user's action is called
	####################################################################################
	def mainmenu()
		#print out the user menu
		puts "---------------Main Menu---------------"
		puts " 1.Show ready sets    2.Import set"
		puts " 3.Add subscriber     4.Display a set"
		puts " 5.Do Union           6.Do Intersection"
		puts "       7.Do Cartesian Product"
		puts "---------------------------------------"	
		puts "To select: Type corresponding number to Option"
		puts "(ex. type '1' to show the available sets)"
		puts "Enter 'exit' to quit the program"
		print"Select: "

		response = gets.chomp()                     #get the input from the user
		case response                               #run the corresponding functions
			when "1"
				availablesets()                     #list available sets function
			when "2"
				import()                            #import files function
			when "3"
				addNewSub(available_set_list)       #add new subscriber function
			when "4"
				showSet()                           #display the set function
			when "5"
				doUnion(available_set_list)         #handle the case of Union
			when "6"
				doIntersection(available_set_list)  #handle the case of Intersection
			when "7"
				doProduct(available_set_list)       #handle the case of Cartesian Product
			when "exit"
				return
			else                                    #handle the case of incorrect input
				"'#{response}'' is not a valid input, please select again"
				mainmenu()                          #bring up the main menu again
		end

	end


	####################################################################################
	# => Definition: availablesets()
	# => Description: Prints out the list of all of the available sets that the user
	# =>              has inputted. If there are no avaiable sets, then this menu displays
	# =>              '*There are no available sets yet*'
	# 
	# => Postcondition: The list of available sets is displayed and the main menu is 
	# =>                displayed again
	####################################################################################
	def availablesets()
		puts "-----------------Sets-----------------"
		if self.available_set_list.size == 0            #If there aren't any available setrs
			puts "   *There are no available sets yet*"
		else
			i = 1
			available_set_list.each do |key, set|       #Iterate through the list and display the name of each set
				puts "#{i}.'#{key}'"
				i += 1
			end
		end
		puts "--------------------------------------"
		mainmenu()                                      #bring up the main menu
	end

	####################################################################################
	# => Definition: import()
	# => Description: Handles the case in which the user wants to import a set from an 
	# =>              external file. Prompts the user for the name of the file and runs
	# =>              the inputFile method to that filepath to create that set.
	#
	# => Precondition: Assumes that the file being imported is a working csv file that 
	# =>               contains the user information in the first cell of each row.
	# 
	# => Postcondition: Creates a set of subscribers from the imported file and stores
	# =>                this set in the list of available sets for the user.
	####################################################################################
	def import()
		print "Enter name of file to import (ex. '15.csv'): "
		filepath = gets.chomp()
		set = Set.inputFile("files/#{filepath}")   #read the csv file line-by-line and creates a new set for the subscribers
		if set == 0
			puts "Maybe you forgot the .csv, or it just doesn't exist"
		else
			available_set_list[filepath] = set	   #add the set read from the csv to the list of available sets
		end
		mainmenu()                                 #bring up the main menu again
	end

	####################################################################################
	# => Definition: showSet()
	# => Description: Handles the case in which the user wants to display a set from the 
	# =>              list of available sets. If the user enters an invalid response then
	# =>              the list of available sets is printed again and they are prompted
	# =>              If the user enters "exit" then the main menu is printed again
	#
	# => Precondition: Assumes that each set that is available is a valid set object.
	# 
	# => Postcondition: Calls the display method for the selected set which displays the 
	# =>                Set to the screen
	####################################################################################
	def showSet()
		puts "Choose a set to show (ex. '15.csv')"
		puts "or 'exit' to go back to the menu"
		i = 1
		available_set_list.each do |key, set|          #displays list of available sets
			puts "#{i}.'#{key}'"
			i += 1
		end
		print "Type the set name: "
		selected_set = gets.chomp()
		if selected_set == "exit"
			mainmenu()                                 #if they type "exit" then go back to the main menu
		end
		if not (available_set_list.key?(selected_set)) #if the set does not exist in the list then call this function again
			puts "That set does not exist in the list"
			showSet()
		else
			available_set_list[selected_set].display() #display the selected set
		end 
		mainmenu()
	end

end