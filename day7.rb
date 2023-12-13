# part 1

value_norm = ('2'..'9').zip('2'..'9').to_h.merge("TJQKA".each_char.with_index.map{|c, i| [c, ('9'.ord + i + 1).chr]}.to_h)
puts File.readlines('data/day7.txt').map{|l|
  hand, bid = l.split
  [[hand.each_char.tally.values.sort.reverse, hand.each_char.map{|c|value_norm[c]}], bid.to_i]
}.sort.each_with_index.map{|hb, index| hb.last * (index+1) }.sum

# part 2

@value_norm = ('2'..'9').zip('2'..'9').to_h.merge("TQKA".each_char.with_index.map{|c, i| [c, ('9'.ord + i + 1).chr]}.to_h)
@value_norm['J'] = '1'
def hand_value(hand)
  value = hand.each_char.tally
  jokers = value.delete('J')
  value = value.values.sort.reverse
  value << 0
  value[0] += jokers if jokers
  [value, hand.each_char.map{|c| @value_norm[c]}]
end
puts File.readlines('data/day7.txt').map{|l|
  hand, bid = l.split
  [hand_value(hand), bid.to_i]
}.sort.each_with_index.map{|hb, index| hb.last * (index+1) }.sum