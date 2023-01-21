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