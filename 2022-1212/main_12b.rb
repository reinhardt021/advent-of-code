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


