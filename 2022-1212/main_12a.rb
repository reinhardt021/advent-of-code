class Main
  S_MARK = 'S'
  E_MARK = 'E'

  def get_point(x, y, height)
    #return "#{y}-#{x}"

    return {
      x: x,
      y: y,
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
        height_map[:start] = get_point(start_x, y_index, 'a')
      end

      if end_x
        #puts "found ending y[#{y_index}] x[#{end_x}]"
        height_map[:end] = get_point(end_x, y_index, 'z')
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
    puts "height map: #{@height_map.to_s}"
  end
  
  def get_shortest_path(paths)
    path_lengths = paths.map { |path| path.length }
    fewest_steps = path_lengths.sort.first

    return fewest_steps
  end

  def can_go_left(height_map, start_point)
    #puts "a < b [#{'z' < 'r'}]" #// test to see chars compare works
    if start_point[:x] == 0 
      return false
    end

    new_x = start_point[:x] - 1
    new_y = start_point[:y]
    # get value at that next point
    new_elevation = height_map[:elevations][new_y][new_x]
    puts "y[#{new_y}] x[#{new_x}] e[#{new_elevation}]"

    #if new_elevation

  end

  def get_paths(height_map, start_point)
    # go from starting point
    #   check if at edge && if not more than one higher
    # check if can go left
     go_left = can_go_left(height_map, start_point)
    # check if can top
    # check if can right
    # check if can down
    #   go deeper
    #   get array of sub paths
    #     filter if not contain endpoint
    #     map to concat to curr point and return
    #
    # if none then return empty array
    #
    # break if reach end point then return last point in array
    #
    # if after 
  end

  def run
    # go throught the height map to find the the different paths
    # recursively
    paths = get_paths(@height_map, @height_map[:start])

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


