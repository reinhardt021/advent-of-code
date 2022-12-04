class Main
  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run 
    fully_contained_count = 0
    index = 0
    while index < @data.length
      item = @data[index]
      index += 1
    
      parts = item.split(',')

      result = do_ranges_overlap(parts[0], parts[1])
      #puts "    do_ranges_overlap= #{result}"
      if result
        fully_contained_count += 1
      end
    end

    return fully_contained_count
  end

  def do_ranges_overlap(range1, range2)
    min_max1 = range1.split('-').map { |x| x.to_i }
    min_max2 = range2.split('-').map { |x| x.to_i }

    nums1 = (min_max1[0]..min_max1[1]).map { |x| x }
    nums2 = (min_max2[0]..min_max2[1]).map { |x| x }
    intersect = nums1 & nums2
    #puts "#{nums1.to_s} && #{nums2.to_s} >> #{intersect.to_s} len=#{intersect.length}"
    return intersect.length > 0
  end

end

def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end

main = Main.new('input_4a.txt')
results = main.run
puts "results: " + results.to_s
assertEquals(4, results)

main = Main.new('input_4b.txt')
results = main.run
puts "results: " + results.to_s
#assertEquals(582, results)
