class Main
  REGISTER = 'X'
  NOOP = 'noop'
  ADDX = 'addx'

  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def is_milestone(cycle)
    if cycle == 20
      return true
    end

    return (cycle - 20) % 40 == 0
  end

  def run
    milestones = {}
    x = 1 # register
    cycle = 0
    @data.each do |line|
      cycle += 1
      parts = line.split(' ')
      command = parts[0]
      puts "cyc[#{cycle}] cmd[#{parts[0]}] in[#{parts[1]}] x[#{x}] "
      milestone = is_milestone(cycle)
      puts "MILESTONE? #{milestone ? 'YES' : 'NO' }"

      # if noop then don't do anything just let loop again
      if command == ADDX 
        cycle += 1
        value = parts[1].to_i
        x += value
        puts "cyc[#{cycle}] cmd[#{parts[0]}] in[#{parts[1]}] x[#{x}] "
        milestone = is_milestone(cycle)
        puts "MILESTONE? #{milestone ? 'YES' : 'NO' }"
      end

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
  {
    name: 'input_10b.txt',
    expected_result: 13140,
  },
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

