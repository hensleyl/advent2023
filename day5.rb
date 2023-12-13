# part 1

lines = File.readlines('data/day5.txt')

seeds = lines.shift.split[1..-1].map(&:to_i)
maps = {}
ranges = nil
lines.each do |line|
  line = line.chomp
  next if line.empty?
  tokens = line.split
  if tokens.last == 'map:'
    ranges = []
    maps[tokens.first.split('-').first] = { destination: tokens.first.split('-').last, ranges: ranges}
  else
    tokens = tokens.map(&:to_i)
    # maybe just store the delta instead of source and dest starts
    ranges << {range: (tokens[1]..tokens[1]+tokens[2]), dest_start: tokens[0], source_start: tokens[1], len: tokens[2]}
  end
end

def min_location(values, start_source, maps)
  values.map{|value|
    source = start_source
    until source == 'location' do
      range = maps[source][:ranges].find{|r| r[:range].include?(value)}
      if range
        value = value - range[:source_start] + range[:dest_start]
      end
      source = maps[source][:destination]
    end
    value
  }.min
end

puts min_location(seeds, 'seed', maps)


# part 2
class Range
  def intersects?(rhs)
    self === rhs.first || self === rhs.last || rhs === self.first || rhs === self.last
  end
end

values = seeds.each_slice(2).map{|s, l| s..s+l}
source = 'seed'
until source == 'location' do
  new_values = []
  until values.empty?
    value = values.pop
    range = maps[source][:ranges].find{|r| r[:range].intersects?(value)}
    if range
      r=range[:range]
      start = value.first
      last = value.last
      if value.first < r.first
        values.push value.first..(r.first - 1)
        start = r.first
      end
      if value.last > r.last
        values.push (r.last + 1)..value.last
        last = r.last
      end
      new_values.push (start - range[:source_start] + range[:dest_start])..(last - range[:source_start] + range[:dest_start])
    else
      new_values.push value
    end
  end
  values = new_values
  source = maps[source][:destination]
end
puts values.map{|r|r.first}.min
