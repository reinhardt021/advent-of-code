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
  WIN = "WIN"
  LOSE = "LOSE"
  DRAW = "DRAW"
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
      my_points = 0

      choices = round.split(" ")
      them_enc = choices[0]
      me_enc = choices[1]
      them = THEM[them_enc.to_sym]
      me = MINE[me_enc.to_sym]

      my_points = POINTS[me.to_sym]
      puts "choices: them[#{them}] me[#{me}+#{my_points}]"
      #puts "mypoints = " + my_points.to_s

      # TODO: check who wins
      outcome = get_outcome(them, me)
      puts "outcome: #{outcome}"
      # then add points

      my_total += my_points
    end
  end

  def get_outcome(their_choice, my_choice)
    if (their_choice == my_choice)
      return DRAW
    end

    # rock < paper
    # paper < scissors
    # scissors < rock
    rock_to_paper = (their_choice == ROCK && my_choice == PAPER)
    paper_to_scissors = (their_choice == PAPER && my_choice == SCISSORS)
    scissors_to_rock = (their_choice == SCISSORS && my_choice == ROCK)
    if (rock_to_paper || paper_to_scissors || scissors_to_rock) 
      return WIN
    else
      return LOSE
    end
  end
end

main = Main.new("input2a.txt")
result = main.run
puts "result: ", result
