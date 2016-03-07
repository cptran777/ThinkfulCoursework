#A method that finds the third largest number in an array. An assumption is that the array has at least
#3 numbers
#The first method iterates through the array 3 times, finding the largest number each time. 
#On the first two times, it removes the largest number. On the third time, it returns this number.

def third_greatest(nums)
    2.times {nums.slice!(nums.index(nums.max))}
    return nums.max
end

#Test cases:
print "Testing [1,3,5,6] => 3: #{third_greatest([1,3,5,6]) == 3}\n"

#The above method does not work for cases where the array contains two values that are equal. 
#[1,3,5, 7, 7] would return 5, while 3 is technically the third "largest" number. 
#Solution: Track the largest number and continue to remove if the next number removed is the same as the previous
#Also, need to make a base case where if we arrive at the last remaining element we stop removing to evaluate it.
#Ex: [1,1,3] should stop at the last 1 and evaluate whether it is equal to the previous max. If so, return
#"no third greatest" or false something to that effect
#The following method uses the above logic to account for repeated numbers

def third_vtwo(nums)
    #Counter counts how many unique "maxes" have been removed
    counter = 0
    #Using this until loop here with the control flows below should prevent any infinite loops
    #Assigning prev to be a default value that changes with each iteration of the until loop
    prev = false
    until counter > 2 do
        if nums.length == 1
            return false
        end
        #Assigning nums.max to a variable so that it doesn't have to re-evaluate every time this 
        #expression is used
        max_value = nums.max
        if max_value != prev
            counter += 1
            if counter == 3
                return max_value
            end
            nums.slice!(nums.index(max_value))
            prev = max_value
        else
            nums.slice!(nums.index(max_value))
        end
    end
end

#Test cases: 
print "Testing [1,3,5,6] => 3: #{third_vtwo([1,3,5,6]) == 3}\n"
print "Testing [1,3,5,5,6] => 3: #{third_vtwo([1,3,5,5,6]) == 3}\n"
print "Testing [1,3,3,3,3] => false: #{third_vtwo([1,3,3,3,3]) == false}\n"

#Just for fun, if access to the max method for arrays was not possible, and we were dealing with 
#unsorted arrays, the easiest solution would be to sort the array from greatest to smallest and find
#the third unique number in the list. 

#The following method uses the merge sort algorithm, which runs in n log n time and then iterates through
#the array one time to return the third unique number. 

#Defining the merge part of the algorithm in a separate method:

def merge(arrayA, arrayB)
    a = 0
    b = 0
    result = []
    #Taking the larger number between two arrays and putting that in the output
    while a < arrayA.length && b < arrayB.length do
        if arrayA[a] > arrayB[b]
            result.push(arrayA[a])
            a += 1
        elsif arrayA[a] < arrayB[b]
            result.push(arrayB[b])
            b += 1
        else
            result.push(arrayA[a])
            result.push(arrayB[b])
            a += 1
            b += 1
        end
    end
    #After either one of the arrays has been 'emptied out', push the
    #remaining elements in the other array to the result
    if a < arrayA.length
        until a == arrayA.length do
            result.push(arrayA[a])
            a += 1
        end
    else
        until b == arrayB.length do
            result.push(arrayB[b])
            b += 1
        end
    end
    return result
end

#The merge_sort part of the algorithm runs the actual sorting process
#It splits the array down into two halves and recursively calls itself
#with the merge method to sort through the array elements
#Note to self: .ceil is used to always round up to nearest integer
def merge_sort(input_array)
    if input_array.length < 2
        return input_array
    end
    #Stores the left half of the input_array:
    #Takes into account whether the size is even or odd
    left_array = input_array.slice!(0, input_array.length/2.ceil)
    return merge(merge_sort(left_array), merge_sort(input_array))
end

#Test cases for merge sort algorithm:
print "Testing [3,7,9,1]: #{merge_sort([3,7,9,1])}\n"
print "Testing [4,7, 2, 13, 6]: #{merge_sort([4,7,2,13,6])}\n"
print "Testing [5, 1, 12, 5, 2, 7, 2]: #{merge_sort([5,1,12,5,2,7,2])}\n"

#The method below returns the third largest number by first sorting 
#the array using the merge sort algorithm. Then, using the same counter concept
#as the previous solution to track unique numbers, return the third
#unique value found. Similar to the previous solution, while an array
#is assumed to be at least size 3, if 3 unique numbers are not found,
#the method will return false

def third_unsorted(unsorted_array)
    sorted_array = merge_sort(unsorted_array)
    #Starting the counter at 1 and the iteration at the second element
    #in the array as the first element will always be unique. 
    counter = 1
    for x in 1...sorted_array.length do
        if sorted_array[x] != sorted_array[x-1]
            counter += 1
        end
        if counter == 3
            return sorted_array[x]
        end
    end
    return false
end

#Test cases:
#Creating random arrays and then finding the third largest number:
10.times do
    test_array = []
    5.times do
        test_array.push(rand(15))
    end
    puts "Testing #{test_array.join(",")}: " + third_unsorted(test_array).to_s
end

#-------------------------------------------------------------------

#A method that takes a string and returns the most common letter and
#how many times it appeared in that string
#This method iterates through the string, creating and updating hashmap
#that maps the letters to a value count and tracking the highest value.
#After looping through the string, return the key of the hashmap (
#representing the letters in the array) that matches to the tracked
#highest value. 

def most_letter(string)
    #Create an empty has to house the letters
    #Remove spaces by splitting the string into an array:
    input_line = string.scan(/[a-zA-Z]/).join.downcase
    print "Checking input_line: #{input_line}\n"
    letter_count = {}
    highest_count = 0
    for x in 0...input_line.length do
        if letter_count.has_key?(input_line[x])
            letter_count[input_line[x]] += 1
            if highest_count < letter_count[input_line[x]]
                highest_count += 1
            end
        else
            letter_count[input_line[x]] = 1
        end
    end
    return [letter_count.key(highest_count), highest_count]
end

#Test cases: 
print "Testing 'I had a little lamb' => ['a', 3]: #{most_letter("I had a little lamb")}\n"
print "Testing 'Mary had a little lamb as white as snow' => ['a', 6]:  #{most_letter("Mary had a little lamb as white as snow")}"

#-------------------------------------------------------------------------------

#A method that takes in a number and returns a string, adding a dash before each odd
#digit. String should not start or end with a dash though
#The method should stringify the number, then iterate through the string and concatenate
#a dash "-" before each odd number (identified using the modulus % operator)
#The method should start at the second index as to not put a dash at the beginning

def dasherize_me(num)
    num_string = num.to_s
    result = num_string[0]
    for x in 1...num_string.length do
        result += num_string[x].to_i % 2 == 0 ? num_string[x] : "-" + num_string[x]
    end
    return result
end

#Test cases:
10.times do
    dash_test = rand(999999)
    puts "Testing dasherize: " + dasherize_me(dash_test)
end

#-----------------------------------------------------------------------------

#A method that takes a string of words and capitalizes the first letter of each one.
#This method splits the string into an array of words and uses the capitalize method
#of each one. 

def capitalize_me(string)
    split_string = string.split(" ")
    split_string.each do |x|
        x.capitalize!
    end
    return split_string.join(" ")
end

#Test cases:
some_words = "hello, my name is builder bob"
puts capitalize_me(some_words)

#--------------------------------------------------------------------------------

#A method that takes a string and an array and rearranges the string based on the array
#This method creates an array of the string and uses the zip function to link the two
#arrays together, then sorts by the indeces using the sort method and returns the 
#letters rejoined as a new string

def scramble_string(string, array)
    split_string = string.split("")
    combined_string = array.zip(split_string)
    print "Testing combined_string: "
    print combined_string
    combined_string.sort!
    result = []
    combined_string.each do |x| result.push(x[1]) end
    print "\n"
    return result
end

some_letters = "jhklim"
some_indeces = [3,4,5,6,1,2]
print scramble_string(some_letters, some_indeces)








