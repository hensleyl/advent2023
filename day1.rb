nums = %w(one two three four five six seven eight nine)
values = nums.zip('1'..'9').to_h.merge(('1'..'9').zip('1'..'9').to_h)
puts File.readlines('data/day1.txt').map {|l|
  left  = l.match(/.*?(\d|#{nums.join('|')})/)[1]
  right  = l.match(/.*(\d|#{nums.join('|')})/)[1]
  values[left] + values[right]
}.map(&:to_i).sum