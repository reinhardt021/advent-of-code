class Main
  def isNumber(item)
    item.to_i.to_s == item
  end

  def parse_map(lines)
    calibration_data = {
      #0: {
        #first: '1',
        #last: '1',
      #}
      #1: { ... }
      #2: { ... }
    }


    y = 0
    while y < lines.length
      line = lines[y]

      row = line.split("")

      # get filter for digits array
      digits = row.select { |item| isNumber(item) }

      # get first item
      # get last item
      calibration_data[y.to_s.to_sym] = {
        first: digits.first,
        last: digits.last,
      }

      y += 1
    end

    calibration_data
  end

  def initialize(filename)
    file = File.open(filename)
    lines = file.read.split("\n")
    @data = parse_map(lines)
  end


  def run 
    sum = 0
    hash_keys = @data.keys

    hash_keys.each do |curr_key|
      curr_row = @data[curr_key]
      first_num = curr_row[:first]
      last_num = curr_row[:last]
      combined_num = first_num + last_num
      #puts combined_num
      sum += combined_num.to_i
    end

    sum
  end
end

def assertEquals(expected, actual)
  if expected == actual
    puts "PASS: exp[#{expected}] == act[#{actual}]"
  else
    puts "FAIL: exp[#{expected}] != act[#{actual}]"
  end
end

aoc_day = '01'
files = {
  #'a' => 142, 
  #'b' => 55017, # no expected result yet //=> 55017
  'c' => 281,
}
files.keys.each do |file|
  expected_result = files[file]
  filename = "input_#{aoc_day}#{file}.txt"
  puts "results: " + (results = Main.new(filename).run).to_s
  assertEquals(expected_result, results) if expected_result
end

