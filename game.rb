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
			holding_down: :down,
			space: :fire,
			f: :laserbomb	
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

	def fire
 		Laser.create(:x => self.x, :y => self.y)
  	end

  	def laserbomb
  		Laserbomb.create(:x => self.x, :y => self.y)
  	end

end

class Laser < Chingu::GameObject
	has_traits :velocity

	def setup
		@image = Gosu::Image["redlaser.png"]
		self.velocity_y = -10
	end

end

class Laserbomb < Chingu::GameObject
	has_traits :velocity

	def setup
		@image = Gosu::Image["laserbomben.png"]
		self.velocity_y = -10
	end

end

Game.new.show	