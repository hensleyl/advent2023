# parse board
numbers = []
symbols = []
File.readlines('data/day3.txt').each.with_index do |l, row|
  number = ''
  l.each_char.with_index do |c, column|
    if c.between?('0', '9')
      number += c
    else
      unless number.empty?
        numbers << [number.to_i, row, column - 1]
      end
      unless c == '.' || c == "\n"
        symbols << [c, row, column]
      end
      number = ''
    end
  end
end

# part 1
total = 0
numbers.each do |number, n_row, n_end|
  n_start = n_end - number.to_s.size
  total += number if symbols.any?{|_, r, c| r.between?(n_row - 1, n_row + 1) && c.between?(n_start, n_end + 1)}
  # puts "#{number} - #{n_start}-#{n_end+1}: #{symbols.any?{|r, c| r.between?(n_row - 1, n_row + 1) && c.between?(n_start, n_end + 1)}}"
end
puts total

# part 2
total = 0
symbols.each do |symbol, g_r, g_c|
  if symbol == '*'
    gear_parts = numbers.find_all {|number, n_r, n_end|
      n_start = n_end - number.to_s.size
      g_r.between?(n_r - 1, n_r +1) && g_c.between?(n_start, n_end + 1)
    }
    if gear_parts.size == 2
      total += gear_parts.first.first * gear_parts.last.first
    end
  end
end
puts total