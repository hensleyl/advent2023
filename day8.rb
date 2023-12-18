# part 1

lines = File.readlines('data/day8.txt')

instruction_lines = lines.shift.chomp
lines.shift # blank line
nodes = lines.map{|line|
  k, l, r = line.gsub(/[[:punct:]]/, '').split
  [k, {'L' => l, 'R' => r}]
}.to_h

instructions = instruction_lines.each_char.cycle
steps = 0
location = 'AAA'
until location == 'ZZZ' do
  location = nodes[location][instructions.next]
  steps += 1
end
puts steps

# part 2

puts nodes.keys.find_all{|l|l.end_with?('A')}.map{|location|
  instructions = instruction_lines.each_char.cycle
  steps = 0
  until location.end_with?('Z') do
    location = nodes[location][instructions.next]
    steps += 1
  end
  steps
}.inject(1){|m, o| m.lcm(o)}