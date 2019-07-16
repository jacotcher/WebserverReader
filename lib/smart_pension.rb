# Class that stores each visit as an instance object
class Visit
  attr_accessor :page, :address

  # Initialise method that interprets the string and initialises the object
  def initialize(visit_string)
    length = visit_string.length
    index_of_space = visit_string.index(' ')
    page = visit_string[0..index_of_space-1].chomp
    address = visit_string[index_of_space+1..length].chomp
    @page = page
    @address = address
  end

  # Count method that is able to count how many visit objects have been created
  def self.count
    return all.count
  end

  # Method that returns an array of all created objects
  def self.all
    ObjectSpace.each_object(self).to_a
  end

end


# Method that reads the file input and returns an array of each line
#There is some error handling here mainly used for testing purposes, but also to provide the user with a more understandeable error message
def read_file(filename)
  begin
    file_contents = File.readlines filename
    return file_contents
  rescue Errno::ENOENT => e
    puts "It is likely that the filename you have entered as an argument is incorrect, or the file is missing"
    puts e.inspect
    return nil
  rescue TypeError => e
    puts "It is likely that you have forgotten to include an argument with the filename"
    puts e.inspect
    return nil
  end
end

# Method that sorts any hash that is passed to it, and prints the sorted hash in the correct format
# Note: The type argument is defaulted to visits, but can be changed for instances of unique_visits
def sort_and_print(hash, type="visits")
  new_hash = hash.sort_by { |page, visits| -visits}.to_h
  # Print into console to check
  new_hash.each do |page, number_of_visits|
      print page + " " + number_of_visits.to_s + " " + type + " "
  end
  # Return sorted hash
  return new_hash
end


# This runs the read_file method to start the program, this is the equivalent to the main method in java
visit_array = read_file(ARGV[0])

begin
  # Initialises the arrays and hashes that are used
  visits_hash = Hash.new(0)
  unique_visits_hash = Hash.new(0)
  unique_addresses_hash = Array.new

  # This initialises each string in the visit_array as an instance of Visit
  visits_string = visit_array.map{|visit| "visit#{visit_array.index(visit)} = Visit.new('#{visit.chomp}')"}.join(';')
  eval(visits_string)

  #This loops through all Visit instances and counts the number of visits on each page, as well as the number of unique visits
  Visit.all.each do |visit|
    visits_hash[visit.page] += 1
    # Each time a unique visit is detected, it adds the address and page to an array, so that it can be checked against for future checks
    if !unique_addresses_hash.include? [visit.page, visit.address]
      unique_addresses_hash.push [visit.page, visit.address]
      unique_visits_hash[visit.page] +=1
    end
  end
  #Sorted hash stored in variable, and is printed to console
  ordered_visits = sort_and_print(visits_hash)
  puts
  #Sorted hash stored in variable, and is printed to console
  ordered_unique_visits = sort_and_print(unique_visits_hash, "unique visits")

rescue NoMethodError => e
  puts "This is likely due to the log file not being read. Check the filename, and that you've supplied the correct argument"
  puts e.inspect
  return false
end
