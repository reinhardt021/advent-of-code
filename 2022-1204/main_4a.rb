class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run 
    fully_contained_count = 0
    index = 0
    while index < @data.length
      item = @data[index]
      index += 1
    
      parts = item.split(',')

      result = is_range_within_another(parts[0], parts[1])
      puts "    is_range_within_another= #{result}"
      if result
        fully_contained_count += 1
      end
    end

    return fully_contained_count
  end

  def is_range_within_another(range1, range2)
    min_max1 = range1.split('-').map { |x| x.to_i }
    min_max2 = range2.split('-').map { |x| x.to_i }
    magnitude1 = min_max1[1] - min_max1[0]
    magnitude2 = min_max2[1] - min_max2[0]

    puts "#{min_max1.to_s}[#{magnitude1}] && #{min_max2.to_s}[#{magnitude2}]"
    if magnitude1 == magnitude2 
      return min_max1[0] == min_max2[0]
    end

    if magnitude1 < magnitude2
      smaller_range = min_max1
      larger_range = min_max2
    else
      smaller_range = min_max2
      larger_range = min_max1
    end

    smaller_within_larger_min = larger_range[0] <= smaller_range[0]
    smaller_within_larger_max = smaller_range[1] <= larger_range[1]
    return smaller_within_larger_min && smaller_within_larger_max
  end

end

main = Main.new('input_4a.txt')
results = main.run
puts "results: ", results

#main = Main.new('input_4b.txt')
#results = main.run
#puts "results: ", results
