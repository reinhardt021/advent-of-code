class Main
  REGISTER = 'X'

  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run
    index = 0
    while index < @data.length
      line = @data[index]
      index += 1

      puts "line: #{line}"

      # TODO
    end
  end

end

def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end

#assertEquals(26, Main.new(in5).run())
files = [
  {
    name: 'input_10a.txt',
    #expected_result: 1,
  },
  #{
    #name: 'input_10b.txt',
    #expected_result: 13140,
  #},
]

files.each do |file|
  main = Main.new(file[:name])
  results = main.run
  puts "results: " + results.to_s
  if file[:expected_result]
    assertEquals(file[:expected_result], results)
  end
end

#main = Main.new('input_9a.txt')
#results = main.run
#puts "results: " + results.to_s
#assertEquals(1, results)

#main = Main.new('input_9c.txt')
#results = main.run
#puts "results: " + results.to_s
#assertEquals(36, results)

#main = Main.new('input_9b.txt')
#results = main.run
#puts "results: " + results.to_s

