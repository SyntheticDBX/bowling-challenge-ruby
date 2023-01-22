require 'bowling_game'
require 'spec_helper'

describe Game do
    let(:game) { Game.new }
    
    it 'gutter game' do
        20.times { game.roll(0) }
        expect(game.score).to eq 0
    end
    
    it 'all ones' do
        20.times { game.roll(1) }
        expect(game.score).to eq 20
    end
    
    it 'one spare' do
        game.roll(5)
        game.roll(5)
        game.roll(3)
        17.times { game.roll(0) }
        expect(game.score).to eq 16
    end

    it 'one strike' do
        game.roll(10)
        game.roll(3)
        game.roll(4)
        16.times { game.roll(0) }
        expect(game.score).to eq 24
    end

    it 'perfect game' do
        12.times { game.roll(10) }
        expect(game.score).to eq 300
    end

    it 'invalid roll' do
        expect { game.roll(-1) }.to raise_error(Game::BowlingError)
    end

    it 'bonus roll after game is over' do
        20.times { game.roll(0) }
        expect { game.roll(1) }.to raise_error(Game::BowlingError)
    end
end

describe Game::GameFrame do
    let(:frame) { Game::GameFrame.new }
    
    it 'add extra points' do
        frame.add_extra_points(5)
        expect(frame.total).to eq 5
        expect(frame.rolls).to eq 1
        expect(frame.closed).to be false
        frame.add_extra_points(5)
        expect(frame.total).to eq 10
        expect(frame.rolls).to eq 2
        expect(frame.closed).to be false
        frame.add_extra_points(5)
        expect(frame.total).to eq 15
        expect(frame.rolls).to eq 3
        expect(frame.closed).to be true
    end
end