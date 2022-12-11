class Main
  MONKEY = 'Monkey'
  STARTING = 'Starting'
  OPERATION = 'Operation:'
  TEST = 'Test:'
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
      puts items.join('')

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
        }
      end

      if curr_monkey == nil
        next
      end

      if line_type == STARTING
        items = line.scan(/\d+/)
        #puts "items: #{items.map {|x| x.to_i}}"
        monkeys[curr_monkey][:items] = items.map {|x| x.to_i}
      end

      if line_type == OPERATION
        index_operand = 4
        index_factor = 5
        operand = parts[index_operand]
        factor = parts[index_factor]
        #puts "operand[#{operand}] factor[#{factor}]"
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
        #puts "MONKEY FOUND: " + monkey.to_s
        success_or_fail = parts[1] == T ? :success_monkey : :fail_monkey
        monkeys[curr_monkey][success_or_fail] = monkey
      end

    end

    puts "monkeys: #{monkeys}"
    return monkeys
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

aoc_day = 11
files = {
  #file => expected result
  'a' => 10605, # no expected result yet
  #'b' => nil, #10605,
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


