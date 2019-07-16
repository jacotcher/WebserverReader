class Visits
end


def read_file(filename)
  begin
    file_contents = File.readlines filename
    return file_contents
  rescue Errno::ENOENT
    return false
  end

end

puts read_file("te")
visit_array = read_file("ARGV0")
