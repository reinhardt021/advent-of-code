class Main
  CMD = '$'
  CD = 'cd'
  UP = '..'
  LS = 'ls'
  DIR = 'dir'
  FILE = 'file'
  STORE = 'store'
  DONE = 'done'
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end
  
  def run
    tree = {}
    # build tree as you go & build the totals as well as you go
    curr_node = nil
    index = 0 
    store_children = nil #status: nil | 'store' | 'done'
    while index < @data.length
      line = @data[index]
      index += 1

      parts = line.split(' ')

      command = nil
      item = nil
      part1 = parts[0]
      puts "part1[#{part1.to_s}].int?[#{part1.is_a?(Integer).to_s}]"
      if part1 == CMD
        command = parts[1]
        store_children = store_children == nil ? nil : DONE
      elsif part1 == DIR
        directory = parts[1]
        parent_path = curr_node ? curr_node[:full_path] : ''
        #suffix = (directory == '/' ? '' : '/')
        #full_path = parent_path + directory # + suffix
        glue = (parent_path == '/' ? '' : '/' )
        full_path = parent_path + glue + directory
        item = {
          type: DIR,
          full_path: full_path, 
        }
        # TODO: store item in children
      else #(part1.is_a?(Integer))
        parent_path = curr_node ? curr_node[:full_path] : ''
        file = parts[1]
        glue = (parent_path == '/' ? '' : '/' )
        full_path = parent_path + glue + file
        item = {
          type: FILE,
          full_path: full_path, 
          size: part1.to_i
        }
        # TODO: store item in children
      end

      if command == CD
        puts "TREE: #{tree.to_s}"
        puts "curr_node: #{curr_node.to_s}"
        puts "    LINE: #{parts.to_s}"
        directory = parts[2]
        if directory == UP
          # don't create new node
          # change curr_node to parent node
          parent_path = curr_node[:parent]
          parent_node = tree[parent_path]
          curr_node = parent_node
          # then just go to next loop
        else
          # check if node exists 
          #   if exists then change to node - stretch?
          #   else create a node in the tree
          parent_path = curr_node ? curr_node[:full_path] : ''
          #suffix = (directory == '/' ? '' : '/')
          glue = (directory == '/' || parent_path == '/') ? '' : '/'
          full_path = parent_path + glue + directory #+ suffix
          new_node = {
            type: 'dir',
            parent: parent_path,
            full_path: full_path, 
            children: [],
            size: 0
          }
          tree[full_path] = new_node
          curr_node = new_node
        end
        puts "TREE: #{tree.to_s}"
        puts "curr_node: #{curr_node.to_s}]\n\n"
      end

      if command == LS
        # next few lines will be within the 
        puts 'start storing after this'
        store_children = STORE
      end


      if store_children == STORE
        curr_node[:children] << item if item != nil
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
    puts "FINAL TREE: #{tree.to_s}"

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

