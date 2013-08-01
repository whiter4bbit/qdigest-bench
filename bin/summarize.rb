def sum(values)
  values.inject(0){|accum, v| accum + v}
end

def mean(values)
  sum(values) / values.count
end

def stddev(values)
  avg = mean(values)
  squares = values.map {|v| (v - avg) ** 2}
  Math.sqrt(sum(squares) / values.count)
end

def median(values)
  sorted = values.sort
  len = sorted.count
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

results = Hash.new{ |hash,key| hash[key] = [] }

STDIN.readlines.each do |line|
  param, value = line.split(":")
  results[param] << value.strip.to_i
end

results.keys.each do |key|
  puts "#{key}"
  values = results[key]
  puts "  Mean: #{mean(values)}"
  puts "  Stddev: #{stddev(values)}"
  puts "  Median: #{median(values)}"
  puts 
end
