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

      puts "part1: #{parts[0].to_s} && part2: #{parts[1].to_s}"
      # TODO: check how if pair fully contains another
      result = is_range_within_another(parts[0], parts[1])
    end

    # In how many assignment pairs 
    # does one range fully contain the other?

  end

  def is_range_within_another(range1, range2)
    range_with_greater_min = nil
    # check if min of one is greater than other
    min_max1 = range1.split('-')
    min_max2 = range2.split('-')
    # tricky situation if equal
    # might just check one with smaller magnitude
    # if smaller magnitude has min within larger and max within larger
    # then you have a true
    if (min_max1 < min_max2)
      range_with_greater_min = 
    else
    end
    # then check if the one with greater min has smaller max
    
  end

end

main = Main.new('input_4a.txt')
results = main.run
puts "results: ", results

#main = Main.new('input_4b.txt')
#results = main.run
#puts "results: ", results
