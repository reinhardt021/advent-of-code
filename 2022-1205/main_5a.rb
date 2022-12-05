class Main

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

  def parse_drawing(raw_data)
    @stacks = []
    @steps = []

    store_stacks = true
    store_steps = false
    index = 0
    while index < raw_data.length
      item = raw_data[index]
      index += 1

      has_nums = string_contains_nums(item)
      if has_nums
        store_stacks = false
        store_steps = true
      end

      message = 'store stackz'
      if store_stacks
        message = "store stacks"
      end
      if store_steps
        message = "store steps"
      end
      puts "- #{item} >> #{message}"
      #puts ">> #{item} >> nums?#{has_nums.to_s} - empty?#{empty_line}"
    end
  end

  def string_contains_nums(string)
    nums_found = string.scan(/\d/)
    nums_found.length > 0
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
