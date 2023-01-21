require 'bowling_game'
require 'spec_helper'

describe Game do 
    it 'scores a gutter game' do
        game = Game.new
        20.times { game.roll(0) }
        expect(game.score).to eq(0)
    end

    it 'scores a game with all ones' do
        game = Game.new
        20.times { game.roll(1) }
        expect(game.score).to eq(20)
    end

    it 'scores a game with a spare' do
        game = Game.new
        game.roll(5)
        game.roll(5)
        game.roll(3)
        17.times { game.roll(0) }
        expect(game.score).to eq(16)
    end

    it 'scores a game with a strike' do
        game = Game.new
        game.roll(10)
        game.roll(3)
        game.roll(4)
        16.times { game.roll(0) }
        expect(game.score).to eq(24)
    end

    it 'scores a perfect game' do
        game = Game.new
        12.times { game.roll(10) }
        expect(game.score).to eq(300)
    end

    it 'scores a game with a spare in the last frame' do
        game = Game.new
        18.times { game.roll(0) }
        game.roll(5)
        game.roll(5)
        game.roll(3)
        expect(game.score).to eq(13)
    end

    it 'scores a game with a strike in the last frame' do
        game = Game.new
        18.times { game.roll(0) }
        game.roll(10)
        game.roll(3)
        game.roll(4)
        expect(game.score).to eq(17)
    end
end

describe Frame do
    it 'scores a gutter frame' do
        frame = Frame.new
        2.times { frame.roll(0) }
        expect(frame.score).to eq(0)
    end

    it 'scores a frame with all ones' do
        frame = Frame.new
        2.times { frame.roll(1) }
        expect(frame.score).to eq(2)
    end

    it 'scores a spare' do
        frame = Frame.new
        frame.roll(5)
        frame.roll(5)
        expect(frame.score).to eq(10)
    end

    it 'scores a strike' do
        frame = Frame.new
        frame.roll(10)
        expect(frame.score).to eq(10)
    end
end