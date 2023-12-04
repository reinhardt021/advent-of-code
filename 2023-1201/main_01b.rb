class Main
  DIGITS = {
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
  }
  
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

    line_digits = {
      #9: "6",
      #11: "3",
      #13: "8",
    }


    y = 0
    while y < lines.length
      line = lines[y]

      DIGITS.keys.each do ||
        line.gsub()
      end

      calibration_data[y.to_s.to_sym] = {
        first: nil,
        last: nil,
      }

      first_posn = nil
      last_posn = nil

      DIGITS.each do |digit|
        # find first
        digit_posn = line.index(digit)
        if digit_posn != nil
          puts "first=[" + digit_posn.to_s + "]=" + digit
          if first_posn == nil || digit_posn < first_posn
            first_posn = digit_posn
            calibration_data[y.to_s.to_sym][:first] = digit
          end
        end

        # find last
        # flip the string?
        digit_posn = line.index(digit, -1 * digit.length)
        if digit_posn != nil
          puts "last=[" + digit_posn.to_s + "]=" + digit
          if last_posn == nil || last_posn < digit_posn
            last_posn = digit_posn
            calibration_data[y.to_s.to_sym][:last] = digit
          end
        end

      end

      puts calibration_data[y.to_s.to_sym]

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
  #'b' => nil, # no expected result yet
  'c' => 281,
}
files.keys.each do |file|
  expected_result = files[file]
  filename = "input_#{aoc_day}#{file}.txt"
  puts "results: " + (results = Main.new(filename).run).to_s
  assertEquals(expected_result, results) if expected_result
end

