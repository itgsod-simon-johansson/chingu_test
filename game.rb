require 'chingu'

class Game < Chingu::Window

	#constructor
	def initialize
		super 800, 640
		self.input = {esc: :exit}
		@player = Player.create
		@targets = []
		5.times {@targets << Target.create}
		@background_image = Gosu::Image.new(self, "world.png", true)
	end


	def update
		super
		Laser.each_bounding_circle_collision(Target) do |laser, target|
			laser.destroy
			target.destroy
 		end
 		Laserbomb.each_bounding_circle_collision(Target) do |laserbomb, target|
			laserbomb.destroy
			target.destroy
	 	end
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
		unless @y + 24 >= 640
			@y += 5
		end
	end

	def fire
 		Laser.create(x: self.x, y: self.y)
  	end

  	def laserbomb
  		Laserbomb.create(x: self.x, y: self.y)
  	end

end

class Laser < Chingu::GameObject
	has_traits :velocity, :collision_detection, :bounding_circle, :timer

	def setup
		@image = Gosu::Image["redlaser.png"]
		self.velocity_y = -10
		Gosu::Sound["LASER1.wav"].play
		after(500) do 
			self.destroy
		end
	end

end

class Laserbomb < Chingu::GameObject
	has_traits :velocity, :collision_detection, :bounding_circle, :timer

	def setup
		@image = Gosu::Image["laserbomben.png"]
		self.velocity_y = -10
		after(500) do 
			self.destroy
		end
	end

end

class Target < Chingu::GameObject
	has_traits :collision_detection, :bounding_circle

	def setup
		@x = rand(800)
		@y = 100
		@image = Gosu::Image["target.png"]
	end
end

Game.new.show	