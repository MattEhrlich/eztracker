class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
   # Ibeacon.create(exercise_name: "Curl", reps_counted: 11, weight_lb: 25)
   
	require './lib/algorithm.rb'
	require './lib/rep.rb'
   require './lib/rotate.rb'
	def index 
		
      respond_to do |format|
      format.html {
        @total_exercises = Ibeacon.count  
        @total_reps = Ibeacon.all.sum(:reps_counted)
        @total_weight = Ibeacon.all.sum(:weight_lb) 
        @data = Ibeacon.all
      }
      format.json { 
        render json: [Ibeacon.last,Ibeacon.count]
      }
    end
	end
	
	def new
	end
	
#	def create
#      x = Algorithm.array_string_to_array("765.0,906.0,296.0,328.0,265.0,0.0,812.0,984.0,765.0,968.0,1015.0,1203.0,-125.0,843.0,781.0,671.0,")
#      y = Algorithm.array_string_to_array("-1156.0,-1093.0,-234.0,-250.0,-156.0,46.0,-750.0,-859.0,-796.0,-828.0,-828.0,-984.0,218.0,-703.0,-546.0,-718.0,")
#      z = Algorithm.array_string_to_array("-218.0,-46.0,31.0,109.0,109.0,171.0,187.0,250.0,156.0,93.0,203.0,46.0,218.0,-234.0,-343.0,-281.0,")
#      p "check"
#      if x.length >= 6
#      		@info = Ibeacon.new 
#      		@info.x_motion = "765.0,906.0,296.0,328.0,265.0,0.0,812.0,984.0,765.0,968.0,1015.0,1203.0,-125.0,843.0,781.0,671.0,"
 #      		@info.y_motion = "-1156.0,-1093.0,-234.0,-250.0,-156.0,46.0,-750.0,-859.0,-796.0,-828.0,-828.0,-984.0,218.0,-703.0,-546.0,-718.0,"
  #     		@info.z_motion = "-218.0,-46.0,31.0,109.0,109.0,171.0,187.0,250.0,156.0,93.0,203.0,46.0,218.0,-234.0,-343.0,-281.0,"
   #    		@info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
    #   		@info.weight_lb = 20
     #       @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
      # 		@info.save
     # end
#end

   def create
      x = Algorithm.array_string_to_array(beacon_params["x_motion"])
      y = Algorithm.array_string_to_array(beacon_params["y_motion"])
      z = Algorithm.array_string_to_array(beacon_params["z_motion"])
      p "check"
      if x.length >= 6
         # Algorithm.is_not_walking?(x,y,z)
         if Rep.rep_predict(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"], "Shoulder Press") >= 1
            @info = Ibeacon.new 
            @info.x_motion = beacon_params["x_motion"]
            @info.y_motion = beacon_params["y_motion"]
            @info.z_motion = beacon_params["z_motion"]
            @info.exercise_name = @info.classify_exercise(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
            @info.reps_counted = Rep.rep_predict(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"], @info.exercise_name)
            @info.weight_lb = @info.reps_counted*beacon_params["weight_lb"][9..-2].to_i
            @info.save
         end
      end   
      
   end
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion, :weight_lb)
	end 
end