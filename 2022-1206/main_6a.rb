class Main

  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("")
  end
  #def initialize(string)
    #@data = string.split("")
  #end

  def is_seq_unique(chars)
    counts = {}

    chars.each do |char|
      if counts.has_key? char
        counts[char] += 1
      else
        counts[char] = 1
      end
    end

    unique = counts.keys.length == 4
    return unique
  end

  def run

    # loop through the chars
    # create array of what you have
    # and check if count is greater than 4
    sequence = []
    index = 0 
    while index < @data.length
      char = @data[index]
      index += 1

      sequence.shift if sequence.length == 4
      sequence << char

      if sequence.length != 4
        next
      end

      puts "seq: #{sequence.to_s}"
      unique_seq = is_seq_unique(sequence)
      if unique_seq
        # exit loop
        # and return count of seq
        break
      end
    end

    return index
  end
end

def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end
in1 = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb' # 7 
in2 = 'bvwbjplbgvbhsrlpgdmjqwftvncz' # 5
in3 = 'nppdvjthqldpwncqszvftbrmjlhg'  # 6
in4 = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' # 10
in5 = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' # 11

main = Main.new('input_6a.txt')
results = main.run
puts "results: " + results.to_s
assertEquals(7, results)
#assertEquals(7, Main.new(in1).run())
#assertEquals(5, Main.new(in2).run())
#assertEquals(6, Main.new(in3).run())
#assertEquals(10, Main.new(in4).run())
#assertEquals(11, Main.new(in5).run())

main = Main.new('input_6b.txt')
results = main.run
puts "results: " + results.to_s
#assertEquals(582, results)

