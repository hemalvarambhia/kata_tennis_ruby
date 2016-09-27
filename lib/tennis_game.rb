class TennisGame
  def initialize players
    @points = players
  end
  
  def scored_point player
     @points[player] += 1
  end

  def score
    winner = winner_of('player 1', 'player 2')
    return "#{winner} wins" if winner
    return 'deuce' if deuce?('player 1', 'player 2')
    player_with_advantage = player_with_advantage('player 1', 'player 2')
    return "advantage #{player_with_advantage}" if player_with_advantage

    running_score('player 1', 'player 2')
  end

  private
  
  def winner_of(player, opposition)
    return player if won?(player, opposition)

    return opposition if won?(opposition, player)

    nil
  end

  def won?(winner, opposition)
    points(winner) >= 4 and lead_between(winner, opposition) >= 2
  end

  def player_with_advantage(player, opposition)
    return 'player 1' if advantage?('player 1', 'player 2')
    return 'player 2' if advantage?('player 2', 'player 1')
  end
  
  def advantage?(player, opposition)
    points(player) >= 3 and points(opposition) >= 3 and 
      lead_between(player, opposition) == 1
  end

  def deuce?(player, opposition)
    points(player) >= 3 and points(opposition) >= 3 and
      lead_between(player, opposition) == 0
  end

  def lead_between(player, opposition)
    points(player) - points(opposition)
  end

  def running_score(player, opposition)
    description = { 3 => 40, 2 => 30, 1 => 15, 0 => 0 }
    "#{description[points(player)]}-#{description[points(opposition)]}"
  end

  def points player
    @points[player]
  end
end
