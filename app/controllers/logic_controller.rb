class LogicController < ApplicationController
  @@total = []
  @@my_move = []
  def ping
  	respond_to do |format|
  		format.html { render notice: "Hey dude"}
  		format.json { render json: params[:q].scan(/\d+/) }
  	end
  end

  def start
  	@@g = params[:g].to_i
  	@@blocks = @@g*@@g

  	@@g.times do |i|
      @@g.times do |j|
  		    @@total << [i,j]
      end
    end


  	@@y = [params[:y][0].to_i,params[:y][2].to_i]
  	@@total.delete(@@y)

  	@@o = [params[:o][0].to_i,params[:o][2].to_i]
  	@@total.delete(@@o)

  	@@my_move = @@y # my intial move

  	respond_to do |format|
  		format.html
  		format.json { render json: "this is start"}
  	end
  end

  def play
  	@available_moves = []
    @current_position = []
	  @y_adj = []
  	@o_adj = []
    @m_adj = []



  	@m = [params[:m][0].to_i, params[:m][2].to_i]   #move of oponent
    self.class.class_variable_get(:@@total).delete(@m)                             #update the total moves



  	(@m[0]-1).upto(@m[0]+1) do |i|
  		(@m[1]-1).upto(@m[1]+1) do |j|
  			if @@total.include?([i,j])
          @m_adj << [i,j]	# opponent neighbours
        end
      end
  	end

  	(@@my_move[0]-1).upto(@@my_move[0]+1) do |i|
  		(@@my_move[1]-1).upto(@@my_move[1]+1) do |j|
        if @@total.include?([i,j])
          @o_adj << [i,j]# my neighbours
        end
  		end
  	end

  	@available_moves = @o_adj

  	if @o_adj.include?([@m])
  		@current_position = @m
  		@@my_move = @current_position  # update my move
      byebug
    else
  		@m_adj.length.times do |i|
  			if @o_adj.include? @m_adj[i]
  				@available_moves.delete(@m_adj[i])
  			end
  		end
      @current_position = @available_moves[rand(@available_moves.length)]
    end

  	@@total.delete(@current_position)

  	respond_to do |format|
  		format.html
  		format.json { render json:  @current_position }
  	end
  end
end
