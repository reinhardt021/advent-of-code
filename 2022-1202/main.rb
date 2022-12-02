class Main
  ROCK = "ROCK"
  PAPER = "PAPER"
  SCISSORS = "SCISSORS"
  THEM = {
    A: ROCK,
    B: PAPER,
    C: SCISSORS
  }
  MINE = {
    X: ROCK,
    Y: PAPER,
    Z: SCISSORS
  }
  POINTS = {
    ROCK.to_sym => 1,
    PAPER.to_sym => 2,
    SCISSORS.to_sym => 3,
  }
  OUTCOME = {
    WIN: 6,
    LOSE: 0,
    DRAW: 3,
  }

  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run
    index = 0
    while index < @data.count
      round = @data[index]
      index +=1

      choices = round.split(" ")
      them_enc = choices[0]
      me_enc = choices[1]
      them = THEM[them_enc.to_sym]
      me = MINE[me_enc.to_sym]
      puts "choices: them[#{them}] me[#{me}]"
    end
  end

end

main = Main.new("input2a.txt")
result = main.run
puts "result: ", result
