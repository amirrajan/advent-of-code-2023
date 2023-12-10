def diffs sequence
  sequence.each_cons(2)
          .map { |a, b| b - a }
end

def next_in_sequence sequence
  return 0 if sequence.all? { |i| i == 0 }
  return sequence.last + (next_in_sequence diffs sequence)
end

def prev_in_sequence sequence
  return 0 if sequence.all? { |i| i == 0 }
  return sequence.first - (prev_in_sequence diffs sequence)
end

def parse_inputs path
  File.readlines(path)
      .map { |l| l.split(" ").map(&:to_i) }
end

def main
  inputs = parse_inputs "./input.txt"
  puts "* INFO - Part 1"
  part_one = inputs.map { |input| next_in_sequence input }.sum
  puts "  #{part_one}"

  puts "* INFO - Part 2"
  part_two = inputs.map { |input| prev_in_sequence input }.sum
  puts "  #{part_two}"
end

main
