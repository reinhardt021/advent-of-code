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

  def get_point(x, y, height, seen = false)
    return {
      y: y,
      x: x,
      height: height,
      seen: seen,
    }
  end
  
  def parse_map(lines)
    h_map = {
      start: nil,
      end: nil,
      row_count: lines.length,
      col_count: 0,
      min_steps: nil,
      elevations: [],
      grid: [],
    }
    y = 0
    while y < lines.length
      line = lines[y]

      row = line.split("") 
      if h_map[:col_count] < 1
        h_map[:col_count] = row.length
        h_map[:min_steps] = row.length * lines.length
      end

      h_map[:elevations] << row
      h_map[:grid] << row.map.with_index {|h, x| get_point(x, y, h) }

      if h_map[:start] == nil && start_x = row.index(S_MARK)
        h_map[:start] = get_point(start_x, y, S_HEIGHT)
        h_map[:grid][y][start_x][:height] = 'a'
      end

      if h_map[:end] == nil && end_x = row.index(E_MARK)
        h_map[:end] = get_point(end_x, y, E_HEIGHT)
        h_map[:grid][y][end_x][:height] = 'z'
      end

      y += 1
    end

    return h_map
  end

  def initialize(filename)
    file = File.open(filename)
    lines = file.read.split("\n")
    @h_map = parse_map(lines)
  end
  
  def can_reach(curr_height, next_height)
    return (next_height.ord - curr_height.ord) < 2
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

    curr_height = curr_point[:height]

    new_x = get_new_x(curr_point[:x], direction)
    new_y = get_new_y(curr_point[:y], direction)
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

    # doesn't quite work
    # especially if another route tried it already
    #if hmap[:grid][new_y][new_x][:seen]
      #return false
    #end

    if new_height != E_MARK && can_reach(curr_height, new_height)
      #puts "#{curr_point.to_s} [#{dir}] GOOD #{new_point.to_s}"
      return new_point
    end

    #puts "#{curr_point.to_s} [#{dir}] HIGH #{new_point.to_s}"
    return false
  end

  def get_paths(hmap, curr_point, curr_path, dir_path)
    paths = [] # will store here 

    curr_path.push get_key(curr_point)
    paths.push curr_path

    hmap[:grid][curr_point[:y]][curr_point[:x]][:seen] = true

    if curr_path.length >= hmap[:min_steps]
      # stop if path is longer than upper_bound
      return paths
    end

    if get_key(curr_point) == get_key(hmap[:end])
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

      #puts "D[#{directions.length}] #{directions.join("")}"
      ext_paths = get_paths(hmap, next_point, ext_path, directions)

      ext_paths.each do |path|
        if !path.include?(get_key(hmap[:end]))
          next
        end
        #puts "X[#{path.length}] #{path.join(",")}"
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
    end
   
    return paths
  end

  def find_paths(hmap, curr_point, curr_path, dir_path)
    paths = []
    curr_path.push get_key(curr_point)
    puts "curr path: " + curr_path.join(",")

    x = curr_point[:x]
    y = curr_point[:y]
    hmap[:grid][y][x][:seen] = true

    [[x - 1, y], [x, y - 1], [x + 1, y], [x, y + 1]].each do |x2, y2|
      if curr_path.length >= hmap[:min_steps]
        next
      end

      if x2 < 0 || y2 < 0 || hmap[:row_count] <= y2 || hmap[:col_count] <= x2
        next
      end

      next_point = hmap[:grid][y2][x2]
      next_key = get_key(hmap[:grid][y2][x2])
      if next_key == get_key(hmap[:end])
        curr_path.push next_key
        paths.push curr_path
        next
      end

      if next_point[:seen]
        next
      end
    

      if (next_point[:height].ord - curr_point[:height].ord) < 2
        paths += find_paths(hmap, next_point, curr_path, dir_path)
        hmap[:grid][y][x][:seen] = false
      end

    end


    return paths
  end

  def bfs(hmap, heads, depth)

    # if found the end then return depth
    #return bfs(hmap, new_heads.uniq, depth+1)

    next_heads = []
    # loop through the head to create new points
    heads.each do |curr_point|
      hx = curr_point[:x]
      hy = curr_point[:y]
      hmap[:grid][hy][hx][:seen] = true
      # go through point to create new heads
      next_steps = [
        [hx - 1, hy],
        [hx, hy - 1],
        [hx + 1, hy],
        [hx, hy + 1],
      ].each do |x2, y2|

        if x2 < 0 || y2 < 0 || hmap[:row_count] <= y2 || hmap[:col_count] <= x2
          next
        end

        next_point = hmap[:grid][y2][x2]
        if next_point[:seen]
          next
        end


        if (next_point[:height].ord - curr_point[:height].ord) < 2
          next_heads << next_point
          next_key = get_key(next_point)
          if next_key == get_key(hmap[:end])
            return depth + 1
          end
        end

      end
    end

    if next_heads.uniq.length > 0 
      bfs(hmap, next_heads.uniq, depth + 1)
    end
  end

  def run
    #paths = get_paths(@h_map, @h_map[:start], [], [])
    #paths = find_paths(@h_map, @h_map[:start], [], [])
    depth = bfs(@h_map, [@h_map[:start]], 0)
    puts "depth: " + depth.to_s

    #path_lengths = paths.map do |path|
      #puts "P[#{path.length}] #{path.join(',')}" # debuggin
      #path.length
    #end

    #return path_lengths.sort.first - 1
    return depth
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
  'a' => 31, 
  'b' => nil, # no expected result yet
}
files.keys.each do |file|
  expected_result = files[file]
  filename = "input_#{aoc_day}#{file}.txt"
  puts "results: " + (results = Main.new(filename).run).to_s
  assertEquals(expected_result, results) if expected_result
end


