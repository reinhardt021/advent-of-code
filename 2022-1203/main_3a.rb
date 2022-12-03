class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
    @priority_map = get_priority_hash
  end

  def get_priority_hash
    letters = ('a'..'z').to_a + ('A'..'Z').to_a
    priority_map = letters.each_with_index.map {|x, i| [x.to_sym, i+1]}.to_h
  end
  
  def get_intersect(item)
      chars = item.split('')
      half = chars.length / 2
      part1 = chars[0..(half - 1)]
      part2 = chars[half..(chars.length - 1)]

      #puts part1.join+ "[#{part1.length.to_s}]" + part2.join + "[#{part2.length.to_s}]"
      intersect = (part1 & part2).first 
  end

  def run
    result = nil
    priorities = []
    index = 0
    while index < @data.count
      item = @data[index]
      index += 1

      intersect = get_intersect(item)

      priorities << @priority_map[intersect.to_sym]
    end
    #puts "priorities" + priorities.to_s

    return priorities.sum
  end
end

main = Main.new("input_3a.txt")
results = main.run
puts "results: ", results
