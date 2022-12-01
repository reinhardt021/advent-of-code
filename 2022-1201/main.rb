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

  def run(elf_count = 1)
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
    rank = {
      first: nil,
      second: nil,
      third: nil
    }
    # rank = {
    #   first: 12,
    #   second: 33,
    #   third: 28,
    # }

    #gold_elf = nil
    #gold_calories = 0

    #silver_elf = nil
    #silver_calories = 0

    #bronze_elf = nil
    #bronze_calories = 0

    elf = 1
    elf_total = 0
    index = 0
    while index < @calories.count
      item = @calories[index]
      index += 1
      #puts "elf[" + elf.to_s + "] food[" + index.to_s + "]=" + item.to_s
      #puts "isnumber? " + is_number?(item).to_s
      if is_number?(item) == false

        # reset after hitting a null
        elf += 1
        elf_total = 0 
        #unless still at one
        next
      end

      elf_total += item.to_i

      elf_key = elf.to_s.to_sym
      elves[elf_key] = elf_total
      
      # TODO: missing the final line count
      elf_id = rank[:first] ? rank[:first].to_s.to_sym : nil
      calories = elf_id ? elves[elf_id] : 0
      if elf_total > calories
        # bump the others down
        rank[:third] = rank[:second] # 2nd >> 3rd
        rank[:second] = rank[:first] # 1st >> 2nd
        rank[:first] = elf # 1st = new elf
        next
      end

      elf_id = rank[:second] ? rank[:second].to_s.to_sym : nil
      calories = elf_id ? elves[elf_id] : 0
      if elf_total > calories
        # bump the others down
        rank[:third] = rank[:second] # 2nd >> 3rd
        rank[:second] = elf # 2nd = new elf
        next
      end

      elf_id = rank[:second] ? rank[:second].to_s.to_sym : nil
      calories = elf_id ? elves[elf_id] : 0
      if elf_total > calories
        rank[:third] = elf # 3rd = new elf
      end

    end
    
    # return values
    #gold_calories
    elf1 = rank[:first].to_s
    elf2 = rank[:second].to_s
    elf3 = rank[:third].to_s
    calories1 = elves[elf1.to_sym]
    calories2 = elves[elf2.to_sym]
    calories3 = elves[elf3.to_sym]
    puts "elf[" + elf1 + "] calories=" + calories1.to_s
    puts "elf[" + elf2 + "] calories=" + calories2.to_s
    puts "elf[" + elf3 + "] calories=" + calories3.to_s
    #top3_total = gold_calories + silver_calories + bronze_calories
    if elf_count == 1
      calories1
    elsif elf_count == 3
      top3_total = calories1 + calories2 + calories3
    end
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
