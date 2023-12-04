def main
  path = "./input.txt"
  puts "* Part 1 =#{path}="
  puts "  Result: #{part_one path}"
  puts "* Part 2: =#{path}="
  puts "  Result: #{part_two path}"
end

def part_one path
  dice_counts = { red_count: 12, green_count: 13, blue_count: 14 }

  File.read(path)
      .each_line
      .map { |l| parse_game l }
      .find_all { |g| valid? g, **dice_counts }
      .map { |g| g[:id] }
      .sum
end

def valid? game, red_count:, green_count:, blue_count:;
  game[:rounds].all? do |h|
    h[:red]   <= red_count &&
    h[:green] <= green_count &&
    h[:blue]  <= blue_count
  end
end

def part_two path
  File.read(path)
      .each_line
      .map { |l| parse_game l }
      .map { |g| get_maximums g }
      .map { |m| m[:red] * m[:green] * m[:blue] }
      .sum
end

def get_maximums game
  red   = game[:rounds].map { |round| round[:red]   }.max
  green = game[:rounds].map { |round| round[:green] }.max
  blue  = game[:rounds].map { |round| round[:blue]  }.max

  { red:, green:, blue: }
end

def parse_game s
  id = s.match(/^Game (.*):/)
        .captures
        .first
        .to_i

  rounds = s.match(/^.*: (.*)/)
            .captures
            .first
            .split(";")
            .map { |r| parse_round r }

  { id:, rounds: }
end

def parse_round s
  kvps = s.strip.split(",").map do |d|
           parse_dice d
         end

  dice = Hash[kvps]

  { red: 0, green: 0, blue: 0 }.merge dice
end

def parse_dice s
  count, color = s.strip.split
  [color.to_sym, count.to_i]
end

main
