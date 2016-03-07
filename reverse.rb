#Problem Set 1 for Thinkful App Academy Prep Course Lesson 1

#Writing a reverse method that takes a string and outputs that string in reverse order. 
#Example: reverse("Hello") => "olleH"

def reverse(string)
    #This method will iterate through a string to place the letters into an array, then return that array joined as a string
    y = string.length - 1
    result = ""
    while y >= 0 do
        result += string[y]
        y -= 1
    end
    return result
end

#Test reverse method:
print "#{reverse("Hello there my name is Dan")}"