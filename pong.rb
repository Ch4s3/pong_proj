#1st attempt at rubygame for twist on pong

require 'rubygems'
require 'rubygame'

class Game
    def initialize
        @screen = Rubygame::Screen.new [1024, 480], 0,
[Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
        @screen.title = "Pong"
        
        @queue = Rubygame::EventQueue.new
        @clock = Rubygame::Clock.new
        @clock.target_framerate = 60
        
        @player = Paddle.new 50, 10
        @enemy = Paddle.new @screen.width-50-@player.width,10
        
        @player.center_y @screen.height
        @enemy.center_y @screen.height
        @background = Background.new @screen.width, @screen.height
    
    end
    
    def run!
        loop do
            update
            draw
            @clock.tick
        end
    end
    
    def update
        @queue.each do |ev|
            case ev
                when Rubygame::QuitEvent
                    Rubygame.quit
                    exit
            end
        end
    end
    
    def draw
        @screen.fill [0,0,0]
        
        @background.draw @screen
        @player.draw @screen 
        @enemy.draw @screen
        
        @screen.flip
    end
end

class GameObject
    attr_accessor :x, :y, :width, :height, :surface
    
    def initialize x, y, surface
        @x = x
        @y = y
        @surface = surface
        @width = surface.width
        @height = surface.height

        
    end
    
    def update
    end
    
    def draw screen
        @surface.blit screen, [@x, @y]
    end
    
    def handle_event event
    end
end

class Paddle < GameObject
        def initialize x, y
                surface = Rubygame::Surface.new [20, 100]
                surface.fill [0,0,0]
                super x, y, surface
        end
        
        def center_y h
                @y = h/2-@height/2
        end
end

class Background < GameObject
    def initialize width, height
        surface = Rubygame::Surface.new [width, height]
        
        # Draw background
        white = [255, 255, 255]
        
        #middle circle
        surface.draw_circle_s [surface.width/2,surface.height/2], 100, white # [surface, center, radius, color]
        
        #middle circle black
        surface.draw_circle_s [surface.width/2,surface.height/2], 90, [0,0,0]
        
        # Top
        surface.draw_box_s [0, 0], [surface.width, 10], white
        # Left
        surface.draw_box_s [0, 0], [10, surface.height], white
                    # box   (surface, point1, point2, color)
        # Bottom
        surface.draw_box_s [0, surface.height-10], [surface.width,
surface.height], white
        # Right
        surface.draw_box_s [surface.width-10, 0], [surface.width,
surface.height], white
        # Middle Divide
        surface.draw_box_s [surface.width/2-5, 0],
[surface.width/2+5, surface.height], white
        

        
        super 0, 0, surface
    end 
end
 

g = Game.new
g.run!