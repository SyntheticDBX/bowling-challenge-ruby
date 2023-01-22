class Game
    class BowlingError < StandardError; end

    class GameFrame
        def initialize
            @rolls = 0
            @total = 0
            @closed = false
        end

        attr_accessor :rolls, :total, :closed

        def add_extra_points(pins)
            return if @closed

            @total += pins
            @rolls += 1
            @closed = true if @rolls == 3
        end
    end

    def initialize
        @frames = []
        @frame = GameFrame.new
        @current_frame = 0
    end

    def roll(pins)
        raise BowlingError if @frames[9]&.closed
        raise BowlingError if pins.negative? || (pins > 10)

        @frame.rolls += 1
        @frame.total += pins

        raise BowlingError if @frame.total > 10

        @frames[@current_frame - 1]&.add_extra_points(pins) if @current_frame.positive?
        @frames[@current_frame - 2]&.add_extra_points(pins) if @current_frame > 1

        return unless @frame.total == 10 || @frame.rolls == 2

        @frame.closed = true if @frame.total < 10
        @frames.push(@frame) if @current_frame < 10
        @frame = GameFrame.new
        @current_frame += 1
    end

    def score
        raise BowlingError unless @frames[9]&.closed

        @frames.map(&:total).sum
    end
end
