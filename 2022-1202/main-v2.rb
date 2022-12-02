class Main
  ROCK = "ROCK"
  PAPER = "PAPER"
  SCISSORS = "SCISSORS"
  THEM = {
    A: ROCK,
    B: PAPER,
    C: SCISSORS
  }
  POINTS = {
    ROCK.to_sym => 1,
    PAPER.to_sym => 2,
    SCISSORS.to_sym => 3,
  }
  WIN_BY = { #them >> you
    ROCK.to_sym => PAPER,
    PAPER.to_sym => SCISSORS,
    SCISSORS.to_sym => ROCK,
  }
  LOSE_BY = { #them >> you
    ROCK.to_sym => SCISSORS,
    SCISSORS.to_sym => PAPER,
    PAPER.to_sym => ROCK,
  }
  WIN = "WIN"
  LOSE = "LOSE"
  DRAW = "DRAW"
  OUTCOME = {
    X: LOSE,
    Y: DRAW,
    Z: WIN
  }
  OUTCOME_POINTS = {
    WIN.to_sym => 6,
    LOSE.to_sym => 0,
    DRAW.to_sym => 3,
  }

  def initialize(filename)
    file = File.open(filename)
    @data = file.read.split("\n")
  end

  def run
    my_total = 0
    index = 0
    while index < @data.count
      round = @data[index]
      index +=1
      round_points = 0

      codes = round.split(" ")
      them_enc = codes[0]
      outcome_enc = codes[1]
      them = THEM[them_enc.to_sym]
      outcome = OUTCOME[outcome_enc.to_sym]
      outcome_points = OUTCOME_POINTS[outcome.to_sym]
      round_points += outcome_points
      #puts "> them[#{them}] me[?+?] >> #{outcome}[#{outcome_points}]"

      me = get_my_choice(them, outcome)
      my_points = POINTS[me.to_sym]
      round_points += my_points

      puts "> them[#{them}] me[#{me}+#{my_points}] >> #{outcome}[#{outcome_points}]"

      my_total += round_points
    end

    #puts "total = #{my_total.to_s}"
    my_total
  end

  def get_my_choice(their_choice, outcome)
    if (outcome == DRAW)
      return their_choice
    end

    if outcome == WIN
      return WIN_BY[their_choice.to_sym]
    else
      return LOSE_BY[their_choice.to_sym]
    end
  end

end

main = Main.new("input2a.txt")
result = main.run
puts "result: ", result

main = Main.new("input2b.txt")
result = main.run
puts "result: ", result

