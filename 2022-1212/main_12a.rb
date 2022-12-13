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
      min_steps: nil,
      dead_ends: [],
    }
    y_index = 0
    while y_index < lines.length
      line = lines[y_index]

      row = line.split("") 
      if height_map[:col_count] < 1
        height_map[:col_count] = row.length
        height_map[:min_steps] = row.length * lines.length
      end

      if height_map[:start] == nil && start_x = row.index(S_MARK)
        height_map[:start] = get_point(start_x, y_index, S_HEIGHT)
      end

      if height_map[:end] == nil && end_x = row.index(E_MARK)
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
  end
  
  def can_reach(curr_height, next_height)
    diff = (next_height.ord - curr_height.ord)
    return diff < 2
  end

  def at_edge(curr_point, direction, row_count, col_count)
    is_edge = nil
    curr_x = curr_point[:x]
    curr_y = curr_point[:y]
    if direction == LEFT
      is_edge = (curr_x == 0)
    elsif direction == UP
      is_edge = (curr_y == 0)
    elsif direction == RIGHT
      is_edge = (curr_x == (col_count - 1)) 
    elsif direction == DOWN
      is_edge = (curr_y == (row_count - 1))
    end

    return is_edge
  end

  def get_new_x(curr_x, direction)
    new_x = curr_x
    new_x = (direction == LEFT) ? (curr_x - 1) : new_x
    new_x = (direction == RIGHT) ? (curr_x + 1) : new_x

    return new_x
  end

  def get_new_y(curr_y, direction)
    new_y = curr_y
    new_y = (direction == UP) ? (curr_y - 1) : new_y
    new_y = (direction == DOWN) ? (curr_y + 1) : new_y

    return new_y
  end

  def check_next(hmap, curr_point, curr_path, direction)
    dir = NEXT_DIR[direction]
    if at_edge(curr_point, direction, hmap[:row_count], hmap[:col_count]) 
      #puts "#{curr_point.to_s} [#{dir}] EDGE"
      return false
    end

    curr_x = curr_point[:x]
    curr_y = curr_point[:y]
    curr_height = curr_point[:height]

    new_x = get_new_x(curr_x, direction)
    new_y = get_new_y(curr_y, direction)
    new_height = hmap[:elevations][new_y][new_x]
    new_point = get_point(new_x, new_y, new_height)
    if new_height == E_MARK && can_reach(curr_height, E_HEIGHT)
      #puts "#{curr_point.to_s} [#{dir}] END XXXXX"
      return new_point
    end

    new_key = get_key(new_point)
    if curr_path.include?(new_key)
      my_path = curr_path.join(',')
      #puts "#{curr_point.to_s} [#{dir}] DUPE #{new_point.to_s} [#{curr_path.length}]#{my_path}"
      return false
    end

    if hmap[:dead_ends].include?(new_key)
      puts "#{curr_point.to_s} [#{dir}] DEAD #{new_point.to_s}"
      return false
    end

    if new_height != E_MARK && can_reach(curr_height, new_height)
      #puts "#{curr_point.to_s} [#{dir}] GOOD #{new_point.to_s}"
      return new_point
    end

    #puts "#{curr_point.to_s} [#{dir}] HIGH #{new_point.to_s}"
    return false
  end

  def at_end(curr_point, end_point)
    return get_key(curr_point) == get_key(end_point)
  end

  def get_paths(hmap, curr_point, curr_path, dir_path)
    paths = [] # will store here 
    curr_key = get_key(curr_point)
    curr_path << curr_key
    paths << curr_path

    #puts "htmap: #{hmap}"
    upper_bound = hmap[:min_steps]
    #puts "======[#{upper_bound}] MAX"
    if curr_path.length >= upper_bound
      # stop if path is longer than upper_bound
      return paths
    end

    if at_end(curr_point, hmap[:end])
      # break if reach end point then return last point in array
      return paths
    end

    next_paths = []
    [LEFT, UP, RIGHT, DOWN].each do |dir|
      next_point = check_next(hmap, curr_point, curr_path, dir)
      if !next_point
        next
      end

      ext_path = curr_path.clone
      directions = dir_path.clone
      directions << NEXT_DIR[dir]

      puts "ext_path[#{ext_path.length}] #{ext_path.join(",")}"
      puts "dir_path[#{directions.length}] #{directions.join("")}"
      ext_paths = get_paths(hmap, next_point, ext_path, directions)

      ext_paths.each do |path|
        if !path.include?(get_key(hmap[:end]))
          next
        end
        # only add to list of paths if has the end point
        next_paths << path

        if path.length < hmap[:min_steps]
          hmap[:min_steps] = path.length
        end
      end
      
    end

    if next_paths.length > 0
      # just replace the array since they have full paths
      paths = next_paths 
    else 
      # help to avoid this path later
      #hmap[:dead_ends] << curr_key
    end
   
    return paths
  end

  def run
    start_point = @height_map[:start]
    curr_path = []
    dir_path = []
    paths = get_paths(@height_map, start_point, curr_path, dir_path)

    puts "\nPATHS: "
    upper_bound = @height_map[:row_count] * @height_map[:col_count]
    path_lengths = []
    paths.each do |path|
      if path.length > upper_bound
        next
      end

      upper_bound = path.length
      puts "P[#{path.length}] #{path.join(',')}"

      path_lengths << path.length
    end

    puts "hmap: #{@height_map}"

    return path_lengths.sort.first - 1
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


