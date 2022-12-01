input = [
1000,
2000,
3000,
nil,
4000,
nil,
5000,
6000,
nil,
7000,
8000,
9000,
nil,
10000,
]

class Main
  def initialize(calories)
    @calories = calories
  end

  def run
    max_calories = 0
    elf_with_max = nil

    elf = 1
    curr_total = 0
    index = 0
    puts @calories.count
    while index < @calories.count
      item = @calories[index]
      puts "index[" + index.to_s + "]=" + item.to_s
      if item == nil 
        puts "new elf"
         #change elf count
        elf += 1
        #curr_total = 0
         #unless still at one
        index += 1
        next
      end

      #curr_total += item

      #if curr_total > max_calories
        #elf_with_max = elf
      #end

      index += 1
    end
    
    max_calories
  end
end

main = Main.new(input)
result = main.run

puts "result = ", result
