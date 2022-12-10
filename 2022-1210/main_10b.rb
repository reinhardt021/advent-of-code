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

  def update_milestones(milestones, cycle, x)
    milestones[cycle.to_s.to_sym] = {
      register: x,
      cycle: cycle,
      signal_strength: (cycle * x),
    }

    return milestones
  end

  def get_sprite(x)
    # get array of sprite 3 values representing its positions
    # can easily compare to see if cycle is included in those positions
    # then create either # or . in crt
    sprite = []

    #if at edges then diff
    if x == 1
      sprite << (1)
      sprite << (2)
      sprite << (3)
    elsif x == 40
      sprite << (38)
      sprite << (39)
      sprite << (40)
    else
      # default
      sprite << (x - 1)
      sprite << (x)
      sprite << (x + 1)
    end
    
    return sprite
  end

  def add_to_crt(crt, cycle, x)
    pixel = cycle % 40
    if pixel == 0
      pixel = 40
    end

    sprite = get_sprite(x)
    if sprite.include?(pixel)
      crt += '#'
    else
      crt += '.'
    end

    if (pixel) == 40 
      crt += "\n"
    end

    return crt
  end

  def run
    milestones = {}
    x = 1 # register
    cycle = 0
    crt = "" # string to contain characters per cycle

    # use the loop 
    # for each cycle
    #   check where the sprite (X) is 
    #     middle of sprite ! unless at edges
    #   and if one of its parts matches the cycle
    #   use modulus of 40 for cycle to compare to sprite

    @data.each do |line|
      cycle += 1
      parts = line.split(' ')
      command = parts[0]

      crt = add_to_crt(crt, cycle, x)
      #puts "cyc[#{cycle}] cmd[#{parts[0]} #{parts[1]}] x[#{x}] "

      # if noop then don't do anything just let loop again
      if command == ADDX 
        cycle += 1

        crt = add_to_crt(crt, cycle, x)

        value = parts[1].to_i
        x += value
        #puts "cyc[#{cycle}] cmd[#{parts[0]} #{parts[1]}] x[#{x}] "
      end

    end

    return crt
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
    ## expected_result: 1,
  },
  {
    name: 'input_10b.txt',
    ## expected_result: 13140,
  },
  {
    name: 'input_10c.txt',
    ## expected_result: 13140,
  },
]

files.each do |file|
  main = Main.new(file[:name])
  results = main.run
  puts "\nresults: \n" + results.to_s
  if file[:expected_result]
    assertEquals(file[:expected_result], results)
  end
end

