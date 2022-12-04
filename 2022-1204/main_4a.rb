class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run 
    index = 0
    while index < @data.length
      item = @data[index]
      index += 1
    
      parts = item.split(',')
      #This example list uses single-digit section IDs to make it easier to draw; 
      #your actual list might contain larger numbers. 

      result = is_range_within_another(parts[0], parts[1])
      puts "is range within another = #{result}"
    end

    # In how many assignment pairs 
    # does one range fully contain the other?

  end

  def is_range_within_another(range1, range2)
    min_max1 = range1.split('-')
    min_max2 = range2.split('-')
    magnitude1 = min_max1[1].to_i - min_max1[0].to_i
    magnitude2 = min_max2[1].to_i - min_max2[0].to_i

    puts "range1: #{range1.to_s}[#{magnitude1}] && range2: #{range2.to_s}[#{magnitude2}]"
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

    puts "the smaller range is #{smaller_range.to_s}"
    # if smaller magnitude has min within larger and max within larger
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
