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
      #level = row.split(' ') #// doesn't work
      level = row.split('') #// works better
      #puts "row: " + level.to_s
      # TODO store each row into the stacks


      stack_index = 0
      level_index = stack_index + 1
      while stack_index < stack_count
        crate = row[level_index]
        #puts "crate: " + crate
        #store crate into array
        if crate != " "
          stack_key = stack_ids[stack_index].to_s
          #puts "stack_key: " + stack_key

          stacks[stack_key.to_sym] << crate
        end
        
        # once i have the id of each stack then I can go 
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
        @stack_ids = nums_found.map { |x| x.to_i }
        @stacks = parse_stacks(@stack_ids, rows)
        #@stacks << item # TODO: parse into HASH of ARRAYS
      end
      if store_steps
        message = "store steps"
        @steps << item
      end
      #puts "- #{item} >> #{message}"
      #puts ">> #{item} >> nums?#{has_nums.to_s} - empty?#{empty_line}"
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
    # TODO: parse the data line by line first
    # then store into diff variables

    # hard code the parsing?
    # get total row
    # each crate takes 3 chars [x]
    rows = []
    # store the rows first 
    # until you reach numbers
    # then get the numbers in an Array
    # remove the empty spaces
    # then can use the largest number to sort through the rows
  end
  
  def run
    
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
