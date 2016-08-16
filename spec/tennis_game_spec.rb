describe 'A game of tennis' do
  before :each do
    @points = { 'player 1' => 0, 'player 2' => 3 }
  end

  def points player
    @points[player]
  end

  it "returns player 1's points" do
    expect(points 'player 1').to eq 0
  end

  it "returns player 2's points" do
    expect(points 'player 2').to eq 3
  end

  context 'when player 1 has 4 points' do
    before :each do
      @points = { 'player 1' => 4 }
    end

    context 'and leads the opponent by 2 points' do
      before :each do
        @points = @points.merge('player 2' => 2)
      end

      it 'confirms player 1 as the winner' do
        points_difference = @points['player 1'] - @points['player 2']
        if @points['player 1'] == 4 and points_difference == 2
          winner = 'player 1'
        end

        expect(winner).to eq 'player 1'
      end
    end
  
    context 'and leads the opponent by > 2 points' do
      it 'confirms player 1 as the winner'
    end
  end

  context 'when player 1 has > 4 points' do
    context 'and leads the opponent by > 2 points' do
      it 'confirms player 1 as the winner'
    end
  end
end