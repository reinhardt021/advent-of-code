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
    end

    # In how many assignment pairs 
    # does one range fully contain the other?

  end

end

main = Main.new('input_4a.txt')
results = main.run
puts "results: ", results

#main = Main.new('input_4b.txt')
#results = main.run
#puts "results: ", results
