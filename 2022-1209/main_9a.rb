class Main
  LEFT = 'L'
  UP = 'U'
  RIGHT = 'R'
  DOWN = 'D'
  POS = [UP, RIGHT]
  NEG = [LEFT, DOWN]
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def get_position(x, y)
    return "#{x}-#{y}"
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

    return head
  end

  def store_new_posn(tail)
    new_posn = get_position(tail[:x], tail[:y]).to_sym
    new_count = tail[:trail].has_key?(new_posn) ? (tail[:trail][new_posn] + 1) : 1
      tail[:trail][new_posn] = new_count
      #puts "tail: #{tail.to_s}"


      return tail
  end

  def move_tail(tail, head, direction)
    x_distance = get_distance(head, tail, :x)
    y_distance = get_distance(head, tail, :y)
    x_diff = x_distance.magnitude
    y_diff = y_distance.magnitude

    puts "head{#{head[:x]},#{head[:y]}} tail{#{tail[:x]},#{tail[:y]}} x_d[#{x_diff}] y_d[#{y_diff}]"

    if x_diff > 1 
      # TODO: can't just do this direction check 
      # has to be a check of which way the diff is on other axis
      # to close gap properly
      tail[:x] += 1 * (x_distance < 0 ? -1 : 1)
      if y_diff > 0
        tail[:y] += 1 * (y_distance < 0 ? -1 : 1)
      end
      tail = store_new_posn(tail)
    elsif y_diff > 1
      tail[:y] += 1 * (y_distance < 0 ? -1 : 1)
      if x_diff > 0
        tail[:x] += 1 * (x_distance < 0 ? -1 : 1)
      end
      tail = store_new_posn(tail)
    end

    # TODO: try to render the thing to debug it
    # looks lke the BUG shows up on the last two iterations of R 4

    return tail
  end

  def get_distance(head, tail, axis)
    #puts "head #{head.to_s} tail #{tail.to_s} axis #{axis.to_s}"
    return (head[axis] - tail[axis])
  end

  def run
    head = {
      x: 0,
      y: 0,
    }
    tail = {
      x: 0,
      y: 0,
      trail: {
        '0-0': 1,
      }, # hash to store all positions and counts
    }
    @data.each do |motion|
      parts = motion.split(' ')
      direction = parts[0]
      paces = parts[1].to_i

      puts "motion[#{direction} #{paces}]"

      (paces).times do 
        head = move_head(head, direction)
        tail = move_tail(tail, head, direction)
      end
    end

    return tail[:trail].keys.length
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

