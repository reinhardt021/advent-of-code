class Main
  S_MARK = 'S'
  E_MARK = 'E'

  def parse_map(lines)
    height_map = {
      start: nil,
      end: nil,
      elevations: [],
      row_count: lines.length,
      col_count: 0,
    }
    y_index = 0
    while y_index < lines.length
      line = lines[y_index]
      y_index += 1

      row = line.split("") 
      height_map[:col_count] = row.length if height_map[:col_count] < 1

      start_x = row.index(S_MARK)
      end_x = row.index(E_MARK)

      if start_x
        puts "found starting y[#{y_index}] x[#{start_x}]"
        height_map[:start] = "#{y_index}-#{start_x}"
      end

      if end_x
        puts "found ending y[#{y_index}] x[#{end_x}]"
        height_map[:end] = "#{y_index}-#{end_x}"
      end

      height_map[:elevations] << row
    end

    return height_map
  end

  def initialize(filename)
    file = File.open(filename)
    lines = file.read.split("\n")
    @height_map = parse_map(lines)
    puts "height map: #{@height_map.to_s}"
    #@height_map = lines.reduce(empty_map) do |map, line, index| 
      #row = line.split("") 
      #start_point = row.index(S_MARK)
      #end_point = row.index(E_MARK)

      #if start_point
        #puts "found starting y[#{index}] x[#{start_point}]"
      #end

      #if end_point
        #puts "found ending y[#{index}] x[#{end_point}]"
      #end

      #map[:start] = start_point
      #map[:end] = end_point
      #map[:elevations] << row

      #map
    #end
  end
  
  def get_shortest_path(paths)
    path_lengths = paths.map { |path| path.length }
    fewest_steps = path_lengths.sort.first

    return fewest_steps
  end

  def run
    # go throught the height map to find the 

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


