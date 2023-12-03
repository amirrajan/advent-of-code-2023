def main
  puts "* Part 1 =./input.txt="
  puts "  Result: #{part_one "./input.txt"}"
  puts "* Part 2 =./input.txt="
  puts "  Result: #{part_two "./input.txt"}"
end

def part_one path
  File.read(path)                      # read all contents of file
      .each_line                       # split into lines
      .map { |s| s.scan /[1-9]/ }      # find all numeric characters
      .map { |s| [s.first, s.last] }   # get first and last numeric characters
      .map { |s| s.join.to_i }         # join first and last numeric characters into ints
      .sum                             # sum all integers to get calibration value
end

def part_two path
  File.read(path)                      # read all contents of file
      .each_line                       # split into lines
      .map { |s| normalize_numbers s } # replace spelled out numbers with digits
      .map { |s| s.scan /[1-9]/ }      # find all numeric characters
      .map { |s| [s.first, s.last] }   # get first and last numeric characters
      .map { |s| s.join.to_i }         # join first and last numeric characters into ints
      .sum                             # sum all integers to get calibration value
end

def normalize_numbers s
  # before      | after
  # ------------+------------
  # two1nine    | 2wo19ine
  # eightwothree| 8igh2wo3hree
  s.length
   .times
   .map { |index| normalize_number s[index..-1] }
   .join
end

def normalize_number s
  return "1" if s.start_with? "one"
  return "2" if s.start_with? "two"
  return "3" if s.start_with? "three"
  return "4" if s.start_with? "four"
  return "5" if s.start_with? "five"
  return "6" if s.start_with? "six"
  return "7" if s.start_with? "seven"
  return "8" if s.start_with? "eight"
  return "9" if s.start_with? "nine"
  return s[0]
end

main
