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

# Method that finds the number of page visits per page and returns them as a hash
def find_page_visits(visits)
  visits_hash = Hash.new(0)
  visits.each do |visit|
    visits_hash[visit.page] += 1
  end
  # Returned the hash in case it would be required to be stored rather than just printed
  return visits_hash
end

# Method that finds the number of unique visits per page, and returns them as a hash
def find_unique_page_visits(visits)
  unique_visits_hash = Hash.new(0)
  unique_addresses_hash = Array.new
  visits.each do |visit|
    # Each time a unique visit is detected, it adds the address and page to an array, so that it can be checked against for future checks
    if !unique_addresses_hash.include? [visit.page, visit.address]
      unique_addresses_hash.push [visit.page, visit.address]
      unique_visits_hash[visit.page] +=1
    end
  end
  # Returned the hash in case it would be required to be stored rather than just printed
  return unique_visits_hash
end

# Method that takes the read-in visits and creates Visit objects with them
def create_objects(visit_array)
  begin
    visits_string_for_eval = visit_array.map{|visit| "visit#{visit_array.index(visit)} = Visit.new('#{visit.chomp}')"}.join(';')
    eval(visits_string_for_eval)
  rescue NoMethodError => e
    puts e.inspect
  end
end

# This runs the read_file method to start the program, this is the equivalent to the main method in java
visit_array = read_file(ARGV[0])
create_objects(visit_array)
visits_hash = find_page_visits(Visit.all)
unique_visits_hash = find_unique_page_visits(Visit.all)
sort_and_print(visits_hash)
sort_and_print(unique_visits_hash, "unique visits")
