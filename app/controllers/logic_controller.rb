class LogicController < ApplicationController
  
# => declare class variable here 
  @@total = []
  @@y = []
  @@o = []


  def ping
    @@total = []
	render json: '{"ok": true}'
  end

  def start
  	@g = params[:g].to_i

  	@g.times do |i|
      @g.times do |j|
  		    @@total << [i+1,j+1]
      end
    end
    
    
  	@temp = params[:y].split(/\D/)

  	@@y = [@temp[0].to_i, @temp[1].to_i] 
  	@@total.delete(@@y)
  	

  	@temp = params[:o].split(/\D/)
  	@@o = [@temp[0].to_i, @temp[1].to_i]

  	self.class.class_variable_get(:@@total).delete(@@o) # removing our current position from the 
  														# available positions							
  														# self.class refers to the current class
  	
  	@@my_move = @@y 									# my intial move

  	render json: '{"ok": true}' 

  end

  def play
  	#@available_moves = []
    
    @current_position = []								# array initializatoin						
	@y_adj = []											# array initializatoin
  	@o_adj = []											# array initializatoin
    @m_adj = []											# array initializatoin				
    @least = []											# array initializatoin


  	@m = [params[:m][0].to_i, params[:m][2].to_i]   	# oponent move
    

    # finding all the possible next moves of the oponent
    # opponent neighbours          
  	(@m[0]-1).upto(@m[0]+1) do |i|
  		(@m[1]-1).upto(@m[1]+1) do |j|
  			@m_adj << [i,j] if self.class.class_variable_get(:@@total).include?([i,j]) 
        end
  	end

	# construncting all the possible next moves for us  	
	# my neighbours
  	(@@my_move[0]-1).upto(@@my_move[0]+1) do |i|
  		(@@my_move[1]-1).upto(@@my_move[1]+1) do |j|
        	@o_adj << [i,j] if self.class.class_variable_get(:@@total).include?([i,j])        	  							
        end
  	end

  	
  	#@available_moves = @o_adj

  	# check to see if the oponent is one jump away from us
  	if @o_adj.include?(@m)
  		@current_position = @m		# move at his position
  			   
    else                            # check if we have any common adjacent position
  		@m_adj.length.times do |i|
  			if @o_adj.include? @m_adj[i] 
  				@o_adj.delete(@m_adj[i])	# delete that position from our next possible move
  			end
  		end
   
# select the random position you can apply the loop to choose the best possible adjacent node i am not doing it for the code bravity
    	@current_position = @o_adj[rand(@o_adj.length)]
    end


   	@current_position
    
  	self.class.class_variable_get(:@@total).delete(@m) 
  	self.class.class_variable_get(:@@total).delete(@current_position)
  	

# => Return the server friendly response back to the server  		
  	render json: {m: "#{@current_position[0]}|#{@current_position[1]}"}
  	
  end
end
