# part 1
maxes = {'red' => 12, 'green' => 13, 'blue' => 14}
puts File.readlines('data/day2.txt').map {|l|
  game, pulls = l.split(':')
  game = game.split.last.to_i
  pulls.split(';').each do |round|
    round.split(', ').each do |pull|
      count, color = pull.split
      game = 0 if count.to_i > maxes[color]
    end
  end
  game
}.sum

# part 2
puts File.readlines('data/day2.txt').map {|l|
  maxes = {'red' => 0, 'green' => 0, 'blue' => 0}
  pulls = l.split(':').last
  pulls.split(';').each do |round|
    round.split(', ').each do |pull|
      count, color = pull.split
      maxes[color] = [count.to_i, maxes[color]].max
    end
  end
  maxes.values.inject(1){|m, o| m * o}
}.sum