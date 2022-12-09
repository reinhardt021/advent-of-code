class Main
  LEFT = 'L'
  UP = 'U'
  RIGHT = 'R'
  DOWN = 'D'
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run
    head = {
      x: 0,
      y: 0,
    }
    tail = {
      x: 0,
      y: 0,
      trail: {}, # hash to store all positions and counts
    }
    @data.each do |motion|
      parts = motion.split(' ')
      direction = parts[0]
      paces = parts[1].to_i

      puts "motion[#{direction} #{paces}]"

      (paces).times do 
        puts "head{#{head[:x]},#{head[:y]}} tail{#{tail[:x]},#{tail[:y]}}"
        head = move_head(head, direction)
        puts "head: #{head.to_s} "
        tail = move_tail(tail, head)
        puts "tail: #{tail.to_s} "
      end
    end
  end

  def move_head(head, direction)
    if direction == LEFT
      head[:x] = head[:x] - 1
    elsif direction == UP
      head[:y] = head[:y] + 1
    elsif direction == RIGHT
      head[:x] = head[:x] + 1
    elsif direction == DOWN
      head[:y] = head[:y] - 1
    end
    puts "head: #{head.to_s} "

    return head
  end

  def move_tail(tail, head)
    # TODO how far head is from tail
    # if the distance is greater than 1 space in X or Y
    # then choose the axis that matches to close gap
    #   if not on same X or Y then go diagonally towards it
    # then check if within 1 distance then don't move
    #
    return tail
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
main = Main.new('input_9a.txt')
results = main.run
puts "results: " + results.to_s
assertEquals(13, results)

#main = Main.new('input_9b.txt')
#results = main.run
#puts "results: " + results.to_s

