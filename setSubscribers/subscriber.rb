####################################################################################################
# => Name: Amauri Lopez
# => Description: Reads in csv files containing subscriber information to a magazine
# =>              Information includes a subscriber name and a subscriber ID number.
# =>              Stores this information into a subscriber object and creates a set 
# =>              of subscribers for that file. The program can then perform Union,
# =>              Intersection, and Cartesian Product functions on two sets. 
#
# => Filename: subscriber.rb
# => Description: This file is dedicated to the Subscriber class and its functions
# =>              It simply holds the subscriber information
#
# => Last Data modified on: 9/25/2017
#####################################################################################################
class Subscriber
	attr_accessor :name, :id_number #accessors to instance variables @name and @id_number

	###########################################################################
	# => Definition: initialize
	# => Description: Serves as the class constructor for the Subscriber Class
	# => Parameters: 
	# =>       - id_number => Subscriber's account number
	# =>       - name => Subscriber's Name
	###########################################################################
	def initialize(id_number, name) #class constructor?

		@name = name
		@id_number = id_number
	end

	###########################################################################
	# => Definition: get_info
	# => Description: Prints out the information about the subscriber
	# => Precondition: Sender (Subscriber) is a valid subscriber object that has
	# =>               the attributes id_number and name
	#
	# => Postcondition: The subscriber ID and Name are printed to the screen
	###########################################################################
	def get_info 
		print "(#{@id_number}, #{@name})"
	end

end 
