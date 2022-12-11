class Main

  def initialize(filename)
    file = File.open(filename)
    data = file.read.split("\n")
    @monkeys = parse_monkeys(data)
  end
  
  def parse_monkeys(data)
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
  'b' => nil, #10605,
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


