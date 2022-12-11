class Main
  MONKEY = 'Monkey'
  STARTING = 'Starting'
  OPERATION = 'Operation:'
  PLUS = '+'
  MULTIPLY = '*'
  OLD = 'old'

  TEST = 'Test:'
  DIVISIBLE = 'divisible'

  IF = 'If'
  T = 'true:'
  F = 'false:'

  def initialize(filename)
    file = File.open(filename)
    data = file.read.split("\n")
    @monkeys = parse_monkeys(data)
  end
  
  def parse_monkeys(data)
    monkeys = {}

    curr_monkey = nil
    data.each do |line|
      parts = line.split(' ')
      items = parts.map {|x|  "[#{x}]"}

      line_type = parts[0]
      if line_type == MONKEY
        curr_monkey = parts[1].scan(/\d/).first.to_sym
        monkeys[curr_monkey] = {
          items: [],
          operand: nil,
          factor: nil,
          test: nil,
          quotient: nil,
          success_monkey: nil,
          fail_monkey: nil,
          inspect_count: 0,
        }
      end

      if curr_monkey == nil
        next
      end

      if line_type == STARTING
        items = line.scan(/\d+/)
        monkeys[curr_monkey][:items] = items.map {|x| x.to_i}
      end

      if line_type == OPERATION
        index_operand = 4
        index_factor = 5
        operand = parts[index_operand]
        factor = parts[index_factor]
        monkeys[curr_monkey][:operand] = operand
        monkeys[curr_monkey][:factor] = factor
      end

      if line_type == TEST
        index_test = 1
        index_quotient = 3
        test = parts[index_test]
        quotient = parts[index_quotient]
        monkeys[curr_monkey][:test] = test
        monkeys[curr_monkey][:quotient] = quotient
      end

      if line_type == IF 
        monkey = line.scan(/\d+/).first.to_i
        success_or_fail = parts[1] == T ? :success_monkey : :fail_monkey
        monkeys[curr_monkey][success_or_fail] = monkey
      end

    end

    puts "monkeys: #{monkeys}"
    return monkeys
  end

  def run
    #rounds = 10000
    rounds = 20
    #rounds = 2
    round = 1
    test = [1, 20] + (1..10).map {|x| x * 1000}
    while round <= rounds do
      @monkeys = run_round(@monkeys)
      #if test.include?(round)
        puts "\nROUND #{round}"
        display_monkeys(@monkeys)
      #else
        #puts round
      #end
      round += 1
    end

    return calculate_monkey_business(@monkeys)
  end
  
  def display_monkeys(monkeys)
    # for test purposes
    monkeys.keys.each do |key|
      curr_monkey = monkeys[key]
      count = curr_monkey[:inspect_count]
      puts "Monkey #{key}: inspected items #{count} times"
    end
  end

  def get_new_level(worry, operand, factor)
    new_worry = 0

    if factor == OLD
      factor = worry
    end
    factor = factor.to_i

    if operand == PLUS
      new_worry = worry + factor
    elsif operand == MULTIPLY
      new_worry = worry * factor
    end
    
    return new_worry
  end

  def assess_worry(worry, test, quotient)
    #worried = false

    #if test == DIVISIBLE
      worried = (worry % quotient.to_i == 0)
    #end

    return worried 
  end

  def run_round(monkeys)
    index = 0
    mkeys = monkeys.keys
    while index < mkeys.length
      key = mkeys[index]
      index += 1
    #monkeys.keys.each do |key|
      curr_monkey = monkeys[key]
      items = curr_monkey[:items]
      i = 0
      while i < items.length
        item = items[i]
        i += 1
      #curr_monkey[:items].each do |item|
        count = curr_monkey[:inspect_count]
        curr_monkey[:inspect_count] = 1 + count

        operand = curr_monkey[:operand]
        factor = curr_monkey[:factor]
        inspect_worry = get_new_level(item, operand, factor)
        #bored_worry = (inspect_worry / 3).floor
        #final_worry = bored_worry
        final_worry = inspect_worry

        test = curr_monkey[:test]
        quotient = curr_monkey[:quotient]
        worried = assess_worry(final_worry, test, quotient)
        which_monkey = worried ? :success_monkey : :fail_monkey
        monkey_key = curr_monkey[which_monkey].to_s.to_sym

        next_monkey = monkeys[monkey_key]
        next_monkey[:items] << final_worry
      end
      curr_monkey[:items] = []
    end
    
    return monkeys
  end
  
  def calculate_monkey_business(monkeys)
    monkey_business = 0

    # find the largest two of the counts
    #   create an array of the counts
    #   sort from largest to smallest
    # multiply the two largest together
    counts = monkeys.keys.map do |key|
      monkeys[key][:inspect_count]
    end
    #counts = [101, 95, 7, 105]
    decreasing = counts.sort.reverse
    first = decreasing[0]
    second = decreasing[1]
    #puts first, second

    monkey_business = first * second

    return monkey_business
  end

end

def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end

aoc_day = 11
files = {
  #file => expected result
  'a' => 10605, 
  #'b' => nil, # no expected result yet
  #'c' => nil, #13140,
}

files.keys.each do |file|
  expected_result = files[file]
  filename = "input_#{aoc_day}#{file}.txt"
  main = Main.new(filename)
  results = main.run
  puts "results: " + results.to_s
  if expected_result
    assertEquals(expected_result, results)
  end
end


