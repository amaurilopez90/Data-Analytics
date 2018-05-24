####################################################################################################
# => Name: Amauri Lopez 
# => Description: Reads in csv files containing subscriber information to a magazine
# =>              Information includes a subscriber name and a subscriber ID number.
# =>              Stores this information into a subscriber object and creates a set 
# =>              of subscribers for that file. The program can then perform Union,
# =>              Intersection, and Cartesian Product functions on two sets. 
#
# => Filename: main.rb
# => Description: The purpose of this file is just to run the User Interface, to begin the program
#
# => Last Data modified on: 9/26/2017
#####################################################################################################

require_relative 'userInterface' #import the userInterface file so we can access the UserInterface class

the_Menu = UserInterface.new()   
the_Menu.mainmenu()              #run the main menu
