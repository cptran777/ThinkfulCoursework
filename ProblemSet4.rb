#Thinkful Problem Set 4

#A method to check whether a number is prime
#A way to check if a number is prime is to check whether it is divisible by prime numbers
#aside from one. However, without a prepopulated set of prime numbers, the method to 
#recursively call a prime number check to build said population would take too long

#Instead, this method takes a number and finds the square root of that number and checks
#whether it is divisible by any number incrementally by 1 up to that square root
#The reasoning for using the square root is that after that square root, the number set
#that potentially multiplies to a number repeats itself
#Ex: 100 factors: 2, 50; 4, 25; 5, 20; 10, 10 <-- square root; 20, 5 <-- repeated set
# 25, 4 <-- repeated set; 50, 2 <-- repeated set

def is_prime(num)
	if num <= 1
		return false
	end
	for x in 2..Math.sqrt(num).floor do
		if num % x == 0
			return false
		end
	end
	#If not divisible by anything, return the default case true because the number
	#therefore is prime
	return true
end

#Test cases
5.times do
	x = rand(100)
	puts "Testing prime: #{x}: #{is_prime(x)}"
end

divider = "-----" * 15

puts divider

#----------------------------------------------------------------------------------

#A method that uses the above prime test to deterine the nth prime number in the set
#defined as all prime numbers starting at 2

#The method below uses a counter to track prime numbers from 2 to n. Once counter = n
#that signifies the nth prime number has been found and will return it

def nth_prime(n)
	counter = 0
	check_num = 2
	#Use >= to prevent accidental infinite loops
	until counter >= n do
		if is_prime(check_num) 
			counter += 1
		end
		if counter == n
			return check_num
		end
		check_num += 1
	end
	return nil
end

#Test cases:
#Creates an array of prime numbers to check against nth_prime method:

prime_test_array = []
prime_tracker = 2
until prime_test_array.length == 10 do
	if is_prime(prime_tracker)
		prime_test_array.push(prime_tracker)
	end
	prime_tracker += 1
end

#Testing nth prime for 1 to 10
for nth_test in 1..10 do
	puts "Testing cases for nth_prime: All should equal true"
	puts "Testing nth_prime at n = #{nth_test}: #{nth_prime(nth_test) == prime_test_array[nth_test-1]}"
end

puts divider

#----------------------------------------------------------------------------------

#A method to find the longest palindrome within a string. 

#This method will take the palindrome test defined in a previous solution and iterate
#through the string, taking a longer subset each time and test whether it is a 
#palindrome and keep track of the longest

#Palindrome test method:

def Palindrome?(string)
    if string.length < 3
    	return false
    end
    new_input = string.scan(/[a-zA-Z]/).join
    input_length = new_input.length
    stringA = new_input.slice!(0, input_length/2.floor).downcase
    stringB = input_length % 2 == 0? new_input.downcase.reverse : new_input.slice(1, new_input.length - 1).downcase.reverse
    return stringA == stringB
end

#Method to find the longest palindrome in a substring of a string (or the overall string)
#Note: a string must be at least 3 letters to be a palindrome

#As palindromes imply matching letters, the method will, for each letter in the iteration
#thrugh the string, search from the end from a matching letter
#To shorten the method's number of operations, test whether the string from first letter
#to matching letter is longer than the current longest palindrome

def longest_palindrome(string)
	current_longest = ""
	if string.length < 3
		return false
	end
	#This represents the overarching iteration through the string. 
	#As a string must be at least length 3 to be a palindrome, no search is necessary
	#for the last 2 letters of the string
	for x in 0...string.length-2 do
		#Note: Need to ensure that every matching letter is checked
		#First part of conditional removes spaces from consideration for palindrome-ness
		if string[x] != " " && string.slice(x+1...(string.length)).include?(string[x])
			substring = string.slice(x..(string.rindex(string[x])))
			if Palindrome?(substring) && substring.length > current_longest.length
				current_longest = substring
				#If the longest palindrome is the entire string itself, return it
				if current_longest.length == string.length
					return current_longest
				end
			end
			#Check the substring, without the last matched letter for palindrome
			#This is to account for second matched letters, but wastes runtime on
			#Some unnecessary operations
			sub_test = longest_palindrome(string.slice(x...(string.rindex(string[x]))))
			if sub_test && sub_test.length > current_longest.length
				current_longest = sub_test
			end
		end
	end
	return current_longest.length > 0 ? current_longest : false
end

#Test cases:

#Basic test case:
puts "Testing longest palindrome for 'Hellebungardiane' : #{longest_palindrome("Hellebungardiane")}"

#A test case for spaces:
palin_test1 = "Let's get yggy with it."
puts "Testing long palindrome case #{palin_test1}: " + longest_palindrome(palin_test1)

#A test case for palindrome found across words
palin_test2 = "This is isn't nonsense."
puts "Testing long palindrome case #{palin_test2}: " + longest_palindrome(palin_test2)

puts divider

#----------------------------------------------------------------------------------

#A method to find the greatest common factor between two numbers

#The greatest possible common factor is the smaller of the two numbers. With this 
#logic, the method simply starts with the smaller of the two numbers and works 
#backwards, testing for a case where both numbers are divisible by the same number
#If no such case is found, returns 1 by default

def gcf(num1, num2)
	x = num1 < num2 ? num1 : num2
	while x > 1 do
		if num1 % x == 0 && num2 % x == 0
			return x
		end
		x -= 1
	end
	return 1
end

#Test cases

10.times do
	gcf_test1 = rand(100)
	gcf_test2 = rand(100)
	puts "Testing GCF: #{gcf_test1} and #{gcf_test2}: #{gcf(gcf_test1, gcf_test2)}"
end

puts divider

#------------------------------------------------------------------------------------

#A method that takes a string and shifts the letters forward by 3 in the alphabet
#If the letter is z, it wraps back around to a
#THis will take into account capital letters as well

def brutus_cipher(string)
	result = ""
	is_letter = /[a-zA-Z]/
	for x in 0...string.length do
		puts "For loop iterating..."
		if is_letter.match(string[x])
			if string[x].ord.between?(88, 91) || string[x].ord > 119
				result += (string[x].ord - 23).chr
			else
				result += (string[x].ord + 3).chr
			end
		else
			result += string[x]
		end
	end
	return result
end

#Test cases

et_tu1 = "abcedfg"
et_tu2 = "TUVWXYZAbcd tuvwxyza"

puts "Testing brutus: #{et_tu1}: " + brutus_cipher(et_tu1)
puts "Testing brutus: #{et_tu2}: " + brutus_cipher(et_tu2)

puts divider

#----------------------------------------------------------------------------------

#A method that takes in a string and returns the number of letters that appear more
#than once

#This method will make use of a hash map, similarly to a previous solution, that will
#track the appearance of letters and how many times each letter appears. 
#Instead of only returning the highest count letter, this will count the number 
#letters with a count greater than 1

def num_repeats(string)
	#Counter to track the number of numbers greater than 1
	counter = 0
	letter_count = {}
	#Remove spaces by splitting the string into an array and then back again
	input_line = string.scan(/[a-zA-Z]/).join.downcase
	for x in 0...input_line.length do
		if letter_count.has_key?(input_line[x])
			letter_count[input_line[x]] += 1
		else
			letter_count[input_line[x]] = 1
		end
	end
	letter_count.each do |letter, count|
		if count > 1
			counter += 1
			puts "Test num_repeats: adding #{letter} to list"
		end
	end
	return counter
end

#Test cases
num_test = "abcdefabaaghe"
num_test2 = "Hello, my name is Builder bob"
puts "Testing num repeats: #{num_repeats(num_test)}"
puts "Testing num repeats: #{num_repeats(num_test2)}"








