class Main
  S_MARK = 'S'
  E_MARK = 'E'
  S_HEIGHT = 'a'
  E_HEIGHT = 'z'
  LEFT = :left
  RIGHT = :right
  UP = :up
  DOWN = :down
  NEXT_DIR = {
    left: '<',
    right: '>',
    up: '^',
    down: 'v',
  }

  def get_key(point)
    return "#{point[:y]}-#{point[:x]}"
  end

  def get_point(x, y, height)
    #return "#{y}-#{x}"

    return {
      y: y,
      x: x,
      height: height,
    }
  end
  
  def parse_map(lines)
    height_map = {
      start: nil,
      end: nil,
      row_count: lines.length,
      col_count: 0,
      elevations: [],
    }
    y_index = 0
    while y_index < lines.length
      line = lines[y_index]

      row = line.split("") 
      height_map[:col_count] = row.length if height_map[:col_count] < 1

      start_x = row.index(S_MARK)
      end_x = row.index(E_MARK)

      if start_x
        #puts "found starting y[#{y_index}] x[#{start_x}]"
        height_map[:start] = get_point(start_x, y_index, S_HEIGHT)
      end

      if end_x
        #puts "found ending y[#{y_index}] x[#{end_x}]"
        height_map[:end] = get_point(end_x, y_index, E_HEIGHT)
      end

      height_map[:elevations] << row
      y_index += 1
    end

    return height_map
  end

  def initialize(filename)
    file = File.open(filename)
    lines = file.read.split("\n")
    @height_map = parse_map(lines)
    #puts "height map: #{@height_map.to_s}"
  end
  
  def get_shortest_path(paths)
    path_lengths = paths.map { |path| path.length }
    fewest_steps = path_lengths.sort.first

    return fewest_steps
  end

  def get_diff(curr_height, next_height)
    return next_height.ord - curr_height.ord
  end

  def at_edge(curr_point, direction, row_count, col_count)
    is_edge = nil
    curr_x = curr_point[:x]
    curr_y = curr_point[:y]
    if direction == :left
      is_edge = (curr_x == 0)
    elsif direction == :up
      is_edge = (curr_y == 0)
    elsif direction == :right
      is_edge = (curr_x == (col_count - 1)) 
    elsif direction == :down
      is_edge = (curr_y == (row_count - 1))
    end

    return is_edge
  end

  def get_new_x(curr_x, direction)
    new_x = curr_x
    if direction == LEFT
      new_x = curr_x - 1
    elsif direction == RIGHT
      new_x = curr_x + 1
    end

    return new_x
  end

  def get_new_y(curr_y, direction)
    new_y = curr_y
    if direction == UP
      new_y = curr_y - 1
    elsif direction == DOWN
      new_y = curr_y + 1
    end

    return new_y
  end

  def check_next(hmap, curr_point, curr_path, direction)
    dir = NEXT_DIR[direction]
    if at_edge(curr_point, direction, hmap[:row_count], hmap[:col_count]) 
      puts "#{curr_point.to_s} [#{dir}] EDGE"
      return false
    end

    curr_x = curr_point[:x]
    curr_y = curr_point[:y]
    curr_height = curr_point[:height]

    new_x = get_new_x(curr_x, direction)
    new_y = get_new_y(curr_y, direction)
    new_height = hmap[:elevations][new_y][new_x]
    new_point = get_point(new_x, new_y, new_height)
    #puts "y[#{new_y}] x[#{new_x}] h[#{new_height}]"
    if new_height == E_MARK && get_diff(curr_height, E_HEIGHT) < 2
      puts "#{curr_point.to_s} [#{dir}] END"
      return new_point
    end

    new_key = get_key(new_point)
    if curr_path.include?(new_key)
      # prevent from going to a path already taken
      puts "#{curr_point.to_s} [#{dir}] DUPE #{new_point.to_s}"
      #puts "already been there #{new_key}"
      return false
    end

    if get_diff(curr_height, new_height) < 2
      puts "#{curr_point.to_s} [#{dir}] GOOD #{new_point.to_s}"
      #puts "good to go"
      return new_point
    end

    puts "#{curr_point.to_s} [#{dir}] HIGH #{new_point.to_s}"
    #puts "all too large"
    return false
  end

  def at_end(curr_point, end_point)
    return curr_point[:x] == end_point[:x] && curr_point[:y] == end_point[:y]
  end

  def get_paths(hmap, curr_point, curr_path, dir_path)
    paths = []
    if at_end(curr_point, hmap[:end])
      # break if reach end point then return last point in array
      return false
    end

    [LEFT, UP, RIGHT, DOWN].each do |dir|
      next_point = check_next(hmap, curr_point, curr_path, dir)
      #puts "go #{dir}? [#{next_point}]"
      if next_point
        ext_path = curr_path
        ext_path << get_key(next_point)
        dir_path << NEXT_DIR[dir]
        #puts "ext_path: #{ext_path.to_s}"
        puts "dir_path[#{dir_path.length}] #{dir_path.join("")}"
        next_paths = get_paths(hmap, next_point, ext_path, dir_path)
        
        #if next_paths
        #end
        # loop throught next paths and attach to array to pass up 
        #if ext_path.include?()

        # recursive call to get array of sub paths
        #     filter if not contain endpoint
        #     map to concat to curr point and return
      end
    end
    
   
    return paths
  end

  def run
    start_point = @height_map[:start]
    curr_path = [get_key(start_point)]
    dir_path = []
    paths = get_paths(@height_map, start_point, curr_path, dir_path)

    paths = [
      ['0-0', '0-1', '1-1'],
      ['0-0', '1-0', '1-1', '2-1', '2-2'],
    ]

    return get_shortest_path(paths)
  end

end


def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end

aoc_day = 12
files = {
  #file => expected result
  'a' => 31, 
  #'b' => nil, # no expected result yet
  #'c' => nil, #13140,
}

files.keys.each do |file|
  expected_result = files[file]
  filename = "input_#{aoc_day}#{file}.txt"
  results = Main.new(filename).run
  puts "results: " + results.to_s
  if expected_result
    assertEquals(expected_result, results)
  end
end


