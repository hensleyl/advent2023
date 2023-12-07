# part 1
total = 0
File.readlines('data/day4.txt').each do |l|
  _, winners, yours = l.split(/:|\|/)
  winners = winners.split
  winning_count = yours.split.count{|n| winners.include?(n)}
  total += 2**(winning_count - 1) if winning_count > 0
end
puts total

# part 2
cards = File.readlines('data/day4.txt').map do |l|
  game, winners, yours = l.split(/:|\|/)
  winners = winners.split
  [game.split.last.to_i-1, yours.split.count{|n| winners.include?(n)}]
end

results = Array.new(cards.size){1}
cards.each do |game_index, winner_count|
  results[game_index+1..game_index+winner_count] = results[game_index+1..game_index+winner_count].map{|x| x+results[game_index]}
end
puts results.sum