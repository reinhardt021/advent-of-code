class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end
  
  def run
    # - / (dir)
      #- a (dir)
        #- e (dir)
          #- i (file, size=584)
        #- f (file, size=29116)
        #- g (file, size=2557)
        #- h.lst (file, size=62596)
      #- b.txt (file, size=14848514)
      #- c.dat (file, size=8504156)
      #- d (dir)
        #- j (file, size=4060174)
        #- d.log (file, size=8033020)
        #- d.ext (file, size=5626152)
        #- k (file, size=7214296)

    tree = {}
    # loop through each line to parse
    # build tree as you go
    # and build the totals as well as you go
    curr_node = nil
    index = 0 
    while index < @data.length
      line = @data[index]
      index += 1

      parts = line.split(' ')
      puts "line: #{parts.to_s}"
      if parts[0] == '$'
        # then find part 2 and see what to do next 
        command = parts[1]
        if command == 'cd'
          directory = parts[2]
          if directory == '..'
            # don't create new node
            # change curr_node to parent node
            parent_path = curr_node[:parent]
            parent_node = tree[parent_path]
            curr_node = parent_node
            # then just go to next loop
          else
            # check if node exists
            #   if exists then change to node
            #   else create a node in the tree
            puts "create node in tree: #{tree.to_s}"
            puts "curr_node: #{curr_node.to_s}"
            parent_path = curr_node ? curr_node[:full_path] : ''
            suffix = (directory == '/' ? '' : '/')
            full_path = parent_path + directory + suffix
            new_node = {
              parent: parent_path,
              full_path: full_path, 
              children: [],
            }
            tree[full_path] = new_node
            curr_node = new_node
          end
        end
        if command == 'ls'
          # next few lines will be within the 
          puts 'start storing after this'
        end
      end
      # parse the line
      #   $ means command being run
      #     cd = change levels
      #       x = lower
      #       .. = higher
      #       / = root
      #     ls = list files
      #      // stops at the lext $ row
      #      123 == file size
      #      dir == directory
      #
      # first just build the hash containing the directories 
      # and the file sizes
      # might be easier with a linked list?
      # definitely think linked list is the best way to do this
      # can be easier to store more information per node

    end
    puts "this is tree end: #{tree.to_s}"

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
main = Main.new('input_7a.txt')
results = main.run
puts "results: " + results.to_s
assertEquals(95437, results)

#main = Main.new('input_7b.txt')
#results = main.run
#puts "results: " + results.to_s

