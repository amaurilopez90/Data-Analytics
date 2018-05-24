# ###################################################################################################
# => Name: Amauri Lopez
# => Description: Reads in csv files containing subscriber information to a magazine
# =>              Information includes a subscriber name and a subscriber ID number.
# =>              Stores this information into a subscriber object and creates a set 
# =>              of subscribers for that file. The program can then perform Union,
# =>              Intersection, and Cartesian Product functions on two sets. 

# => Filename: setsdata.rb
# => Description: This file is dedicated to the Set class and its functions. This file imports
# =>              the Setsarithmetic module and requires the csv, subscriber, and setsarithmetic files 

# => Last Data modified on: 9/26/2017
# ####################################################################################################
#import required files
require 'csv'
require_relative 'subscriber'
require_relative 'setsarithmetic'

class Set
	include Setsarithmetic #include the Setsarithmetic Module from setsarithmetic
	attr_accessor :set     #accessor to instance variable @set

	####################################################################################
	# => Definition: initialize()
	# => Description: Serves as the class constructor for the Set Class
	# => Parameters: 
	# =>        - new_set: input set that is going to be stored in the set object              
	####################################################################################
	def initialize(new_set)
		@set = new_set
	end 

	####################################################################################
	# => Definition: addElement()
	# => Description: This function is responsible for adding a subscriber object to a set
	# => Parameters: 
	# =>        - input_subscriber: input subscriber object that is going to be added
	# 
	# => Precondition: Assumes that the input subscriber is a valid subscriber object
	# => Postcondition: Edits the set in the set object to include the new subscriber              
	####################################################################################
	def addElement(input_subscriber) #add valid subscriber object to the set, check for duplicates
		if not (self.set.key?(input_subscriber.id_number)) #check to see if the input subscriber_id is already present in the set, if not, then add it 
			self.set[input_subscriber.id_number] = input_subscriber #add the subscriber at the location specified by its ID number
			puts "Successfully input the Subscriber"
		else
			puts "****Error in (#{input_subscriber.id_number}, #{input_subscriber.name}) - That subscriber ID is already taken****"
			puts "****=>(#{self.set[input_subscriber.id_number].id_number}, #{self.set[input_subscriber.id_number].name})****"
		end
	end

	####################################################################################
	# => Definition: self.inputFile()
	# => Description: This function reads a specified CSV file line-by-line, creates
	# =>              subscriber objects for each entry, and stores these objects into a 
	# =>              hash that is used to create the set object.
	# => Parameters: 
	# =>        - file_path: path to the file on the user's computer in which they would
	# =>                     to input as a set.
	# 
	# => Precondition: Assumes that input file is a valid CSV file that is not corrupt and
	# =>               can be read.
	#
	# => Postcondition: Returns a set object that contains a new Hash of all subscribers in 
	# =>                the CSV file while removing the duplicates.              
	####################################################################################
	def self.inputFile(file_path)
		new_set = {}
		begin
			CSV.foreach(file_path) do |row|                                 #go through csv file row by row
				subscriber_id = (row[0].gsub(/[^d\d]/, ''))                 #isolate the number ID in the string
				subscriber_name = row[0].split(subscriber_id)[1].strip      #isolate the name ID in the string

				if not (new_set.key?(subscriber_id)) #only put in a new subscriber object if that id isn't already present
					subscriber = Subscriber.new(subscriber_id, subscriber_name) #create new subscriber with row information
					new_set[subscriber_id] = subscriber
				end

			end 
			puts "Successfully imported"
			set = Set.new(new_set)
			return set                                                        #return the new set of subscribers
		rescue Exception => e
			puts "Something went wrong!" 
			puts e.message
			return 0
		end

	end

	####################################################################################
	# => Definition: isEmpty?()
	# => Description: This function simply returns true if the set does not contain any 
	# =>              susbcribers and returns false if it does contain subscribers
	# 
	# => Precondition: Assumes that the sender is a valid set object
	#
	# => Postcondition: Returns the IsEmpty state of the set             
	####################################################################################
	def isEmpty?         #just check if the set has any elements
		if self.set.length == 0
			return true
		else
			return false
		end 
	end

	####################################################################################
	# => Definition: display()
	# => Description: This function is responsible for displaying a set to the screen
	# => Precondition: Assumes that the sender is a valid set object.
	#
	# => Postcondition: Prints the set(sender) to the screen              
	####################################################################################
	def display()
		puts 'Set:'
		print "{"

		if not (self.set[self.set.keys.sample].kind_of?(Array)) #sets that are a result of union and intersection do not contain sub-arrays.
			self.set.each do |key, subscriber|                  #iterate through each subscriber in the set
				subscriber.get_info()                           #display the info of the subscriber
				if not subscriber.equal?(self.set.values.last)  #include a comma after each subscriber unless it is the last one in the set
					puts ","
				end
			end 
			puts "}"

		elsif (self.set[self.set.keys.sample].kind_of?(Array)) #sets that are a result of cartesian product. These are sets that contain sub-arrays
			self.set.each do |key, sub_set|                    #iterate through each sub-set of subscribers
				print "{"
				for subscriber in sub_set                      #iterate through each subscriber in the sub-sets
					subscriber.get_info()                      #display the info of the subscriber
					if not subscriber.equal?(sub_set.last)     #include a comma after each subscriber unless it is the last one in the set
						print ","
					end
				end	
				print "}"
				puts ","
			end 
		else
			puts "Did not recognize that kind of set"          #if the set is not a valid one, then let the user know that we do not recognize it
		end
	
	end

end