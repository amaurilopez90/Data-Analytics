####################################################################################################
# => Name: Amauri Lopez
# => Description: Reads in csv files containing subscriber information to a magazine
# =>              Information includes a subscriber name and a subscriber ID number.
# =>              Stores this information into a subscriber object and creates a set 
# =>              of subscribers for that file. The program can then perform Union,
# =>              Intersection, and Cartesian Product functions on two sets. 
#
# => Filename: setsarithmetic.rb
# => Description: This Module extends the Set class and contains the Union, Intersection, and Cartesian
# =>              Product functions.  
#
# => Last Data modified on: 9/25/2017
#####################################################################################################
module Setsarithmetic

	####################################################################################
	# => Definition: union()
	# => Description: This function performs the Union of two sets and stores the result
	# =>              in a third set.
	# => Parameters: 
	# =>        - target_object: set object that the user wishes to perform a union with its sender
	# 
	# => Precondition: Assumes that both the sender and target_object are both valid set objects
	#
	# => Postcondition: Returns a third set that is the result of the Union between the sender object
	# =>                and the target_object               
	####################################################################################
	def union(target_object)
		unified_set = self.set.clone() #make a copy of the first set
		target_object.set.each do |key, subscriber| #iterate through each subscriber in the target set
			if not (unified_set.key?(key)) #if the first set does not already contain the ID_number in the second set, include it
				unified_set[key] = subscriber 
			end
		end
		
		#Store the unified set into Set object
		output_set = Set.new(unified_set) 
		return output_set #return the resultant set
	end

	####################################################################################
	# => Definition: intersection()
	# => Description: This function performs the Intersection of two sets and stores the result
	# =>              in a third set.
	# => Parameters: 
	# =>        - target_object: set object that the user wishes to perform a union with its sender
	# 
	# => Precondition: Assumes that both the sender and target_object are both valid set objects
	#
	# => Postcondition: Returns a third set that is the result of the Intersection between the sender object
	# =>                and the target_object               
	####################################################################################
	def intersection(target_object)
		#make a clone of the smaller set
		if self.set.length > target_object.set.length
			set1 = target_object.set.clone()
			set2 = self.set.clone()
		else
			set1 = self.set.clone()
			set2 = target_object.set.clone()
		end
		intersected_set = {} #create an empty hash that will be used to store all common subscribers between the two sets

		#find the common ID numbers
		set1.each do |id, subscriber| #iterate through the smaller set
			if (set2.key?(id)) #if the key of the first is also present in the second, then add that key+value to a third set
				intersected_set[id] = subscriber
			end
		end

		output_set = Set.new(intersected_set) #create the resultant set

		return output_set #return the resultant set
	end 

	####################################################################################
	# => Definition: product()
	# => Description: This function performs the Cartesian Product of two sets and stores the result
	# =>              in a third set.
	# => Parameters: 
	# =>        - target_object: set object that the user wishes to perform a union with its sender
	# 
	# => Precondition: Assumes that both the sender and target_object are both valid set objects
	#
	# => Postcondition: Returns a third set that is the result of the Cartesian Product between the sender object
	# =>                and the target_object               
	####################################################################################
	def product(target_object)
		key_number = "0" #start the key number at 0
		overall_set = {} #create empty hash for the result
		sub_set = []     #create empty array that will store each sub-set
		self.set.each do |key, self_subscriber| #interate through each subscriber in the first set
			sub_set.pop() #remove the last subscriber in the sub-set, if there is one
			sub_set.push(self_subscriber) #add the current subscriber to the sub-set
			target_object.set.each do |key, target_subscriber| #start iterating through the subscribers in the second set
				sub_set.push(target_subscriber) #pair the subscriber from the first set to the next subscriber in the second
				overall_set[key_number] = *sub_set #add this sub_set to the overall set
				sub_set.pop() #remove the subscriber that was just paired with the one from the first set. 
				key_number = (key_number.to_i + 1).to_s #increment the key for the hash
			end
		end
		output_set = Set.new(overall_set)
		return output_set
	end

end 