class LogicController < ApplicationController
  @@total = []
  @@my_move = []
  @@y = []
  @@o = []


  def ping
    
    @@total = []

  	render json: '{"ok": true}'
  end

  def start
  	@@g = params[:g].to_i
  	@@blocks = @@g*@@g

  	@@g.times do |i|
      @@g.times do |j|
  		    @@total << [i+1,j+1]
      end
    end
    
    
  	@temp = params[:y].split(/\D/)

  	@@y = [@temp[0].to_i, @temp[1].to_i]
  	@@total.delete(@@y)
  	

  	@tempo = params[:o].split(/\D/)
  	@@o = [@tempo[0].to_i, @tempo[1].to_i]
  	self.class.class_variable_get(:@@total).delete(@@o)

  	
  	@@my_move = @@y # my intial move

  	render json: '{"ok": true}' 

  end

  def play
  	#@available_moves = []
    @current_position = []
	@y_adj = []
  	@o_adj = []
    @m_adj = []
    @least = []


  	@m = [params[:m][0].to_i, params[:m][2].to_i]   #move of oponent
    

    

  	(@m[0]-1).upto(@m[0]+1) do |i|
  		(@m[1]-1).upto(@m[1]+1) do |j|
  			if self.class.class_variable_get(:@@total).include?([i,j])
              @m_adj << [i,j]		# opponent neighbours
            end
        end
  	end

  	

  	(@@my_move[0]-1).upto(@@my_move[0]+1) do |i|
  		(@@my_move[1]-1).upto(@@my_move[1]+1) do |j|
        	if self.class.class_variable_get(:@@total).include?([i,j])
          	  @o_adj << [i,j]				# my neighbours
        	end
  		end
  	end

  	
  	#@available_moves = @o_adj


  	if @o_adj.include?(@m)
  		@current_position = @m		
  			   
    else
  		@m_adj.length.times do |i|
  			if @o_adj.include? @m_adj[i]
  				@o_adj.delete(@m_adj[i])
  			end
  		end
   
    @current_position = @o_adj[rand(@o_adj.length)]
    
    end


    @@my_move = @current_position
    
  	self.class.class_variable_get(:@@total).delete(@m)
  	self.class.class_variable_get(:@@total).delete(@current_position)
  	

  	
  	render json: {m: "#{@current_position[0]}|#{@current_position[1]}"}
  	
  end
end
