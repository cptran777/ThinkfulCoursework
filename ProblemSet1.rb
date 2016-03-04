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

#A factorial method that takes a number and returns 1 * ... * n. This method will take an input and then recursively call itself to multiply n * n-1 until it reaches the special case factorial(0) = 1

def factorial(num)
    if num == 0
        return 1
    end
    return num * factorial(num - 1)
end

#Testing factorial
puts "\n#{factorial(5)}"

#------------------------------------------------------------------------------------------

#A method that takes a string as input and returns the longest word in that string. The problem says to assume only letters and spaces but just in case, this method will also get rid of any non-letter characters in consideration of the longest word

def longest_word(string)
    input_toArray = string.scan(/[a-zA-z]+/)
    return input_toArray.reduce(){|longest, current| 
        longest.length >= current.length ? longest : current 
    }
end

#Testing longest word:
puts "\n Testing longest: #{longest_word("Hey wh34at up yall")}"

#-------------------------------------------------------------------------------------------

#A method that takes a number as input and return the sum of all the numbers between 0 and that number. This is done by recursively calling all numbers in reverse order from this number to 1, with the 1 being the base case.

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
#This just creates an array of all the vowels from string using the scan function and returns the length of the array, which counts the # of vowels
def Shorter_Vowel(string)
    string.scan(/[aeiou]/).length
end

#Testing shorter vowel counter:

puts "\n Testing Short Vowel Counter: #{Shorter_Vowel("Hello, my name is Builder Bob")}"

#------------------------------------------------------------------------------------------------

#A method to determine whether a given string is a palindrome. Original problem says only lower case letters will be given and no space, but that's boring so this method will actually consider any sentence/string by taking it in and removing spaces from consideration and also making every letter lowercase.
#For this method, the string's length will be analyzed to see whether there is a central rotation character for the palindrome. Ex: abcdedcba needs to take e out of consideration and compare the letters after and before it. We will create two new strings of the halves where one side is reversed and compare whether the two strings are the same. 
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
#
