# part 1

times, distances = File.readlines('data/day6.txt').map{|l| l.split[1..-1].map(&:to_i)}

def ways_to_win(races)
  races.map{|t, d|
    root = ((t+Math.sqrt(t*t-4*d+4))/2).floor
    root -= 1 if root*(t-root) <= d
    2 * root - t + 1
  }.inject(1){|m, o| m * o}
end

puts ways_to_win(times.zip(distances))

# part 2

puts ways_to_win([[times.map(&:to_s).join('').to_i, distances.map(&:to_s).join('').to_i]])