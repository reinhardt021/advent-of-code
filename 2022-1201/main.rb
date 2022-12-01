class Main
  def initialize(file_name)
    file = File.open(file_name)
    calories = file.read.split("\n")
    #puts file_data.class.name
    @calories = calories
  end

  def is_number?(input)
    true if Float(input) rescue false
  end

  def run
    max_calories = 0
    elf_with_max = nil

    elf = 1
    elf_total = 0
    index = 0
    while index < @calories.count
      item = @calories[index]
      #puts "elf[" + elf.to_s + "] food[" + index.to_s + "]=" + item.to_s
      #puts "isnumber? " + is_number?(item).to_s
      if is_number?(item) == false
        elf += 1
        elf_total = 0 
         #unless still at one
        index += 1
        next
      end

      elf_total += item.to_i

      if elf_total > max_calories
        elf_with_max = elf
        max_calories = elf_total
      end

      index += 1
    end
    
    max_calories
  end
end

#file = File.open("input.txt")
#file_data = file.read.split("\n")
#puts file_data.class.name

main = Main.new("input.txt")
result = main.run

puts "result = ", result
