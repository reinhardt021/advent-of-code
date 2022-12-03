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
  
  def get_intersect(group)
      part1 = group[0].split('')
      part2 = group[1].split('')
      part3 = group[2].split('')

      #puts part1.join+ "[#{part1.length.to_s}]" + part2.join + "[#{part2.length.to_s}]"
      intersect = ((part1 & part2) & part3).first 
  end

  def run
    group = []
    priorities = []
    index = 0
    while index < @data.count
      item = @data[index]
      index += 1

      group << item

      if group.length == 3 
        intersect = get_intersect(group)
        puts "group: " + group.to_s + " >> INT[#{intersect.to_s}]"
        priorities << @priority_map[intersect.to_sym]
        group = [] # reset group before going to next group
      end
    end
    #puts "priorities" + priorities.to_s

    return priorities.sum
  end
end

main = Main.new("input_3a.txt")
results = main.run
puts "results: " + results.to_s

#main = Main.new("input_3b.txt")
#results = main.run
#puts "results: " + results.to_s

