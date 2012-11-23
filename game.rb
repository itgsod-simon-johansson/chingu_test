require 'chingu'

class Game < Chingu::Window

	#constructor
	def initialize
		super
		self.input = {esc: :exit}
		@player = Player.create
	end
end

class Player < Chingu::GameObject

	#meta-constructor
	def setup
		@x, @y = 350, 400
		@image = Gosu::Image["starwarsships.png"]
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down
		}
	end

	def left
		unless @x - 30 <= 0
			@x -= 5

		end
	end

	def right
		unless @x + 30 >= 800
			@x += 5
		end
	end

	def up
		unless @y - 24 <= 0
			@y -= 5
		end
	end
	def down
		unless @y + 24 >= 600
			@y += 5
		end
	end

end

Game.new.show	