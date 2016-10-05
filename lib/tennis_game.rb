class TennisGame
  def initialize players
    @points = players
    @player_1 = 'player 1'
    @player_2 = 'player 2'
  end
  
  def scored_point player
     @points[player] += 1
  end

  def points player
    @points[player]
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
    return @player_1 if won?(@player_1, @player_2)

    return @player_2 if won?(@player_2, @player_1)

    nil
  end

  def won?(winner, opposition)
    points(winner) >= 4 and lead_between(winner, opposition) >= 2
  end

  def player_with_advantage
    return @player_1 if advantage?(@player_1, @player_2)
    return @player_2 if advantage?(@player_2, @player_1)
  end
  
  def advantage?(player, opposition)
    points(player) >= 3 and points(opposition) >= 3 and 
      lead_between(player, opposition) == 1
  end

  def deuce?
    points(@player_1) >= 3 and points(@player_2) >= 3 and
      lead_between(@player_1, @player_2) == 0
  end

  def lead_between(player, opposition)
    points(player) - points(opposition)
  end

  def running_score
    description = { 3 => 40, 2 => 30, 1 => 15, 0 => 0 }
    "#{description[points(@player_1)]}-#{description[points(@player_2)]}"
  end
end
