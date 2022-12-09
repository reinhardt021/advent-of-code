class Main
  def initialize(filename)
    file = File.open(filename)
    data = file.read.split("\n")
    @map_data = parse_map_data(data)
    #puts "map_data: #{@map_data}"
  end

  def parse_map_data(lines)
    return lines.map { |line| line.split('') }
  end
  
  def get_tree_key(x, y)
    return "#{y}-#{x}"
  end

  def is_visible_left(trees, x, y, height)
    next_y = y
    next_x = x - 1
    next_key = get_tree_key(next_x, next_y)
    next_tree = trees[next_key]
    next_height = next_tree[:height]

    if height <= next_height
      return 1
    end

    # TODO: check that you haven't hit the edge
    if next_tree[:visible_left] == 0
      return 1
    else
      return 1 + is_visible_left(trees, next_x, next_y, height)
    end
    # if taller tree 
    # then don't just count how much is visible from neighbor 
    # also check down the line

    # definitely did something wrong here
    # because I forgot to check agai
    # like the false positive I had before
    # it should stop just because it is 
  end

  def is_visible_top(trees, x, y, height)
    next_y = y - 1
    next_x = x 
    next_key = get_tree_key(next_x, next_y)
    next_tree = trees[next_key]
    next_height = next_tree[:height]

    if height <= next_height
      return 1
    end

    # check that you haven't hit the edge
    if next_tree[:visible_top] == 0
      return 1
    else
      return 1 + is_visible_top(trees, next_x, next_y, height)
    end
  end

  def is_visible_right(trees, tree, height)
    next_y = tree[:y]
    next_x = tree[:x] + 1
    next_key = get_tree_key(next_x, next_y)
    next_tree = trees[next_key]
    next_height = next_tree[:height]

    if height <= next_height
      return 1
    end

    # check that you haven't hit the edge
    if next_tree[:visible_right] == 0
      return 1
    else
      return 1 + is_visible_right(trees, next_tree, height)
    end
  end

  def is_visible_bottom(trees, tree, height)
    next_y = tree[:y] + 1
    next_x = tree[:x]
    next_key = get_tree_key(next_x, next_y)
    next_tree = trees[next_key]
    next_height = next_tree[:height]

    if height <= next_height
      return 1
    end

    # check that you haven't hit the edge
    if next_tree[:visible_bottom] == 0
      return 1
    else
      return 1 + is_visible_bottom(trees, next_tree, height)
    end
  end

  def create_trees(map_data)
    trees = {}
    row_count = map_data.length
    col_count = nil
    y_index = 0
    while y_index < row_count
      row = map_data[y_index]
      col_count = row.length
      #puts "row: #{row}"

      x_index = 0
      while x_index < col_count
        tree_height = row[x_index].to_i
        tree = get_tree_key(x_index, y_index)

        # edge trees see no trees
        visible_left = x_index == 0 ? 0 : is_visible_left(trees, x_index, y_index, tree_height)
        visible_top = y_index == 0 ? 0 : is_visible_top(trees, x_index, y_index, tree_height)

        visible_right = (x_index == (col_count - 1)) ? 0 : nil
        visible_bottom = (y_index == (row_count - 1)) ? 0 : nil
        trees[tree] = {
          x: x_index,
          y: y_index,
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
    trees.keys.reverse.reduce(0) do |max, tree_key|
      tree = trees[tree_key]

      if tree[:visible_bottom] == nil
        tree[:visible_bottom] = is_visible_bottom(trees, tree, tree[:height])
      end
      if tree[:visible_right] == nil
        tree[:visible_right] = is_visible_right(trees, tree, tree[:height])
      end

      # calculate the score per tree
      score = tree[:visible_left] * tree[:visible_top] * tree[:visible_right] * tree[:visible_bottom]

      if max < score
        max = score
      end
      tree[:score] = score
      #puts "{#{tree_key}}[#{h}] (#{score}) <[#{vl}] ^[#{vt}] >[#{vr}] _[#{vb}] count[#{count}]"

      trees[tree_key] = tree

      #visible = nil
      #if tree[:visible_left]
        #visible = '<'
        #count += 1
      #elsif tree[:visible_top]
        #visible = '^'
        #count += 1
      #elsif tree[:visible_right]
        #visible = '>'
        #count += 1
      #elsif tree[:visible_bottom]
        #visible = '_'
        #count += 1
      #end

      h = tree[:height]
      vl = tree[:visible_left]
      vt = tree[:visible_top]
      vr = tree[:visible_right]
      vb = tree[:visible_bottom]
      puts "{#{tree_key}} H[#{h}] <[#{vl}] ^[#{vt}] >[#{vr}] _[#{vb}] score[#{score}] max[#{max}]"
      
      max
    end
  end

  def run 
    output = create_trees(@map_data)
    trees = output[:trees]
    row_count = output[:row_count]
    col_count = output[:col_count]
    puts "row_count: " + row_count.to_s
    puts "col_count: " + col_count.to_s
    #puts "trees: #{trees.keys.reverse.to_s}"
    result = get_visible_count(trees, row_count, col_count)
    # highest possible score
    # must be when all four factors are the highest they can be
    # is that not the middle?
    # ex: 2*2*2*2 = 16
    # 1*2*3*2 = 12
    # yeah looks like it must be that
    # so use the row_count and the col count to figure that out
    #horizontal = (row_count / 2).floor
    #vertical = (col_count / 2).floor 
    #max = horizontal * horizontal * vertical * vertical

    #return max
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
assertEquals(8, results)

#    01234
#    -----
# 0| 30373
# 1| 255x2
# 2| 65x32
# 3| 3x5x9
# 4| 35390
# EXPECTED RESULTS


main = Main.new('input_8b.txt')
results = main.run
puts "results: " + results.to_s

# not 120 too low
# That's not the right answer; your answer is too low. If you're stuck, make sure you're using the full input data; there are also some general tips on the about page, or you can ask for hints on the subreddit. Please wait one minute before trying again. (You guessed 120.)
#
# not 5764801 too high
#
# ANSWER = 345168
