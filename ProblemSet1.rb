#Problem Set 1 for Thinkful App Academy Prep Course Lesson 1

#Writing a reverse method that takes a string and outputs that string in reverse order. 
#Example: reverse("Hello") => "olleH"

def reverse(string)
    #This method will iterate through a string to place the letters into an array, then return that array joined as a string
    result = []
    y = string.length - 1
    for x in 0...string.length do
        result[x] = string[y]
        y -= 1
    end
    return result.join()
end

#Test reverse method:
puts "#{reverse("Hello there my name is Dan")}"

#-----------------------------------------------------------------------------------------

#A factorial method that takes a number and returns 1 * ... * n. This method will take an 
#input and then recursively call itself to multiply n * n-1 until it reaches the special case factorial(0) = 1

def factorial(num)
    if num == 0
        return 1
    end
    return num * factorial(num - 1)
end

#Testing factorial
puts "\n#{factorial(5)}"

#------------------------------------------------------------------------------------------

#A method that takes a string as input and returns the longest word in that string. The problem says to assume only 
#letters and spaces but just in case, this method will also get rid of any non-letter characters in consideration of the longest word

def longest_word(string)
    input_toArray = string.scan(/[a-zA-z]+/)
    return input_toArray.reduce(){|longest, current| 
        longest.length >= current.length ? longest : current 
    }
end

#Testing longest word:
puts "\n Testing longest: #{longest_word("Hey wh34at up yall")}"

#-------------------------------------------------------------------------------------------

#A method that takes a number as input and return the sum of all the numbers between 0 and that number. This is done by 
#recursively calling all numbers in reverse order from this number to 1, with the 1 being the base case.

def sumNum(num)
    return num == 1? num : num + sumNum(num-1)
end

#Testing sumNum
puts "\n Testing sumNum: #{sumNum(5)}"

#--------------------------------------------------------------------------------------------

#A method that takes a number of minutes and converts this to hours:minutes format as a string. 

def Time_Conversion(minutes)
    hours = (minutes - minutes % 60)/60
    minutes_left = minutes % 60
    return "#{hours}:#{minutes_left}"
end

#Testing Time_Conversion
puts "\n Testing Time: #{Time_Conversion(150)}"

#--------------------------------------------------------------------------------------------

#A method that takes a string and iterates through, counting the number of vowels in the string

def Vowel_Counter(string)
    v_count = 0
    for x in 0...string.length do
        if string[x].match(/[aeiou]/) then v_count += 1
        end
    end
    return v_count
end

#Testing Vowel_Counter
puts "\n Testing Vowel Count: #{Vowel_Counter("Hello, my name is Builder Bob")}"

#A shorter vowel counter function:
#This just creates an array of all the vowels from string using the scan function and returns the 
#length of the array, which counts the # of vowels
def Shorter_Vowel(string)
    string.scan(/[aeiou]/).length
end

#Testing shorter vowel counter:

puts "\n Testing Short Vowel Counter: #{Shorter_Vowel("Hello, my name is Builder Bob")}"

#------------------------------------------------------------------------------------------------

#A method to determine whether a given string is a palindrome. 
#Original problem says only lower case letters will be given and no 
#space, but that's boring so this method will actually consider any 
#sentence/string by taking it in and removing spaces from consideration and also making every letter lowercase.
#For this method, the string's length will be analyzed to see whether there is a central 
#rotation character for the palindrome. Ex: abcdedcba needs to take e out of consideration and compare the letters 
#after and before it. We will create two new strings of the halves where one side is reversed and compare whether the two strings are the same. 
def Palindrome?(string)
    new_input = string.scan(/[a-zA-Z]/).join
    input_length = new_input.length
    stringA = new_input.slice!(0, input_length/2.floor).downcase
    puts "\nTesting stringA: #{stringA}"
    puts "\nTesting orig string: #{new_input}"
    stringB = input_length % 2 == 0? new_input.downcase.reverse : new_input.slice(1, new_input.length - 1).downcase.reverse
    puts "\nTesting stringB: #{stringB}"
    return stringA == stringB
end

#Testing cases:

puts "\n#{Palindrome?("Helleh elleh")}"

#-------------------------------------------------------------------------------------------------

#A method that returns true/false for whether or not a letter z appears within 3 spaces after each a. 
#This method iterates through the string and for every "a" will search the next 3 spaces for a "z"
#A flag is used, default to false and set to true if a "z" is found

def nearby_az(string)
	#Use of flags is often discouraged, but in this situation seems to be the
	#simplest way to express the state of the existence of z after a in the string
	flag = false
	string.downcase!
	for x in 0...string.length do
		if string[x] == "a"
			flag = false
			for y in x+1..x+3 do
				if string[y] == "z"
					flag = true
				end
			end
		end
	end
	return flag
end

print "\n Testing nearby_az w/ input Whatz up dawg!: #{nearby_az("Whatz up dawg!")}\n"

print "\n Testing_nearby_az w/ input Whatz up: #{nearby_az("Whatz up")}\n"


#--------------------------------------------------------------------------------------------------

#A method that takes an array of numbers and returns the indexes of 2 numbers that sum to 0.
#If no two numbers sum to 0, the method returns nil
#The indexes of the two numbers are returned as an array
#The method will loop through the array once, creating a hash table to compare the elements in the array
#to the differences between the desired sum (0) and each element. If the difference exists
#in the hash table, the two numbers do add to the desired sum, and at this point the method will take
#the index of those numbers and push them into a result array

def two_sum(input_array, sum)
	#Store result and hash table, initialized as empty arrays
	result = []
	hash = []
	input_array.each do |x|
		#Using the include function, check if the sum - x exists in the hash
		if hash.include?(sum - x)
			result.push(hash.index(sum-x))
			result.push(x)
		else
			hash.push(x)
		end
	end
	return result.empty? ? nil : result
end

#Testing cases:

print "Testing two_sum with [1, 2, -3, 3] #{two_sum([1,2,-3,3], 0)}\n"
print "Testing two_sum with [1,2,3,4] (should return nil) => #{two_sum([1,2,3,4], 0)}\n"


#---------------------------------------------------------------------------------------------------

#Method that takes a number and returns true or false based on whether it is a power of 2
#To reduce runtime, the algorithm uses 4 as a base (as it is a power of 2 and every power of 4
#is also a power of 2) and will iterate through powers of 4 until it reaches or exceeds the current
#number. At this point, if it equals the current number return true, otherwise, test if 
#the point/2 equals num. 

def is_power_of_2?(num)
	x = 4
	until x >= num
		x *= 4
	end
	return x == num ? true : x/2 == num ? true : false
end

#Testing cases:

print "Testing power_of_2 for 64: #{is_power_of_2?(64)}\n"
print "Testing power_of_2 for 48: #{is_power_of_2?(48)}\n"

#---------------------------------------------------------------------------------------------

