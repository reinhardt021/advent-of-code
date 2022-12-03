class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
    @priority_map = get_priority_hash
    puts @priority_map
  end

  def get_priority_hash
    letters = ('a'..'z').to_a + ('A'..'Z').to_a
    priority_map = letters.each_with_index.map {|x, i| [x.to_sym, i+1]}.to_h
  end

  def run
    result = nil
    priorities = []
    index = 0
    while index < @data.count
      item = @data[index]
      # TODO: plan what to do for each ITEM
      chars = item.split('')
      half = chars.length / 2
      #puts item + " >> [#{chars.length.to_s}]"
      #chars.each { |x| puts x }
      part1 = chars[0..(half - 1)]
      part2 = chars[half..(chars.length - 1)]
      puts part1.join+ "[#{part1.length.to_s}]" + part2.join + "[#{part2.length.to_s}]"
      intersect = (part1 & part2).first 
      puts intersect
      priorities << @priority_map[intersect.to_sym]

      #TODO: beware need to be case-sensitive
      index += 1
    end
    puts "priorities" + priorities.to_s

    return priorities.sum
  end
end

main = Main.new("input_3a.txt")
results = main.run
puts "results: ", results