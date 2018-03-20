class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
   # Ibeacon.create(exercise_name: "Curl", reps_counted: 11, weight_lb: 220)
   # Ibeacon.create(exercise_name: "Row", reps_counted: 8, weight_lb: 160)
	require './lib/algorithm.rb'
	require './lib/rep.rb'
  require './lib/rotate.rb'
	def index 
          # correct = 0
          # total = 0
          # # press 10
          # @info = Ibeacon.new 
          # @info.x_motion = "906.0,-1109.0,-937.0,-1328.0,-968.0,-328.0,-968.0,-1031.0,-1187.0,-1140.0,-343.0,-937.0,-718.0,-1406.0,-1046.0,-750.0,-1000.0,-734.0,-1031.0,718.0,562.0,343.0,"
          # @info.y_motion = "-1109.0, -156.0, -171.0, -234.0, -109.0, -140.0, -187.0, -109.0, -234.0, -156.0, -187.0, -203.0, 15.0, -312.0, -187.0, -78.0, -156.0, -187.0, -156.0, -1093.0, -781.0, -953.0,"
          # @info.z_motion = "31.0, 265.0, 281.0, 484.0, 312.0, 140.0, 265.0, 296.0, 406.0, 312.0, 109.0, 312.0, 234.0, 406.0, 296.0, 171.0, 343.0, 343.0, 250.0, -31.0, 62.0, 46.0,"
          # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
          # @info.weight_lb = 20
          # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
          # correct += 1 if @info.exercise_name == "Shoulder Press"
          # total += 1

          # # Curl 10
          # @info = Ibeacon.new 
          # @info.x_motion = "62.0,1093.0,1109.0,812.0,-593.0,1000.0,140.0,1031.0,-343.0,1078.0,-781.0,1000.0,-265.0,1093.0,562.0,1437.0,1171.0,1406.0,1078.0,921.0,968.0,968.0,"
          # @info.y_motion = "-593.0, -15.0, -218.0, -531.0, -250.0, -109.0, -421.0, 375.0, -484.0, 406.0, -250.0, 500.0, -546.0, 515.0, -796.0, -15.0, -312.0, 0.0, -218.0, 265.0, -15.0, -78.0,"
          # @info.z_motion = "140.0, 156.0, 109.0, 218.0, 312.0, 250.0, 187.0, 234.0, 265.0, 203.0, 250.0, 125.0, 234.0, 234.0, 312.0, 156.0, 234.0, 140.0, 171.0, 0.0, 31.0, 15.0,"
          # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
          # @info.weight_lb = 20
          # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
          # correct += 1 if @info.exercise_name == "Curl"
          # total += 1

          # # Curl 10
          # @info = Ibeacon.new 
          # @info.x_motion = "-546.0,-125.0,171.0,-250.0,-515.0,-437.0,-312.0,-78.0,-437.0,-468.0,500.0,-609.0,-843.0,-156.0,-312.0,-828.0,-234.0,312.0,"
          # @info.y_motion = "-1437.0, -1437.0, 1000.0, -1406.0, 125.0, -546.0, -1328.0, 671.0, -1328.0, -1296.0, 1265.0, -1625.0, -828.0, 656.0, -1343.0, -296.0, -1140.0, -968.0,"
          # @info.z_motion = "-93.0, 78.0, 265.0, 93.0, 203.0, 62.0, 156.0, 187.0, 218.0, 250.0, 328.0, 250.0, 218.0, 218.0, 187.0, 187.0, 78.0, 31.0,"
          # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
          # @info.weight_lb = 20
          # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
          # correct += 1 if @info.exercise_name == "Curl"
          # total += 1

          # # Row 10
          # @info = Ibeacon.new 
          # @info.x_motion = "1125.0,1140.0,187.0,1500.0,1546.0,1171.0,781.0,953.0,1703.0,750.0,718.0,734.0,1343.0,1140.0,937.0,968.0,"
          # @info.y_motion = "187.0, -15.0, -15.0, 140.0, 78.0, -46.0, 15.0, 218.0, 125.0, -15.0, 78.0, 156.0, 140.0, 109.0, -31.0, 109.0,"
          # @info.z_motion = "0.0, -93.0, -265.0, 0.0, -31.0, -234.0, -218.0, -125.0, 0.0, -234.0, -312.0, -296.0, -250.0, -218.0, 15.0, 15.0,"
          # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
          # @info.weight_lb = 20
          # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
          # correct += 1 if @info.exercise_name == "Row"
          # total += 1

          # # press 10 semi fast
          # @info = Ibeacon.new 
          # @info.x_motion = "1343.0,-234.0,-625.0,-718.0,-531.0,-437.0,-468.0,-437.0,-109.0,-328.0,-468.0,-609.0,-625.0,1062.0,968.0,"
          # @info.y_motion = "468.0, -515.0, -1187.0, -1484.0, -1078.0, -859.0, -859.0, -781.0, -421.0, -281.0, -937.0, -1156.0, -1125.0, 62.0, -140.0,"
          # @info.z_motion = "-62.0, 187.0, 296.0, 578.0, 359.0, 359.0, 296.0, 281.0, 62.0, 203.0, 234.0, 500.0, 328.0, -78.0, 15.0,"
          # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
          # @info.weight_lb = 20
          # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
          # correct += 1 if @info.exercise_name == "Shoulder Press"
          # total += 1



          # p "DONE! FINAL RESULTS ARE: #{correct} / #{total}"


      respond_to do |format|
        format.html {
          @total_exercises = Ibeacon.count  
          @total_reps = Ibeacon.all.sum(:reps_counted)
          @total_weight = Ibeacon.all.sum(:weight_lb) 
          @total_curls = Ibeacon.all.where(exercise_name: "Curl").count
          @total_rows = Ibeacon.all.where(exercise_name: "Row").count
          @total_presses = Ibeacon.all.where(exercise_name: "Shoulder Press").count
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