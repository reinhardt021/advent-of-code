class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run
    result = nil
    index = 0
    while index < @data.count
      item = @data[index]
      # TODO: plan what to do for each ITEM

      index += 1
    end

    return result
  end
end

main = Main.new("input_3a.txt")
results = main.run
puts "results: ", results
