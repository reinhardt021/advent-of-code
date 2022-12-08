class Main
  def initialize(filename)
    file = File.open(filename)
    data = file.read.split("\n")
    @map_data = parse_map_data(data)
    puts "map_data: #{@map_data}"
  end

  # is this needed? data is already an array of arrays
  # can't do a check down unless we have all the pieces
  def parse_map_data(lines)
    return lines.map { |line| line.split('') }
  end
  
  def run 
    trees = {}
    row_count = @map_data.length

    y_index = 0
    while y_index < row_count
      row = @map_data[y_index]
      col_count = row.length

      x_index = 0
      while x_index < col_count
        tree_height = row[x_index].to_i
        tree = "#{y_index}-#{x_index}"

        # can't do this yet
        visible_left = x_index == 0 ? true : is_visible_left(tree)
        visible_top = y_index == 0 ? true : is_visible_top(tree)
        visible_right = x_index == (col_count - 1) ? true : is_visible_top(tree)
        visible_bottom = y_index == (row_count - 1) ? true : is_visible_top(tree)
        trees[tree] = {
          height: tree_height,
          visible_left: visible_left,
          visible_top: visible_top,
          visible_right: visible_right,
          visible_bottom: visible_bottom,
        }
        
        x_index += 1
      end

      y_index += 1
    end

    puts "trees: " + trees.to_s
    # as you go through
    # ex 1-1 you can check if to the left it is larger
    # if larger then see if neighbor has visibility
    # if not then 
    # might be ggood to store an object with coordinate keys
    #   and visible-left
    #   visible-top
    #   visible-right
    #   visible-down
    # this way you can leverage those then don't have to loop through all the columns all the time
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
main = Main.new('input_8a.txt')
results = main.run
puts "results: " + results.to_s
assertEquals(21, results)

#main = Main.new('input_8b.txt')
#results = main.run
#puts "results: " + results.to_s

