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
    #first_elf = nil
    #last_elf = nil
    elves = {}
    # elves = {
    #   12: {
    #     calories: 123456,
    #   },
    #   33: {
    #     calories: 123456,
    #   }
    # }
    positions = {}
    # positions = {
    #   1: 12,
    #   2: 33,
    #   3: 28,
    # }
    gold_elf = nil
    gold_calories = 0

    silver_elf = nil
    silver_calories = 0

    bronze_elf = nil
    bronze_calories = 0

    elf = 1
    elf_total = 0
    index = 0
    while index < @calories.count
      item = @calories[index]
      #puts "elf[" + elf.to_s + "] food[" + index.to_s + "]=" + item.to_s
      #puts "isnumber? " + is_number?(item).to_s
      if is_number?(item) == false

        if elf_total > gold_calories
          # bump the others down
          bronze_elf = silver_elf
          bronze_calories = silver_calories
          silver_elf = gold_elf
          silver_calories = gold_calories
          gold_elf = elf
          gold_calories = elf_total
        elsif elf_total > silver_calories
          # bump the others down
          bronze_elf = silver_elf
          bronze_calories = silver_calories
          silver_elf = elf
          silver_calories = elf_total
        elsif elf_total > bronze_calories
          bronze_elf = elf
          bronze_calories = elf_total
        end
        # might be able to fix with linked lists sorting

        elf += 1
        elf_total = 0 
         #unless still at one
        index += 1
        next
      end

      elf_total += item.to_i

      index += 1
    end
    
    #gold_calories
    puts "elf[" + gold_elf.to_s + "] calories=" + gold_calories.to_s
    puts "elf[" + silver_elf.to_s + "] calories=" + silver_calories.to_s
    puts "elf[" + bronze_elf.to_s + "] calories=" + bronze_calories.to_s
    top3_total = gold_calories + silver_calories + bronze_calories
  end
end

#file = File.open("input.txt")
#file_data = file.read.split("\n")
#puts file_data.class.name

main = Main.new("input-00.txt")
result = main.run
puts "result = "+ result.to_s # should be 24,000

main = Main.new("input.txt")
result = main.run
puts "result = " + result.to_s # should be 72,478
