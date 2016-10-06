class TennisGame
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @players = {
      player_1 => Player.new(player_1),
      player_2 => Player.new(player_2)
    }
  end
  
  def scored_point player
    @players[player].scored_point
  end

  def points player
    @players[player].points
  end

  def score
    winner = winning_player
    return "#{winner} wins" if winner
    return 'deuce' if deuce?
    return "advantage #{player_with_advantage}" if player_with_advantage

    running_score
  end

  private

  def winning_player
    player_1 = @players[@player_1]
    player_2 = @players[@player_2]
    return @player_1 if player_1.beat?(player_2)
    return @player_2 if player_2.beat?(player_1)

    nil
  end

  def player_with_advantage
    return @player_1 if advantage?(@player_1, @player_2)
    return @player_2 if advantage?(@player_2, @player_1)
  end
  
  def advantage?(player, opponent)
    @players[player].points >= 3 and @players[opponent].points >= 3 and
      @players[player].lead_over(@players[opponent]) == 1
  end

  def deuce?
    @players[@player_1].points >= 3 and @players[@player_1].points >=3 and
      @players[@player_1].lead_over(@players[@player_2]) == 0
  end

  def running_score
    player_1 = @players[@player_1]
    player_2 = @players[@player_2]
    "#{player_1.points_description}-#{player_2.points_description}"
  end

  class Player
    attr_reader :points
    
    def initialize name
      @name = name
      @points = 0
    end

    def scored_point
      @points += 1
    end

    def beat? opponent
      points >= 4 and lead_over(opponent) >= 2
    end

    def lead_over opponent
      points - opponent.points
    end

    def points_description
     description = { 3 => '40', 2 => '30', 1 => '15', 0 => '0' }
     description[@points]
    end
  end
end
