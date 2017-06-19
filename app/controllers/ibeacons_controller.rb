class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	require './lib/rep.rb'
    require './lib/rotate.rb'
	def index 
	   # @info = Ibeacon.new 

    # TODO: rotation and displacement optimization

    # Curl 11
#     @info.x_motion = "-0.60567372,  0.77103169,  0.35543394,  0.16867183,  0.31597042,
#         0.14584389,  0.03307819, -0.03006234, -0.1080947 , -0.01977126,
#        -0.12958518,  0.10196857,  0.03080578, -0.04643162,  0.12693846,
#        -0.37294574, -0.02198607,  0.14886606, -0.35201647, -0.51204173
# ,"
#     @info.y_motion = "0.84226268, -0.47550696,  0.4639161 , -1.8165551 ,  2.47003979,
#        -1.44575405,  3.10695461,  1.625704  , -0.64090107, -0.86929076,
#        -1.79113747, -0.29679384, -0.52627223, -0.90426404,  0.47170511,
#         1.0742913 , -2.00069016,  1.30362072, -0.74594692,  0.15461828
# ,"
#     @info.z_motion = "-0.95309682, -0.5853581 ,  0.39128937, -0.61726956,  1.92897437,
#        -0.7168422 ,  2.5521397 ,  0.53950559, -0.53444428, -0.81816013,
#        -0.59578436, -0.79113288, -0.65685674, -0.38507501, -0.21911716,
#         1.04907907, -0.90654045,  1.62353594, -0.09240141, -0.21244493
# ,"


    # Curl 7 
#     @info.x_motion = "-0.10951757, -0.0616564 ,  0.09251005, -0.04159162,  0.08835771,
#        -0.02787768, -0.03021649,  0.50841647,  0.14048458, -0.01097131,
#         0.00772166, -0.07386636, -0.55782082,  0.07602777
# ,"
#     @info.y_motion = "-0.86827793,  0.43966124,  0.66199604, -0.21678886,  0.8671993 ,
#        -1.28022197,  2.63409879, -1.53357129,  2.8079749 , -1.68031237,
#         0.11638341,  0.40851137, -0.63779635, -1.71885627
# ,"
#     @info.z_motion = "-0.54031447, -0.57006746, -0.07468095, -1.01701625,  0.29429666,
#        -0.45625112,  2.58379803, -0.32719849,  1.99024514, -0.60891218,
#        -0.55562141, -0.26325112, -0.70287978,  0.24785338
# ,"

    # Press 10
#     @info.x_motion = "0.7458307 ,  0.50353134, -0.0900868 ,  0.13386383,  0.36926152,
#        -0.75841067,  0.29173342, -0.17795392, -0.2366765 , -0.23644368,
#         0.43056177,  0.15217024,  0.35017963, -0.02046709, -0.20577178,
#        -0.46300436, -0.09272524, -0.25330195, -0.4773887 ,  0.03509825
# ,"
#     @info.y_motion = "0.49627687, -0.1020345 , -0.75232194, -1.25848734,  0.0257417 ,
#        -1.12127557, -0.66203118, -0.65792898, -1.3848534 , -0.29900177,
#         0.18502412, -0.43551385, -0.03362459, -0.07457209, -0.71302746,
#        -0.2965034 , -0.18419884, -0.43221808,  4.06712836,  3.63342193
# ,"
#     @info.z_motion = "-0.18279852,  0.48336478,  0.12082591, -1.64567487,  0.80577125,
#        -0.79680008, -0.73145642, -0.08922572, -0.90312633, -0.06341246,
#         0.71307297, -1.41457881,  0.3044541 , -0.0395048 , -0.6406235 ,
#         0.28167183,  0.24315845, -0.96716186,  2.10160645,  2.42043763
# ,"

    # Row 5
#     @info.x_motion = "1.32127335,  2.16215461, -0.78925018, -0.34901706,  0.18447315,
#        -1.43494563,  0.72389018, -0.71773166, -0.77787146,  0.17406233,
#        -0.42007695, -0.07696066
# ,"
#     @info.y_motion = "-0.54963627,  0.75446603, -0.81236847, -1.08843037, -0.81485327,
#         0.76923023, -1.4271751 , -0.30143151, -0.78264677,  1.23037463,
#         1.29767586,  1.72479501
# ,"
#     @info.z_motion = "0.44824292,  2.91965913, -0.04702234, -0.14405137, -0.08836072,
#        -0.82333969,  0.31790756, -0.7398105 , -1.24182885,  0.19267394,
#        -0.50448389, -0.28958619
# ,"


    # Press 3
#     @info.x_motion = "-0.3086229 ,  0.37147115, -0.36212926,  0.25463952,  0.12278229,
#        -0.33927915,  0.0284246 ,  0.23271375
# ,"
#     @info.y_motion = "1.67757577, -0.81882422, -1.83552042, -1.16733564, -0.99271668,
#        -0.34550184,  1.71940594,  1.7629171
# ,"
#     @info.z_motion = "0.16839259,  1.02211123, -2.41962857, -0.33900174,  0.61435589,
#         0.67026099,  0.3545178 , -0.07100819
# ,"
    # p Rotate.slope(N[1,2,3],N[4,5,9])
    # p Rotate.rotate_2d([[1.0,0.0,1.0],[0.0,1.0,2.0]], [90])
    # p Rotate.rotate_3d([[1.0,0.0,1.0],[0.0,1.0,2.0]], [45.0,63.0,-17.0])
    # p Rotate.rotate_3d_df([[1.0,0.0,1.0],[0.0,1.0,2.0]], [45.0,63.0,-17.0], [0,1,0])
    # p Rotate.computeCost_2d([45.0,63.0,-17.0],[[3.0,0.0,1.0],[0.0,1.0,2.0]])
    # p Rotate.computeCost_df_2d([45.0,63.0,-17.0],[[3.0,0.0,1.0],[0.0,1.0,2.0]])
    # p Rotate.computeCost_3d([45.0,63.0,-17.0],[[3.0,7.0,1.0],[8.0,1.0,2.0]])
    # p Rotate.computeCost_df_3d([45.0,63.0,-17.0],[[3.0,7.0,1.0],[8.0,1.0,2.0]])
    # p Rotate.angle_guess_2d([[3.0,7.0,1.0],[8.0,1.0,2.0]])
    # p Rotate.angle_guess_3d([[3.0,7.0,1.0],[8.0,1.0,2.0]])
    #  Row 15
    # @info.x_motion = "1984.0,765.0,1843.0,1046.0,125.0,1281.0,-265.0,1984.0,1984.0,1984.0,1375.0,859.0,62.0,0.0,"
    # @info.y_motion = "1984.0,-78.0,734.0,-796.0,218.0,-296.0,93.0,171.0,78.0,437.0,281.0,-515.0,-156.0,-15.0,"
    # @info.z_motion = "1984.0,1687.0,1984.0,-1187.0,687.0,1078.0,437.0,1984.0,1984.0,937.0,906.0,1343.0,921.0,1031.0,"




    # Curl 5 
    # @info.x_motion = "703.0,1140.0,1171.0,593.0,781.0,1125.0,546.0,1031.0,921.0,1250.0,718.0,671.0,"
    # @info.y_motion = "515.0,-93.0,-93.0,453.0,343.0,-125.0,421.0,-31.0,328.0,93.0,-593.0,-718.0,"
    # @info.z_motion = "125.0,-171.0,-46.0,125.0,15.0,-156.0,109.0,-62.0,62.0,-218.0,-203.0,-281.0,"


    # Curl 9 
    # @info.x_motion = "234.0,1203.0,984.0,1078.0,1062.0,-93.0,1203.0,1062.0,640.0,1000.0,1000.0,625.0,1218.0,437.0,703.0,671.0,671.0,"
    # @info.y_motion = "625.0,-562.0,-31.0,-15.0,-625.0,703.0,-296.0,0.0,-46.0,-890.0,156.0,187.0,-500.0,250.0,-562.0,-625.0,-734.0,"
    # @info.z_motion = "171.0,-218.0,-125.0,-125.0,-250.0,328.0,-125.0,-78.0,78.0,-218.0,15.0,-31.0,-296.0,31.0,-234.0,-265.0,-281.0,"





 	# 	@info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
 	# 	@info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion)
 	# 	@info.save
	   @data = Ibeacon.all
	end
	
	def new
	end
	
	def create
		@info = Ibeacon.new 
		@info.x_motion = beacon_params["x_motion"]
 		@info.y_motion = beacon_params["y_motion"]
 		@info.z_motion = beacon_params["z_motion"]
 		@info.exercise_name = @info.classify_exercise(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
 		@info.reps_counted = Rep.rep_predict(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
 		@info.save
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
