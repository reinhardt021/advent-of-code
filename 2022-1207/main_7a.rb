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
    tree = parse_data(@data)
    dirs = find_dirs_within(100000, tree, '/')
    puts "FINAL TREE: #{tree.to_s}"
    puts "final DIR within list: #{dirs.to_s}"
    sizes = dirs.map { |dir| dir[:size] }

    #total = dirs[:within].reduce do |sum, dir|
      #puts '>>> DIR SIZE' + dir[:size]
      #sum += dir[:size]

      #return sum
    #end

    return sizes.sum
  end

  def find_dirs_within(limit, tree, node_path)
    dirs = []
    #dirs = {
      #children: [],
      #within: [],
    #} 

    curr_node = tree[node_path]
    total_dirs = 0
    curr_node[:children_dirs].each do |dir_path|
      # so it does matter we calculate the dir sizes here 1st
      child_dirs = find_dirs_within(limit, tree, dir_path)
      # concat to dirs
      #dirs[:children] += child_dirs[:children]
      #dirs[:within] += child_dirs[:within]
      dirs += child_dirs

      # once the children calculated then can add to this node size
      child_node = tree[dir_path]
      total_dirs += child_node[:size]
    end

    # just don't calculate dir sizes off the returned array of just within
    # this just needs to be the immediate children
    #dir_sizes = dirs[:children].map { |dir| dir[:size] }
    #total_dirs = dir_sizes.sum
    total_files = curr_node[:children_files].sum
    total_size = total_files + total_dirs 

    curr_node[:size] = total_size
    tree[node_path] = curr_node
    if total_size <= limit
      #dirs[:within] << curr_node
      dirs << curr_node
    end
    #dirs[:children] << curr_node #store all children with data needed
    # no it should only be the immediate children right?

    return dirs
  end
  
  def parse_data(lines)
    # build tree as you go & build the totals as well as you go
    # can't build totals for directories
    # because don't know if later lines go into the child directories
    # will have to just traverse your tree after creation
    tree = {}
    curr_node = nil
    index = 0 
    store_children = nil #status: nil | 'store' | 'done'
    while index < lines.length
      line = lines[index]
      index += 1

      parts = line.split(' ')

      command = nil
      item = nil
      part1 = parts[0]
      #puts "part1[#{part1.to_s}].int?[#{part1.is_a?(Integer).to_s}]"
      if part1 == CMD
        command = parts[1]
        store_children = store_children == nil ? nil : DONE
      elsif part1 == DIR
        directory = parts[1]
        parent_path = curr_node ? curr_node[:full_path] : ''
        glue = (parent_path == '/' ? '' : '/' )
        full_path = parent_path + glue + directory
        item = {
          type: DIR,
          full_path: full_path, 
        }
      else 
        parent_path = curr_node ? curr_node[:full_path] : ''
        file = parts[1]
        glue = (parent_path == '/' ? '' : '/' )
        full_path = parent_path + glue + file
        item = {
          type: FILE,
          full_path: full_path, 
          size: part1.to_i
        }
      end

      if command == CD
        #puts "TREE: #{tree.to_s}"
        #puts "curr_node: #{curr_node.to_s}"
        #puts "    LINE: #{parts.to_s}"
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
            #type: DIR,
            parent: parent_path,
            full_path: full_path, 
            size: 0,
            children_dirs: [],
            children_files: [],
          }
          tree[full_path] = new_node
          curr_node = new_node
        end
        #puts "TREE: #{tree.to_s}"
        #puts "curr_node: #{curr_node.to_s}]\n\n"
      end

      if command == LS
        # next few lines will be within the 
        #puts 'start storing after this'
        store_children = STORE
      end


      if store_children == STORE && item != nil
        if item[:type] == DIR
          curr_node[:children_dirs] << item[:full_path]
        else
          curr_node[:children_files] << item[:size]
        end
      end

    end
    #puts "FINAL TREE: #{tree.to_s}"

    return tree
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

