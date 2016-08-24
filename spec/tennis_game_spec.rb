describe 'A game of tennis' do
  before :each do
    @points = { 'player 1' => 0, 'player 2' => 3 }
  end

  def points player
    @points[player]
  end

  def score
    winner = find_winner
    return winner if winner

    description = { 3 => 40, 2 => 30, 1 => 15, 0 => 0 }
    "#{description[points('player 1')]}-#{description[points('player 2')]}"
  end

  def find_winner
    points_difference = points('player 1') - points('player 2')
    if points('player 1') >= 4 and points_difference >= 2
      return 'player 1'
    end

    points_difference = points('player 2') - points('player 1')
    if points('player 2') == 4 and points_difference >= 2
      return 'player 2'
    end

    nil
  end

  it "returns player 1's points" do
    expect(points 'player 1').to eq 0
  end

  it "returns player 2's points" do
    expect(points 'player 2').to eq 3
  end

  describe 'winning' do
    context 'when player 1 has 4 points' do
      before :each do
        @points = { 'player 1' => 4 }
      end

      context 'and leads the opponent by 2 points' do
        before :each do
          @points = @points.merge('player 2' => 2)
        end

        it 'confirms player 1 as the winner' do
          winner = score

          expect(winner).to eq 'player 1'
        end
      end
  
      context 'and leads the opponent by > 2 points' do
        before :each do 
          @points = @points.merge('player 2' => 1)
        end

        it 'confirms player 1 as the winner' do
          winner = score

          expect(winner).to eq 'player 1'
        end
      end
    end

    context 'when player 1 has > 4 points' do
      before :each do
        @points = { 'player 1' => 5 }
      end

      context 'and leads the opponent by > 2 points' do
        before :each do
          @points = @points.merge('player 2' => 1)
        end

        it 'confirms player 1 as the winner' do
          winner = score

          expect(winner).to eq 'player 1'
        end
      end
    end

    context 'when player 2 has 4 points' do
      context 'and leads the opponent by 2 points' do
        it 'declares player 2 as the winner' do
          @points = { 'player 1' => 2, 'player 2' => 4 }
          winner = score

          expect(winner).to eq 'player 2'
        end
      end

      context 'and leads the opponent by > 2 points' do
        it 'declares player 2 as the winner' do
          @points = { 'player 1' => 0, 'player 2' => 4 } 

          winner = score

          expect(winner).to eq 'player 2'
        end
      end
    end
  end

  describe 'running score' do
    context 'when player 1 has 3 points and player 2 has 0 points' do
      it 'is 40-0' do
        @points = {'player 1' => 3, 'player 2' => 0 }

        running_score = score

        expect(running_score).to eq '40-0'
      end
    end

    context 'when player 1 has 0 points and player 2 has 3 points' do
      it 'is 0-40' do
        @points = { 'player 1' => 0, 'player 2' => 3 }

        running_score = score

        expect(running_score).to eq '0-40'
      end
    end

    context 'when players 1 and 2 have 2 points each' do
      it 'is 30-30' do
        @points = { 'player 1' => 2, 'player 2' => 2 }

        running_score = score

        expect(running_score).to eq '30-30'
      end
    end

    context 'when both players have 1 point each' do
      it 'is 15-15' do
        @points = { 'player 1' => 1, 'player 2' => 1 }

        running_score = score

        expect(running_score).to eq '15-15'
      end
    end
  end
end