# Bowling game logic
class Frame
    def initialize
        @rolls = []
    end

    def roll(pins)
        @rolls.push(pins)
    end
    
    def score
        @rolls.reduce(:+)
    end

    def is_strike?
        @rolls[0] == 10
    end

    def is_spare?
        @rolls[0] + @rolls[1] == 10
    end
end

class Game
    def initialize
        @frames = []
    end

    def roll(pins)
        if @frames.length == 0
            @frames.push(Frame.new)
        end
        if @frames.last.is_strike? || @frames.last.roll.length == 2
            @frames.push(Frame.new)
        end
        @frames.last.roll(pins)
    end

    def score
        @frames.each_with_index.reduce(0) do |score, (frame, index)|
            score += frame.score
            if frame.is_strike?
                score += @frames[index + 1].roll[0]
                score += @frames[index + 1].roll[1]
                if @frames[index + 1].is_strike?
                    score += @frames[index + 2].roll[0]
                end
            elsif frame.is_spare?
                score += @frames[index + 1].roll[0]
            end
            score
        end
    end
end

