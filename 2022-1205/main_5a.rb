class Main
  def get_string_nums(string)
    nums_found = string.scan(/\d/)
  end

  def is_step(string)
    string.include? 'move'
  end

  def parse_stacks(stack_ids, rows)
    stacks = {}
    stack_count = stack_ids.length

    stack_ids.each do |id|
      stacks[id.to_s.to_sym] = []
    end
    rows.reverse.each do |row|

      stack_index = 0
      level_index = stack_index + 1
      while stack_index < stack_count

        crate = row[level_index]
        if crate != " "
          stack_key = stack_ids[stack_index]
          stacks[stack_key.to_sym] << crate
        end
        
        stack_index += 1
        level_index += 4
      end

    end

    return stacks
  end

  def parse_drawing(raw_data)
    @stack_ids = []
    @stacks = {} 
    @steps = []

    rows = []
    store_stacks = true
    store_steps = false
    index = 0
    while index < raw_data.length
      item = raw_data[index]
      index += 1

      nums_found = get_string_nums(item)
      has_nums = nums_found.length > 0
      if has_nums
        store_stacks = false
        store_steps = is_step(item)
      end

      message = ''
      if store_stacks
        message = "store stacks"
        rows << item
      end
      if has_nums && !store_stacks && !store_steps
        message = 'store IDs'
        @stack_ids = nums_found
        @stacks = parse_stacks(@stack_ids, rows)
      end
      if store_steps
        message = "store steps"
        @steps << item
      end

    end

    puts "rows:", rows
    puts "@stack_ids:", @stack_ids.to_s
    puts "@stacks:", @stacks
    puts "@steps:", @steps
  end

  def initialize(filename)
    file = File.open(filename)
    raw_data = file.read.split("\n")
    parse_drawing(raw_data)
  end
  
  def run
    @steps.each do |step|
      puts "step: " + step
      
    end

    return get_top_crates(@stack_ids, @stacks)
  end

  def get_top_crates(stack_ids, stacks)
    top_crates = []

    stack_ids.each do |id|
      stack = stacks[id.to_sym]
      top_crates << stack.last
    end

    top_crates.join
  end

end

def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end

main = Main.new('input_5a.txt')
results = main.run
puts "results: " + results.to_s
assertEquals('CMZ', results)

#main = Main.new('input_5b.txt')
#results = main.run
#puts "results: " + results.to_s
#assertEquals('CMZ', results)
