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

  def printout(rank, elves)
    #elf1 = rank[:first].to_s
    #elf2 = rank[:second].to_s
    #elf3 = rank[:third].to_s
    elf1 = rank[0].to_s
    elf2 = rank[1].to_s
    elf3 = rank[2].to_s
    calories1 = elves[elf1.to_sym]
    calories2 = elves[elf2.to_sym]
    calories3 = elves[elf3.to_sym]
    puts ""
    puts "1st[" + elf1 + "] calories[" + calories1.to_s
    puts "2nd[" + elf2 + "] calories[" + calories2.to_s
    puts "3rd[" + elf3 + "] calories[" + calories3.to_s
    puts "" 
  end

  def run(elf_count = 1)
    #first_elf = nil
    #last_elf = nil
    elves = {}
    # elves = {
    #   12: 123456, # calories
    #   33: 123456, # calories
    # }
    rank = {
      first: nil,
      second: nil,
      third: nil
    }
    # rank = {
    #   first: 12, # elf_id
    #   second: 33,
    #   third: 28,
    # }
    posn = [nil, nil, nil]
    # posn = [12, 33, 28]
    #top_elf = {
      #elf_id: 12,
      #next_elf: 24
    #}
    counts = []


    elf = 1
    cal_count = 0
    index = 0
    while index < @calories.count
      #printout(rank, elves)
      #printout(posn, elves)
      item = @calories[index]
      index += 1

      puts "elf[" + elf.to_s + "] food[" + index.to_s + "]=" + item.to_s
      #puts "isnumber? " + is_number?(item).to_s

      if is_number?(item) == false # reset after hitting a null
        elf += 1
        cal_count = 0 
        # TODO: consider if still at one
        next
      end

      cal_count += item.to_i

      elf_id = elf.to_s.to_sym
      elves[elf_id] = cal_count
      
      counts[elf-1] = cal_count

      # TODO: double counting when accumulating 

      elf_id = posn[2] ? posn[2].to_s.to_sym : nil
      calories = elf_id ? elves[elf_id] : 0
      if cal_count > calories && posn[2] != elf
        posn[2] = elf # 3rd = new elf
        next
      end

      elf_id = posn[1] ? posn[1].to_s.to_sym : nil
      calories = elf_id ? elves[elf_id] : 0
      if cal_count > calories && posn[1] != elf
        # bump the others down
        posn[2] = posn[1] # 2nd >> 3rd
        posn[1] = elf # 2nd = new elf
        next
      end

      elf_id = posn[0] ? posn[0].to_s.to_sym : nil
      calories = elf_id ? elves[elf_id] : 0
      if cal_count > calories && posn[0] != elf
        # bump the others down
        posn[2] = posn[1] # 2nd >> 3rd
        posn[1] = posn[0] # 1st >> 2nd
        posn[0] = elf # 1st = new elf
        next
      end

    end
    
    puts "counts: ", counts
    sorted = counts.sort
    puts "sorted counts: ", sorted
    puts "1st: ", sorted[-1]
    puts "2nd: ", sorted[-2]
    puts "3rd: ", sorted[-3]
    #elf1 = rank[:first].to_s
    #elf2 = rank[:second].to_s
    #elf3 = rank[:third].to_s
    elf1 = posn[0].to_s
    elf2 = posn[1].to_s
    elf3 = posn[2].to_s
    calories1 = elves[elf1.to_sym]
    calories2 = elves[elf2.to_sym]
    calories3 = elves[elf3.to_sym]
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
#result = main.run(3)
#puts "result = "+ result.to_s # should be 45,000

#main = Main.new("input.txt")
#result = main.run
#puts "result = " + result.to_s # should be 72,478
#result = main.run(3)
#puts "result = "+ result.to_s # should be ?
