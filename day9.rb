# part 1
puts File.readlines('data/day9.txt').map{|l|
  history = l.chomp.split.map(&:to_i)
  max = history.size - 2
  until history[0..max].all?(&:zero?) do
    0.upto(max).each do |i|
      history[i] = history[i+1] - history[i]
    end
    max -= 1
  end
  history.sum
}.sum

# part 2
puts File.readlines('data/day9.txt').map{|l|
  history = l.chomp.split.map(&:to_i)
  max = history.size - 2
  firsts = []
  until history[0..max].all?(&:zero?) do
    firsts.push(history.first)
    0.upto(max).each do |i|
      history[i] = history[i+1] - history[i]
    end
    max -= 1
  end
  firsts.reverse.inject{|m, o| o - m}
}.sum