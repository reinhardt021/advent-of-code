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
  
  def get_tree_key(x, y)
    return "#{y}-#{x}"
  end

  def get_x_y(tree_key)
    coordinates = tree_key.split('-')
    y = coordinates[0]
    x = coordinates[1]

    return {
      x: x,
      y: y,
    }
  end

  def is_visible_left(trees, x, y, height)
    neighbor_y = y
    neighbor_x = x - 1
    neighbor = get_tree_key(neighbor_x, neighbor_y)
    tree_neighbor = trees[neighbor]

    if tree_neighbor[:height] < height
      return tree_neighbor[:visible_left]
    else
      return false
    end
  end

  def is_visible_top(trees, x, y, height)
    neighbor_y = y - 1
    neighbor_x = x 
    neighbor = get_tree_key(neighbor_x, neighbor_y)
    tree_neighbor = trees[neighbor]

    if tree_neighbor[:height] < height
      return tree_neighbor[:visible_top]
    else
      return false
    end
  end

  def is_visible_right()
  end

  def is_visible_bottom()
  end

  def create_trees(map_data)
    trees = {}
    row_count = map_data.length
    col_count = nil
    y_index = 0
    while y_index < row_count
      row = map_data[y_index]
      col_count = row.length

      x_index = 0
      while x_index < col_count
        tree_height = row[x_index].to_i
        tree = get_tree_key(x_index, y_index)
        #puts "tree: #{tree}"

        visible_left = x_index == 0 ? true : is_visible_left(trees, x_index, y_index, tree_height)
        visible_top = y_index == 0 ? true : is_visible_top(trees, x_index, y_index, tree_height)

        # can't do this yet
        # will have to check these later
        # can do these recursively if needed
        visible_right = (x_index == (col_count - 1))
        visible_bottom = (y_index == (row_count - 1))
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

    return {
      trees: trees,
      row_count: row_count,
      col_count: col_count,
    }
  end

  def get_visible_count(trees, row_count, col_count)
    # loop through the trees one more time for the count
    trees.keys.reverse.reduce(0) do |count, tree_key|

      puts "count[#{count}]"

      tree = trees[tree_key]
      puts "tree[#{tree_key}] #{tree}"

      x_y = get_x_y(tree_key)
      node_x = x_y[:x]
      node_y = x_y[:y]

      if tree[:visible_bottom] == false
        # check if visible_bottom if not bottom row
        tree[:visible_bottom] = is_visible_bottom(trees, node_x, node_y, tree[:height])
      end
      if tree[:visible_right] == false
        tree[:visible_right] = is_visible_right(trees, node_x, node_y, tree[:height])
      end



      if tree[:visible_left]
        count += 1
        #puts "count[#{count}]"
        count
        next
      elsif tree[:visible_top]
        count += 1
        #puts "count[#{count}]"
        next
      else
        # calculate visible right count
        # could do this part in reverse
        # that way we can do the checks and update the tree 
        # much like the first loop 
        # so that we can get a good count as we go
        # and no need to double count
      end
      #elsif is_visible_right(trees, tree)
        #count += 1
      #elsif is_visible_bottom(trees, tree)
        #count += 1
      #end
      
      count
    end
  end

  def run 
    output = create_trees(@map_data)
    tree = output[:trees]
    row_count = output[:row_count]
    col_count = output[:col_count]
    puts "trees: " + trees.to_s
    puts "trees: #{trees.keys.reverse.to_s}"
    result = get_visible_count(trees, row_count, col_count)

    return result
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

