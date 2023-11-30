class Main
  def initialize(filename)
  end

  def run
  end

end 

def assertEquals(expected, actual)
  puts expected == actual ? 
    "PASS: exp[#{expected}] == act[#{actual}]" :
    "FAIL: exp[#{expected}] != act[#{actual}]"
end

aoc_day = 13
files = {
  'a' => 29, 
  #'b' => nil, # no expected result yet
}
files.keys.each do |file|
  expected_result = files[file]
  filename = "input_#{aoc_day}#{file}.txt"
  puts "results: " + (results = Main.new(filename).run).to_s
  assertEquals(expected_result, results) if expected_result
end



