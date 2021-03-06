require 'tennis_game'
describe 'A game of tennis' do
  let(:game) { TennisGame.new('player 1', 'player 2') }

  describe 'players scoring points' do
    it 'scores points for player 1' do
      game.scored_point 'player 1'

      expect(game.points('player 1')).to eq 1
    end

    it 'scores points for player 2' do
      2.times { game.scored_point 'player 2' }

      expect(game.points('player 2')).to eq 2
    end
  end

  describe 'winning' do
    context 'when player 1 has 4 points' do
      before :each do
        4.times { game.scored_point 'player 1' }
      end

      context 'and leads the opponent by 2 points' do
        before :each do
          2.times { game.scored_point 'player 2' }
        end

        it 'declares player 1 as the winner' do
          expect(game.score).to eq 'player 1 wins'
        end
      end
  
      context 'and leads the opponent by > 2 points' do
        before :each do 
          game.scored_point 'player 2'
        end

        it 'declares player 1 as the winner' do
          expect(game.score).to eq 'player 1 wins'
        end
      end
    end

    context 'when player 1 has > 4 points' do
      context 'and leads the opponent by > 2 points' do
        before :each do
          5.times { game.scored_point 'player 1' }
          game.scored_point 'player 2'
        end
        
        it 'declares player 1 as the winner' do
          expect(game.score).to eq 'player 1 wins'
        end
      end
    end

    context 'when player 2 has 4 points' do
      before(:each) do
        4.times { game.scored_point 'player 2' } 
      end

      context 'and leads the opponent by 2 points' do
        before :each do
          2.times { game.scored_point 'player 1' }
        end

        it 'declares player 2 as the winner' do
          expect(game.score).to eq 'player 2 wins'
        end
      end

      context 'and leads the opponent by > 2 points' do
        before(:each) do  
          game.scored_point 'player 1'
        end

        it 'declares player 2 as the winner' do
          expect(game.score).to eq 'player 2 wins'
        end
      end
    end

    context 'when player 2 has > 4 points' do
      context 'and leads the opponent by > 2 points' do
        before :each do
          5.times { game.scored_point 'player 2' }
          game.scored_point 'player 1'
        end

        it 'declares player 2 as the winner' do
          expect(game.score).to eq 'player 2 wins'
        end
      end
    end
  end

  describe 'running score' do
    context 'when player 1 has 3 points and player 2 has 0 points' do
      it 'is 40-0' do
        3.times { game.scored_point 'player 1' } 

        expect(game.score).to eq '40-0'
      end
    end

    context 'when player 1 has 0 points and player 2 has 3 points' do
      it 'is 0-40' do
        3.times { game.scored_point 'player 2' }

        expect(game.score).to eq '0-40'
      end
    end

    context 'when players 1 and 2 have 2 points each' do
      it 'is 30-30' do
        2.times { game.scored_point 'player 1' }
        2.times { game.scored_point 'player 2' }

        expect(game.score).to eq '30-30' 
      end
    end

    context 'when both players have 1 point each' do
      it 'is 15-15' do
        game.scored_point 'player 1'
        game.scored_point 'player 2'

        expect(game.score).to eq '15-15'
      end
    end
  end

  describe 'deuce' do
    describe 'when both players have 3 points' do
      it 'is deuce' do
        3.times { game.scored_point 'player 1' }
        3.times { game.scored_point 'player 2' }

        expect(game.score).to eq 'deuce'
      end
    end

    describe 'when both players have > 3 points & there is no lead' do
      it 'is deuce' do
        4.times { game.scored_point 'player 1' }
        4.times { game.scored_point 'player 2' }

        expect(game.score).to eq 'deuce'
      end
    end
  end

  describe 'advantage' do
    describe 'when player 2 has 3 points' do
      describe 'and player 1 is leading by 1 point' do
        it 'declares that player 1 has advantage' do
          4.times { game.scored_point 'player 1' }
          3.times { game.scored_point 'player 2' }

          expect(game.score).to eq 'advantage player 1'
        end
      end
    end

    describe 'when player 1 has 3 points' do
      describe 'and player 2 is leading by 1 point' do
        it 'declares that player 1 has advantage' do
          4.times { game.scored_point 'player 2' }
          3.times { game.scored_point 'player 1' }

          expect(game.score).to eq 'advantage player 2'
        end
      end
    end

    describe 'when both players have > 3 points' do
      describe 'and player 1 is leading by 1 point' do
        it 'declares that player 1 has advantage' do
          5.times { game.scored_point 'player 1' }
          4.times { game.scored_point 'player 2' }

          expect(game.score).to eq 'advantage player 1'
        end
      end

      describe 'and player 2 is leading by 1 point' do
        it 'declares that player 2 has advantage' do
          5.times { game.scored_point 'player 2' }
          4.times { game.scored_point 'player 1' }

          expect(game.score).to eq 'advantage player 2'
        end
      end
    end   
  end
end
