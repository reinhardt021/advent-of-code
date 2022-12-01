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
    counts = []

    elf = 1
    cal_count = 0
    index = 0
    while index < @calories.count
      item = @calories[index]
      index += 1

      #puts "elf[" + elf.to_s + "] food[" + index.to_s + "]=" + item.to_s
      #puts "isnumber? " + is_number?(item).to_s

      if is_number?(item) == false # reset after hitting a null
        elf += 1
        cal_count = 0 
        # TODO: consider if still at one
        next
      end

      cal_count += item.to_i

      counts[elf-1] = cal_count
    end
    
    #puts "counts: ", counts
    sorted = counts.sort
    #puts "sorted counts: ", sorted
    #puts "1st: ", sorted[-1]
    #puts "2nd: ", sorted[-2]
    #puts "3rd: ", sorted[-3]
    if elf_count == 1
      sorted[-1]
    elsif elf_count == 3
      top3_total = sorted[-1] + sorted[-2] + sorted[-3]
    end
  end
end

main = Main.new("input-00.txt")
result = main.run
puts "result = "+ result.to_s # should be 24,000
result = main.run(3)
puts "result = "+ result.to_s # should be 45,000

main = Main.new("input.txt")
result = main.run
puts "result = " + result.to_s # should be 72,478
result = main.run(3)
puts "result = "+ result.to_s # should be ? 210367
