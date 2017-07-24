class IbeaconsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	require './lib/algorithm.rb'
	require './lib/rep.rb'
   require './lib/rotate.rb'
	def index 
      #   beginning_time = Time.now
      #   p "========================"
	     # @info = Ibeacon.new 
   #      tally = 0
   #      correct = 0
   #      error = []
   #      # Bad press1
   #      # @info.x_motion = "828.0,1375.0,625.0,859.0,1234.0,625.0,1062.0,968.0,500.0,1343.0,625.0,1109.0,984.0,796.0,1062.0,984.0,562.0,"
   #      # @info.y_motion = "-1000.0,203.0,281.0,171.0,734.0,562.0,421.0,421.0,171.0,921.0,390.0,359.0,484.0,140.0,500.0,-562.0,-781.0,"
   #      # @info.z_motion = "-234.0,187.0,109.0,78.0,46.0,-62.0,93.0,-62.0,-140.0,78.0,-15.0,265.0,0.0,-125.0,-31.0,-218.0,-296.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      # correct += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally +=1
   #      # p "Shoulder Press"

   #      # Row 20
   #      @info.x_motion = "609.0,906.0,765.0,437.0,1015.0,703.0,578.0,796.0,765.0,640.0,921.0,859.0,671.0,1000.0,750.0,734.0,781.0,484.0,953.0,781.0,734.0,906.0,703.0,625.0,859.0,625.0,859.0,812.0,500.0,750.0,828.0,468.0,1046.0,750.0,765.0,"
   #      @info.y_motion = "-640.0,-859.0,-734.0,-250.0,-1062.0,-734.0,-390.0,-812.0,-906.0,-578.0,-1000.0,-906.0,-562.0,-1000.0,-781.0,-703.0,-812.0,-343.0,-921.0,-750.0,-656.0,-812.0,-609.0,-578.0,-906.0,-578.0,-687.0,-828.0,-312.0,-734.0,-734.0,-359.0,-812.0,-500.0,-640.0,"
   #      @info.z_motion = "-78.0,-31.0,93.0,281.0,-62.0,203.0,187.0,109.0,125.0,156.0,109.0,78.0,140.0,-109.0,250.0,187.0,109.0,203.0,0.0,78.0,125.0,31.0,265.0,187.0,187.0,171.0,187.0,203.0,265.0,156.0,109.0,296.0,78.0,-234.0,-171.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, "Row")
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 20).abs / 20.0]
   #      p"20"

   #      #  Row 15
   #      @info.x_motion = "1984.0,765.0,1843.0,1046.0,125.0,1281.0,-265.0,1984.0,1984.0,1984.0,1375.0,859.0,62.0,0.0,"
   #      @info.y_motion = "1984.0,-78.0,734.0,-796.0,218.0,-296.0,93.0,171.0,78.0,437.0,281.0,-515.0,-156.0,-15.0,"
   #      @info.z_motion = "1984.0,1687.0,1984.0,-1187.0,687.0,1078.0,437.0,1984.0,1984.0,937.0,906.0,1343.0,921.0,1031.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 15).abs / 15.0]
   #      p"15"

   #      # Curl 5 
   #      @info.x_motion = "703.0,1140.0,1171.0,593.0,781.0,1125.0,546.0,1031.0,921.0,1250.0,718.0,671.0,"
   #      @info.y_motion = "515.0,-93.0,-93.0,453.0,343.0,-125.0,421.0,-31.0,328.0,93.0,-593.0,-718.0,"
   #      @info.z_motion = "125.0,-171.0,-46.0,125.0,15.0,-156.0,109.0,-62.0,62.0,-218.0,-203.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 5).abs / 5.0]
   #      p"5"
   #      # Curl 9 
   #      @info.x_motion = "234.0,1203.0,984.0,1078.0,1062.0,-93.0,1203.0,1062.0,640.0,1000.0,1000.0,625.0,1218.0,437.0,703.0,671.0,671.0,"
   #      @info.y_motion = "625.0,-562.0,-31.0,-15.0,-625.0,703.0,-296.0,0.0,-46.0,-890.0,156.0,187.0,-500.0,250.0,-562.0,-625.0,-734.0,"
   #      @info.z_motion = "171.0,-218.0,-125.0,-125.0,-250.0,328.0,-125.0,-78.0,78.0,-218.0,15.0,-31.0,-296.0,31.0,-234.0,-265.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 9).abs / 9.0]
   #      p"9"
   #      # Press 3
   #      # @info.x_motion = "640.0,296.0,937.0,546.0,375.0,421.0,593.0,671.0,"
   #      # @info.y_motion = "-515.0,546.0,1437.0,812.0,734.0,546.0,-656.0,-734.0,"
   #      # @info.z_motion = "-78.0,-46.0,234.0,-15.0,62.0,187.0,-218.0,-328.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      # correct += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally +=1
   #      # p "Shoulder Press"
   #      # error += [(@info.reps_counted.to_i- 3).abs / 3.0]
   #      # p"3"
   #      # Curl 11
   #      @info.x_motion = "890.0,765.0,562.0,359.0,484.0,468.0,359.0,687.0,531.0,593.0,296.0,734.0,625.0,437.0,718.0,328.0,375.0,296.0,312.0,515.0,"
   #      @info.y_motion = "-859.0,-890.0,-437.0,-1328.0,500.0,-1265.0,796.0,-156.0,-1046.0,-1171.0,-1359.0,-1000.0,-1031.0,-1062.0,-640.0,-203.0,-1484.0,93.0,-984.0,-812.0,"
   #      @info.z_motion = "-390.0,-46.0,-15.0,-187.0,171.0,-203.0,187.0,-78.0,-234.0,-250.0,-250.0,-218.0,-218.0,-203.0,-140.0,-93.0,-265.0,93.0,-234.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 11).abs / 11.0]
   #      p"11"  
   #       # Row 5
   #      @info.x_motion = "375.0,218.0,171.0,203.0,296.0,453.0,203.0,375.0,390.0,531.0,593.0,656.0,"
   #      @info.y_motion = "-734.0,93.0,-1015.0,-1046.0,-968.0,-1062.0,-906.0,-1125.0,-1312.0,-656.0,-859.0,-734.0,"
   #      @info.z_motion = "281.0,359.0,-78.0,31.0,93.0,-421.0,281.0,-156.0,-125.0,-156.0,-296.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 5).abs / 5.0]
   #      p"5"
   #       # Press 10
   #      @info.x_motion = "312.0,62.0,125.0,375.0,46.0,406.0,265.0,218.0,250.0,312.0,93.0,515.0,156.0,312.0,343.0,281.0,234.0,500.0,906.0,609.0,"
   #      @info.y_motion = "906.0,734.0,890.0,1640.0,578.0,1187.0,1234.0,937.0,1343.0,859.0,593.0,1421.0,765.0,843.0,1140.0,703.0,750.0,1203.0,-687.0,-656.0,"
   #      @info.z_motion = "-140.0,-15.0,156.0,140.0,0.0,296.0,62.0,156.0,234.0,125.0,-31.0,46.0,0.0,62.0,156.0,171.0,93.0,125.0,-296.0,-328.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"
   #      # Row/Curl
   #      @info.x_motion = "250.0,-734.0,-437.0,-531.0,-1093.0,-296.0,-953.0,-437.0,-750.0,-687.0,-750.0,-156.0,343.0,15.0,"
   #      @info.y_motion = "-718.0,-203.0,-218.0,-140.0,281.0,140.0,546.0,531.0,328.0,500.0,218.0,265.0,-421.0,-15.0,"
   #      @info.z_motion = "1296.0,-1000.0,-796.0,-421.0,-781.0,-640.0,-703.0,-828.0,-531.0,-718.0,-515.0,-593.0,984.0,1031.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"


   #      # Press
   #      @info.x_motion = "406.0,453.0,421.0,312.0,968.0,234.0,203.0,187.0,140.0,828.0,656.0,"
   #      @info.y_motion = "859.0,1562.0,1734.0,1203.0,1984.0,1125.0,562.0,890.0,546.0,-765.0,-718.0,"
   #      @info.z_motion = "-31.0,-31.0,125.0,203.0,343.0,359.0,78.0,-31.0,250.0,-328.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #       # Row 10
   #      @info.x_motion = "453.0,281.0,203.0,296.0,515.0,312.0,203.0,562.0,484.0,265.0,546.0,687.0,390.0,359.0,500.0,500.0,531.0,718.0,671.0,"
   #      @info.y_motion = "-843.0,-1125.0,15.0,-1281.0,-1234.0,-781.0,-421.0,-1109.0,-1062.0,-390.0,-1093.0,-1015.0,-1000.0,-843.0,-1015.0,-1000.0,-843.0,-687.0,-734.0,"
   #      @info.z_motion = "-46.0,-203.0,343.0,-78.0,-421.0,234.0,343.0,-328.0,-234.0,203.0,-234.0,-312.0,125.0,31.0,-218.0,62.0,-218.0,-250.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"
   #       # Press 12
   #      @info.x_motion = "718.0,218.0,484.0,218.0,375.0,484.0,312.0,250.0,687.0,218.0,359.0,437.0,218.0,484.0,484.0,343.0,703.0,312.0,171.0,531.0,796.0,656.0,"
   #      @info.y_motion = "-453.0,562.0,1375.0,687.0,875.0,984.0,750.0,796.0,1500.0,671.0,812.0,921.0,515.0,906.0,1046.0,781.0,1265.0,531.0,609.0,171.0,-656.0,-750.0,"
   #      @info.z_motion = "31.0,-46.0,187.0,0.0,156.0,171.0,109.0,109.0,187.0,62.0,93.0,93.0,-109.0,234.0,78.0,-281.0,203.0,-46.0,-203.0,156.0,-187.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 12).abs / 12.0]
   #      p"12"
   #       # Press 8
   #      @info.x_motion = "500.0,140.0,343.0,468.0,328.0,421.0,156.0,203.0,359.0,125.0,531.0,218.0,218.0,296.0,968.0,703.0,"
   #      @info.y_motion = "390.0,265.0,984.0,843.0,1125.0,953.0,703.0,1046.0,1031.0,656.0,1203.0,875.0,937.0,1031.0,-578.0,-656.0,"
   #      @info.z_motion = "15.0,31.0,-62.0,62.0,-46.0,62.0,78.0,-62.0,0.0,187.0,-62.0,125.0,0.0,-46.0,-515.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 8).abs / 8.0]
   #      p"8"
        
   #       # Press 2
   #      # @info.x_motion = "171.0,250.0,515.0,171.0,484.0,546.0,"
   #      # @info.y_motion = "875.0,656.0,1031.0,750.0,453.0,-843.0,"
   #      # @info.z_motion = "203.0,156.0,640.0,46.0,484.0,-281.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      # correct += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally +=1
   #      # p "Shoulder Press"
   #      # error += [(@info.reps_counted.to_i- 2).abs / 2.0]
   #      # p"2"

   #       # Row 7
   #      @info.x_motion = "515.0,250.0,156.0,296.0,343.0,406.0,171.0,609.0,468.0,265.0,640.0,296.0,562.0,"
   #      @info.y_motion = "-843.0,-1109.0,109.0,-1078.0,-1125.0,-1000.0,31.0,-1328.0,-937.0,-421.0,-1203.0,-593.0,-671.0,"
   #      @info.z_motion = "-140.0,-140.0,453.0,31.0,-93.0,109.0,562.0,-328.0,-62.0,359.0,-359.0,187.0,-265.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 7).abs / 7.0]
   #      p"7"
   #      # Row 15
   #      @info.x_motion = "343.0,265.0,531.0,390.0,359.0,546.0,515.0,546.0,562.0,453.0,609.0,578.0,250.0,796.0,515.0,140.0,640.0,578.0,218.0,781.0,531.0,468.0,343.0,453.0,640.0,656.0,"
   #      @info.y_motion = "-906.0,-859.0,-1234.0,-1000.0,-906.0,-1156.0,-968.0,-1156.0,-953.0,-609.0,-1031.0,-906.0,-203.0,-1140.0,-1000.0,125.0,-1046.0,-1046.0,-203.0,-1156.0,-953.0,-875.0,-875.0,-890.0,-812.0,-718.0,"
   #      @info.z_motion = "156.0,140.0,-328.0,78.0,93.0,-250.0,62.0,-156.0,-234.0,125.0,-312.0,-125.0,234.0,-484.0,-125.0,531.0,-218.0,46.0,359.0,-359.0,-156.0,234.0,-15.0,-218.0,-265.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 15).abs / 15.0]
   #      p"15"
   #      # Press 4 (HARD)
   #      @info.x_motion = "968.0,343.0,500.0,390.0,593.0,250.0,656.0,265.0,437.0,781.0,609.0,671.0,"
   #      @info.y_motion = "-1000.0,671.0,921.0,890.0,906.0,625.0,812.0,468.0,984.0,-859.0,-765.0,-718.0,"
   #      @info.z_motion = "-546.0,-46.0,234.0,-31.0,-46.0,156.0,-31.0,15.0,78.0,-375.0,-281.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, "Shoulder Press")

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 4).abs / 4.0]
   #      p"4"


   #      # # Curl 7 
   #      @info.x_motion = "515.0,593.0,609.0,734.0,578.0,484.0,640.0,609.0,656.0,640.0,562.0,609.0,437.0,437.0,671.0,"
   #      @info.y_motion = "-859.0,-62.0,-1015.0,-93.0,-1046.0,-1187.0,46.0,-1359.0,-1031.0,-546.0,-1093.0,-125.0,-859.0,-890.0,-656.0,"
   #      @info.z_motion = "-281.0,0.0,-250.0,-62.0,-296.0,-312.0,-46.0,-265.0,-265.0,-78.0,-343.0,-31.0,-187.0,-296.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 7).abs / 7.0]
   #      p"7"

   #      # Row 7
   #      @info.x_motion = "484.0,812.0,687.0,906.0,859.0,296.0,437.0,906.0,1171.0,921.0,828.0,703.0,671.0,687.0,"
   #      @info.y_motion = "-671.0,-906.0,-703.0,-718.0,-734.0,-250.0,-421.0,-859.0,-968.0,-1031.0,-734.0,-609.0,-640.0,-687.0,"
   #      @info.z_motion = "-203.0,-62.0,125.0,-31.0,109.0,140.0,203.0,31.0,-31.0,46.0,187.0,-171.0,-312.0,-265.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 7).abs / 7.0]
   #      p"7"

   #      # Row 8
   #      @info.x_motion = "703.0,484.0,312.0,1078.0,1031.0,812.0,187.0,750.0,859.0,953.0,437.0,750.0,671.0,656.0,"
   #      @info.y_motion = "-734.0,-359.0,-359.0,-1203.0,-1031.0,-968.0,-15.0,-890.0,-843.0,-906.0,-250.0,-734.0,-718.0,-734.0,"
   #      @info.z_motion = "15.0,156.0,390.0,-31.0,62.0,171.0,343.0,0.0,125.0,203.0,312.0,62.0,-328.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 8).abs / 8.0]
   #      p"8"
   #      # Curl 7
   #      @info.x_motion = "765.0,609.0,671.0,656.0,593.0,718.0,718.0,625.0,625.0,578.0,453.0,640.0,515.0,484.0,"
   #      @info.y_motion = "-437.0,-1000.0,109.0,-1031.0,250.0,-1093.0,-625.0,-671.0,-1031.0,109.0,-1265.0,-234.0,-937.0,-859.0,"
   #      @info.z_motion = "-125.0,-171.0,-31.0,-203.0,31.0,-265.0,-203.0,-203.0,-312.0,-31.0,-156.0,-140.0,-265.0,-218.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 7).abs / 7.0]
   #      p"7"
   #      # Press 10
   #      @info.x_motion = "750.0,843.0,859.0,1093.0,1093.0,609.0,1578.0,1015.0,515.0,1375.0,1078.0,515.0,1640.0,593.0,984.0,1609.0,906.0,859.0,937.0,671.0,"
   #      @info.y_motion = "-906.0,-15.0,343.0,250.0,312.0,93.0,265.0,234.0,218.0,312.0,46.0,93.0,312.0,187.0,125.0,437.0,109.0,203.0,-484.0,-703.0,"
   #      @info.z_motion = "-296.0,-218.0,-31.0,-125.0,-62.0,-171.0,-109.0,-109.0,-140.0,-187.0,-250.0,-140.0,-140.0,-109.0,-171.0,-218.0,-250.0,-46.0,-62.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"
   #      # Row 12
   #      @info.x_motion = "765.0,906.0,296.0,328.0,265.0,0.0,812.0,984.0,765.0,968.0,1015.0,1203.0,-125.0,843.0,781.0,671.0,"
   #      @info.y_motion = "-1156.0,-1093.0,-234.0,-250.0,-156.0,46.0,-750.0,-859.0,-796.0,-828.0,-828.0,-984.0,218.0,-703.0,-546.0,-718.0,"
   #      @info.z_motion = "-218.0,-46.0,31.0,109.0,109.0,171.0,187.0,250.0,156.0,93.0,203.0,46.0,218.0,-234.0,-343.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 12).abs / 12.0]
   #      p"12"
   #      # Press 6
   #      @info.x_motion = "687.0,843.0,765.0,1156.0,875.0,1437.0,890.0,1187.0,890.0,1296.0,765.0,1390.0,765.0,890.0,875.0,625.0,"
   #      @info.y_motion = "-843.0,109.0,125.0,234.0,296.0,312.0,203.0,250.0,109.0,250.0,234.0,296.0,171.0,156.0,-546.0,-828.0,"
   #      @info.z_motion = "-250.0,-156.0,-93.0,-78.0,-93.0,-93.0,15.0,203.0,-171.0,171.0,-140.0,-46.0,-78.0,-109.0,-62.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 6).abs / 6.0]
   #      p"6"
   #      # Curl 4
   #      @info.x_motion = "593.0,609.0,703.0,625.0,765.0,671.0,546.0,359.0,656.0,656.0,"
   #      @info.y_motion = "140.0,-1328.0,-937.0,-609.0,-921.0,-562.0,-937.0,-906.0,-765.0,-734.0,"
   #      @info.z_motion = "-156.0,-171.0,-218.0,-140.0,-250.0,-187.0,-265.0,-312.0,-296.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 4).abs / 4.0]
   #      p"4"
   #      # Row 9
   #      @info.x_motion = "906.0,875.0,453.0,859.0,343.0,1250.0,1296.0,1156.0,1296.0,1125.0,1031.0,562.0,656.0,"
   #      @info.y_motion = "-843.0,-875.0,-171.0,-812.0,-265.0,-1046.0,-1031.0,-953.0,-1156.0,-875.0,-812.0,-640.0,-734.0,"
   #      @info.z_motion = "-218.0,-46.0,62.0,218.0,109.0,-218.0,-218.0,31.0,-250.0,-125.0,46.0,-265.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 9).abs / 9.0]
   #      p"9"
   #      # Curl 4
   #      @info.x_motion = "750.0,843.0,265.0,750.0,546.0,625.0,687.0,343.0,796.0,859.0,500.0,437.0,562.0,687.0,"
   #      @info.y_motion = "-906.0,-343.0,-1234.0,-593.0,-859.0,-921.0,328.0,-953.0,-531.0,-15.0,-937.0,-875.0,-812.0,-703.0,"
   #      @info.z_motion = "-218.0,-187.0,-218.0,-140.0,-250.0,-171.0,62.0,-187.0,-171.0,-46.0,-187.0,-234.0,-265.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 4).abs / 4.0]
   #      p"4"





   #      # Curl 10
   #      @info.x_motion = "734.0,796.0,562.0,718.0,687.0,593.0,875.0,500.0,609.0,468.0,828.0,531.0,750.0,687.0,812.0,453.0,609.0,406.0,750.0,468.0,750.0,625.0,687.0,"
   #      @info.y_motion = "-765.0,187.0,-875.0,-640.0,-890.0,-1031.0,-93.0,-1031.0,453.0,-921.0,-171.0,-937.0,-250.0,-984.0,-468.0,-1265.0,328.0,-890.0,-265.0,-1187.0,0.0,-796.0,-703.0,"
   #      @info.z_motion = "-171.0,15.0,-140.0,-109.0,-250.0,-218.0,-31.0,-125.0,93.0,-140.0,-15.0,-187.0,-15.0,-312.0,-140.0,-218.0,93.0,-218.0,-62.0,-171.0,31.0,-156.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"

   #      # Curl 10
   #      @info.x_motion = "828.0,1078.0,968.0,984.0,984.0,484.0,750.0,781.0,890.0,968.0,921.0,828.0,593.0,859.0,984.0,734.0,687.0,"
   #      @info.y_motion = "-62.0,-953.0,-562.0,-937.0,-937.0,578.0,-390.0,-1359.0,-578.0,-734.0,-828.0,-984.0,-171.0,-593.0,-609.0,-750.0,-703.0,"
   #      @info.z_motion = "-109.0,-281.0,-140.0,-281.0,-203.0,156.0,-109.0,-312.0,-203.0,-218.0,-265.0,-140.0,-78.0,-281.0,-281.0,-296.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"


   #      # Curl 10
   #      @info.x_motion = "593.0,265.0,515.0,796.0,-62.0,812.0,1140.0,859.0,859.0,890.0,1046.0,625.0,"
   #      @info.y_motion = "-468.0,-203.0,-328.0,-812.0,890.0,-1125.0,-1296.0,-1500.0,-1250.0,-1171.0,-703.0,-812.0,"
   #      @info.z_motion = "-78.0,31.0,-46.0,-234.0,328.0,-343.0,-218.0,-250.0,-359.0,-421.0,-359.0,-390.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Curl"
   #      tally +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"

   #      # Row 10
   #      @info.x_motion = "500.0,796.0,671.0,375.0,953.0,671.0,578.0,750.0,734.0,734.0,265.0,781.0,750.0,296.0,937.0,828.0,312.0,906.0,500.0,671.0,"
   #      @info.y_motion = "-671.0,-1187.0,-906.0,-265.0,-875.0,-703.0,-593.0,-750.0,-640.0,-796.0,-156.0,-890.0,-843.0,-296.0,-828.0,-687.0,-93.0,-828.0,-1062.0,-703.0,"
   #      @info.z_motion = "-187.0,-203.0,-109.0,109.0,-250.0,31.0,109.0,-62.0,46.0,-125.0,234.0,-156.0,-109.0,171.0,-171.0,-109.0,343.0,-125.0,-515.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"
   #      # Row 10
   #      @info.x_motion = "500.0,843.0,953.0,625.0,625.0,828.0,1062.0,828.0,500.0,1062.0,828.0,875.0,609.0,953.0,921.0,562.0,656.0,"
   #      @info.y_motion = "-953.0,-984.0,-1250.0,-765.0,-671.0,-781.0,-859.0,-812.0,-359.0,-1031.0,-765.0,-843.0,-359.0,-890.0,-843.0,-640.0,-734.0,"
   #      @info.z_motion = "-140.0,-468.0,-437.0,93.0,109.0,-15.0,-281.0,0.0,46.0,-390.0,-78.0,46.0,46.0,-218.0,-187.0,-296.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"

   #      # Row 10
   #      @info.x_motion = "625.0,515.0,1218.0,1359.0,1421.0,-171.0,-171.0,1265.0,1265.0,1390.0,640.0,687.0,"
   #      @info.y_motion = "-921.0,-687.0,-1343.0,-1406.0,-1234.0,343.0,250.0,-1265.0,-1125.0,-1421.0,-578.0,-703.0,"
   #      @info.z_motion = "-46.0,0.0,-265.0,-375.0,-515.0,484.0,312.0,-109.0,-109.0,-15.0,-421.0,-312.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Row"
   #      tally +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"

       

   #      # Press 10
   #      @info.x_motion = "703.0,1296.0,796.0,1250.0,875.0,1062.0,906.0,1468.0,750.0,1062.0,765.0,1062.0,1140.0,1000.0,1015.0,968.0,1093.0,921.0,1234.0,937.0,984.0,875.0,875.0,687.0,796.0,671.0,"
   #      @info.y_motion = "-734.0,-234.0,-46.0,93.0,109.0,125.0,78.0,234.0,0.0,-15.0,31.0,46.0,-15.0,0.0,62.0,62.0,93.0,15.0,78.0,15.0,78.0,-31.0,46.0,-859.0,-671.0,-703.0,"
   #      @info.z_motion = "-156.0,-265.0,0.0,-140.0,-109.0,-62.0,0.0,-62.0,-62.0,-46.0,-46.0,-125.0,-46.0,-62.0,0.0,-125.0,-78.0,-187.0,-46.0,-203.0,-46.0,-203.0,218.0,-328.0,-281.0,-296.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"

   #      # Press 10
   #      @info.x_motion = "687.0,265.0,1312.0,796.0,593.0,718.0,812.0,1406.0,1015.0,593.0,1343.0,750.0,1281.0,562.0,1578.0,937.0,1062.0,1000.0,765.0,640.0,"
   #      @info.y_motion = "125.0,46.0,328.0,156.0,109.0,156.0,171.0,515.0,187.0,187.0,687.0,78.0,421.0,187.0,468.0,171.0,234.0,328.0,62.0,-718.0,"
   #      @info.z_motion = "-62.0,-31.0,15.0,-62.0,-140.0,-31.0,46.0,-234.0,-156.0,-171.0,0.0,-78.0,0.0,-140.0,-62.0,-203.0,46.0,-109.0,-31.0,-250.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"

   #       # Press 10
   #      @info.x_motion = "687.0,390.0,796.0,1343.0,62.0,375.0,218.0,781.0,843.0,953.0,1687.0,1984.0,781.0,687.0,718.0,"
   #      @info.y_motion = "62.0,-109.0,-15.0,-15.0,203.0,15.0,109.0,-218.0,-234.0,-281.0,62.0,-78.0,-234.0,-890.0,-671.0,"
   #      @info.z_motion = "156.0,-312.0,-31.0,140.0,-156.0,-265.0,-250.0,-156.0,-171.0,-31.0,-140.0,-375.0,-281.0,-234.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)

   #      correct += 1 if @info.exercise_name == "Shoulder Press"
   #      tally +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"


   #      p "Mainly Rotated Results: "
   #      #Mainly Rotated Results ===================
   #      correct_rot = 0
   #      tally_rot = 0

   #      # Curl
   #      # @info.x_motion = "1000.0,828.0,1125.0,1250.0,0.0,1234.0,-281.0,953.0,1203.0,500.0,1312.0,468.0,921.0,656.0,"
   #      # @info.y_motion = "-328.0,-375.0,-109.0,-46.0,-718.0,-156.0,-718.0,-312.0,-234.0,-546.0,0.0,-671.0,-296.0,-750.0,"
   #      # @info.z_motion = "-218.0,-125.0,-109.0,-187.0,-15.0,-203.0,78.0,-140.0,-140.0,-46.0,-171.0,-140.0,-234.0,-265.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Curl"
   #      # tally_rot +=1
   #      # p "Curl"

   #      # # Press
   #      # @info.x_motion = "671.0,656.0,1593.0,562.0,1265.0,968.0,765.0,1000.0,1140.0,640.0,1250.0,578.0,1015.0,984.0,640.0,921.0,468.0,656.0,656.0,"
   #      # @info.y_motion = "-421.0,-171.0,-156.0,-31.0,-140.0,62.0,93.0,31.0,-109.0,-62.0,-62.0,31.0,-265.0,-250.0,-234.0,-46.0,-1109.0,-734.0,-734.0,"
   #      # @info.z_motion = "15.0,-31.0,-390.0,-171.0,-109.0,15.0,-78.0,15.0,-93.0,-171.0,-109.0,-125.0,-93.0,-203.0,-234.0,-140.0,-140.0,-265.0,-265.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally_rot +=1
   #      # p "Shoulder Press"

   #      # # Curl
   #      # @info.x_motion = "-187.0,1140.0,1125.0,1125.0,921.0,1203.0,750.0,421.0,1218.0,703.0,1187.0,937.0,718.0,703.0,"
   #      # @info.y_motion = "-671.0,-640.0,-671.0,-703.0,-343.0,-468.0,-781.0,-765.0,-562.0,-734.0,-609.0,-703.0,-734.0,-718.0,"
   #      # @info.z_motion = "93.0,-250.0,-343.0,-312.0,-93.0,-187.0,-140.0,-125.0,-281.0,-187.0,-375.0,-359.0,-265.0,-265.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Curl"
   #      # tally_rot +=1
   #      # p "Curl"

   #      # # Row
   #      # @info.x_motion = "750.0,1265.0,656.0,406.0,-203.0,-171.0,843.0,734.0,250.0,500.0,437.0,750.0,796.0,687.0,"
   #      # @info.y_motion = "-515.0,-875.0,-796.0,-578.0,-15.0,-109.0,-937.0,-750.0,-484.0,-640.0,-453.0,-843.0,-578.0,-734.0,"
   #      # @info.z_motion = "-281.0,-531.0,-453.0,-453.0,-296.0,-343.0,-531.0,-562.0,-421.0,-578.0,-500.0,-515.0,-250.0,-265.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Row"
   #      # tally_rot +=1
   #      # p "Row"


   #      # # Press
   #      # @info.x_motion = "437.0,46.0,609.0,718.0,1250.0,703.0,437.0,953.0,765.0,687.0,937.0,593.0,718.0,937.0,328.0,375.0,"
   #      # @info.y_motion = "-859.0,-843.0,-468.0,-468.0,-1312.0,-687.0,-390.0,-593.0,-421.0,-281.0,-656.0,-484.0,-437.0,-531.0,-1156.0,-937.0,"
   #      # @info.z_motion = "-281.0,-500.0,-234.0,-312.0,-453.0,-109.0,-203.0,-375.0,-187.0,-265.0,-234.0,-140.0,-250.0,-343.0,-296.0,-296.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally_rot +=1
   #      # p "Shoulder Press"

   #      # # 
   #      # @info.x_motion = "1125.0,968.0,1234.0,1250.0,656.0,1359.0,1062.0,-312.0,1156.0,31.0,1203.0,-312.0,687.0,1234.0,875.0,687.0,"
   #      # @info.y_motion = "-609.0,-437.0,-296.0,-234.0,-625.0,-46.0,-343.0,-546.0,-250.0,-656.0,-78.0,-671.0,-750.0,-234.0,-484.0,-703.0,"
   #      # @info.z_motion = "-312.0,-78.0,-140.0,-93.0,-93.0,-296.0,-234.0,125.0,-140.0,93.0,-62.0,93.0,-125.0,-93.0,-234.0,-265.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Curl"
   #      # tally_rot +=1
   #      # p "Curl"

   #      # # 
   #      # @info.x_motion = " 750.0,1281.0,859.0,953.0,968.0,1281.0,859.0,515.0,859.0,984.0,500.0,1125.0,515.0,1015.0,1359.0,640.0,1031.0,937.0,656.0,"
   #      # @info.y_motion = "-734.0,-562.0,-468.0,-437.0,-312.0,-562.0,-343.0,-187.0,-375.0,-546.0,-203.0,-484.0,-406.0,-421.0,-546.0,-312.0,-265.0,-484.0,-750.0,"
   #      # @info.z_motion = "-140.0,-234.0,-453.0,-234.0,-187.0,-500.0,-296.0,-234.0,-343.0,-281.0,-265.0,-78.0,-281.0,-203.0,-437.0,-421.0,-296.0,-203.0,-296.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally_rot +=1
   #      # p "Shoulder Press"

   #      # # 
   #      # @info.x_motion = "312.0,-109.0,359.0,375.0,453.0,515.0,421.0,375.0,406.0,109.0,406.0,515.0,437.0,562.0,671.0,"
   #      # @info.y_motion = "-890.0,-140.0,-1156.0,-1281.0,-1421.0,-1234.0,-1015.0,-953.0,-953.0,-656.0,-750.0,-1203.0,-1093.0,-546.0,-703.0,"
   #      # @info.z_motion = "-484.0,-187.0,-609.0,-578.0,-703.0,-765.0,-781.0,-703.0,-828.0,-468.0,-718.0,-781.0,-625.0,-296.0,-281.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Row"
   #      # tally_rot +=1
   #      # p "Row"

   #      # # 
   #      # @info.x_motion = "546.0,-46.0,734.0,-125.0,1140.0,281.0,1031.0,140.0,1000.0,312.0,1078.0,109.0,953.0,359.0,984.0,343.0,609.0,796.0,765.0,"
   #      # @info.y_motion = "-625.0,-859.0,-921.0,-703.0,-375.0,-937.0,-468.0,-750.0,-656.0,-750.0,-234.0,-750.0,-500.0,-859.0,-406.0,-765.0,-796.0,-421.0,-656.0,"
   #      # @info.z_motion = " -421.0,-78.0,-390.0,15.0,-218.0,-62.0,-187.0,-31.0,-203.0,-125.0,-234.0,-62.0,-203.0,-93.0,-328.0,-140.0,-171.0,-187.0,-171.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Curl"
   #      # tally_rot +=1
   #      # p "Curl"

   #      # # 
   #      # @info.x_motion = "1125.0,1281.0,1140.0,937.0,515.0,1375.0,1234.0,187.0,-484.0,921.0,1265.0,203.0,531.0,1406.0,750.0,671.0,"
   #      # @info.y_motion = "-640.0,-421.0,-531.0,-515.0,-546.0,-515.0,-406.0,-375.0,-359.0,-343.0,-296.0,-531.0,-562.0,-250.0,-609.0,-703.0,"
   #      # @info.z_motion = "-250.0,-250.0,-218.0,-125.0,-125.0,-156.0,-265.0,93.0,281.0,-46.0,-203.0,46.0,-62.0,-171.0,-296.0,-250.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Curl"
   #      # tally_rot +=1
   #      # p "Curl"

   #      # # 
   #      # @info.x_motion = "531.0,1046.0,906.0,984.0,937.0,796.0,843.0,968.0,968.0,1109.0,906.0,1109.0,718.0,1203.0,640.0,1203.0,687.0,953.0,1000.0,625.0,"
   #      # @info.y_motion = "-656.0,-390.0,-156.0,-93.0,-109.0,0.0,-203.0,-46.0,-187.0,-281.0,-156.0,-265.0,-218.0,-390.0,-218.0,-296.0,46.0,31.0,-484.0,-703.0,"
   #      # @info.z_motion = "-140.0,-281.0,-406.0,-343.0,-328.0,-171.0,-250.0,-234.0,-265.0,-296.0,-218.0,-203.0,-187.0,-250.0,-171.0,-171.0,-234.0,-187.0,-31.0,-281.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally_rot +=1
   #      # p "Shoulder Press"

   #      # # 
   #      # @info.x_motion = "687.0,734.0,1281.0,906.0,437.0,500.0,1250.0,1703.0,625.0,484.0,609.0,1468.0,1156.0,453.0,1031.0,515.0,671.0,"
   #      # @info.y_motion = "-1078.0,-359.0,-468.0,-375.0,-359.0,-265.0,-328.0,109.0,-109.0,-203.0,-109.0,-500.0,-359.0,-140.0,-234.0,-640.0,-750.0,"
   #      # @info.z_motion = "31.0,-234.0,-406.0,-359.0,-140.0,-312.0,-218.0,-453.0,-281.0,-203.0,-125.0,-375.0,-203.0,-156.0,-265.0,156.0,-281.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Shoulder Press"
   #      # tally_rot +=1
   #      # p "Shoulder Press"

   #      # # 
   #      # @info.x_motion = "390.0,250.0,296.0,218.0,296.0,140.0,-78.0,203.0,203.0,-31.0,359.0,140.0,125.0,218.0,234.0,-93.0,281.0,406.0,718.0,671.0,"
   #      # @info.y_motion = "-625.0,-843.0,-1031.0,-843.0,-1078.0,-953.0,-375.0,-968.0,-1000.0,-703.0,-1296.0,-937.0,-796.0,-765.0,-937.0,-250.0,-765.0,-906.0,-843.0,-734.0,"
   #      # @info.z_motion = "-531.0,-437.0,-546.0,-562.0,-421.0,-734.0,-437.0,-640.0,-625.0,-421.0,-640.0,-609.0,-656.0,-640.0,-593.0,-234.0,-796.0,-250.0,-359.0,-281.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Row"
   #      # tally_rot +=1
   #      # p "Row"

   #      # # 
   #      # @info.x_motion = "484.0,531.0,703.0,734.0,687.0,843.0,890.0,1031.0,625.0,265.0,750.0,921.0,703.0,687.0,"
   #      # @info.y_motion = "-515.0,-828.0,-1125.0,-1203.0,-1000.0,-968.0,-906.0,-1156.0,-796.0,-515.0,-1093.0,-890.0,-437.0,-640.0,"
   #      # @info.z_motion = "-500.0,-640.0,-718.0,-921.0,-734.0,-656.0,-593.0,-921.0,-843.0,-625.0,-734.0,-1093.0,-312.0,-265.0,"
   #      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      # correct_rot += 1 if @info.exercise_name == "Row"
   #      # tally_rot +=1
   #      # p "Row"

   #      correct_old = 0
   #      tally_old = 0
   #      # 
   #      # @info.x_motion = ""
   #      # @info.y_motion = ""
   #      # @info.z_motion = ""

   #      # 
   #      # @info.x_motion = ""
   #      # @info.y_motion = ""
   #      # @info.z_motion = ""

   #      # 
   #      # @info.x_motion = ""
   #      # @info.y_motion = ""
   #      # @info.z_motion = ""

   #      # Row 12
   #      @info.x_motion = "468.0,437.0,671.0,578.0,906.0,562.0,218.0,640.0,531.0,234.0,640.0,546.0,234.0,531.0,593.0,328.0,781.0,453.0,140.0,687.0,625.0,671.0,"
   #      @info.y_motion = "-1015.0,-921.0,-1156.0,-593.0,-1171.0,-1046.0,-296.0,-1140.0,-1109.0,-328.0,-1156.0,-1156.0,-265.0,-968.0,-1046.0,-453.0,-1125.0,-859.0,-156.0,-875.0,-625.0,-718.0,"
   #      @info.z_motion = "-93.0,-15.0,-187.0,-109.0,-546.0,-203.0,390.0,-343.0,-125.0,218.0,-406.0,-375.0,265.0,-62.0,-187.0,265.0,-468.0,234.0,500.0,-296.0,-218.0,-296.0," 
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      correct_old += 1 if @info.exercise_name == "Row"
   #      tally_old +=1
   #      p "Row"
   #      error += [(@info.reps_counted.to_i- 12).abs / 12.0]
   #      p"12"


   #      # Press 12
   #      @info.x_motion = "718.0,218.0,484.0,218.0,375.0,484.0,312.0,250.0,687.0,218.0,359.0,437.0,218.0,484.0,484.0,343.0,703.0,312.0,171.0,531.0,796.0,656.0,"
   #      @info.y_motion = "-453.0,562.0,1375.0,687.0,875.0,984.0,750.0,796.0,1500.0,671.0,812.0,921.0,515.0,906.0,1046.0,781.0,1265.0,531.0,609.0,171.0,-656.0,-750.0,"
   #      @info.z_motion = "31.0,-46.0,187.0,0.0,156.0,171.0,109.0,109.0,187.0,62.0,93.0,93.0,-109.0,234.0,78.0,-281.0,203.0,-46.0,-203.0,156.0,-187.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      correct_old += 1 if @info.exercise_name == "Shoulder Press"
   #      tally_old +=1
   #      p "Shoulder Press"
   #      error += [(@info.reps_counted.to_i- 12).abs / 12.0]
   #      p"12"
   #      # Curl 5 
   #      @info.x_motion = "703.0,1140.0,1171.0,593.0,781.0,1125.0,546.0,1031.0,921.0,1250.0,718.0,671.0,"
   #      @info.y_motion = "515.0,-93.0,-93.0,453.0,343.0,-125.0,421.0,-31.0,328.0,93.0,-593.0,-718.0,"
   #      @info.z_motion = "125.0,-171.0,-46.0,125.0,15.0,-156.0,109.0,-62.0,62.0,-218.0,-203.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      correct_old += 1 if @info.exercise_name == "Curl"
   #      tally_old +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 5).abs / 5.0]
   #      p"5"

   #      # Curl 7 
   #      @info.x_motion = "1000.0,1062.0,875.0,1218.0,734.0,953.0,-125.0,906.0,125.0,1000.0,1046.0,937.0,1062.0,656.0,"
   #      @info.y_motion = "-453.0,-31.0,15.0,-265.0,93.0,-609.0,765.0,-828.0,765.0,-750.0,-156.0,-31.0,-265.0,-765.0,"
   #      @info.z_motion = "-265.0,-125.0,-31.0,-218.0,15.0,-281.0,328.0,-171.0,343.0,-328.0,-140.0,-109.0,-359.0,-250.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      correct_old += 1 if @info.exercise_name == "Curl"
   #      tally_old +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 7).abs / 7.0]
   #      p"7"

   #      # Curl 9 
   #      @info.x_motion = "234.0,1203.0,984.0,1078.0,1062.0,-93.0,1203.0,1062.0,640.0,1000.0,1000.0,625.0,1218.0,437.0,703.0,671.0,671.0,"
   #      @info.y_motion = "625.0,-562.0,-31.0,-15.0,-625.0,703.0,-296.0,0.0,-46.0,-890.0,156.0,187.0,-500.0,250.0,-562.0,-625.0,-734.0,"
   #      @info.z_motion = "171.0,-218.0,-125.0,-125.0,-250.0,328.0,-125.0,-78.0,78.0,-218.0,15.0,-31.0,-296.0,31.0,-234.0,-265.0,-281.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
   #      correct_old += 1 if @info.exercise_name == "Curl"
   #      tally_old +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 9).abs / 9.0]
   #      p"9"

   #      # Curl 10 ( a fast)
   #      @info.x_motion = "656.0,-15.0,281.0,812.0,140.0,125.0,687.0,578.0,265.0,-62.0,-187.0,218.0,0.0,0.0,"
   #      @info.y_motion = "-671.0,-500.0,-468.0,-781.0,-765.0,-640.0,-593.0,-578.0,-546.0,-468.0,-125.0,-312.0,0.0,0.0,"
   #      @info.z_motion = "390.0,-1703.0,-812.0,1546.0,1625.0,1562.0,1578.0,1234.0,1281.0,1046.0,-1437.0,578.0,1000.0,1015.0,"
   #      @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
   #      @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, "Curl")
   #      correct_old += 1 if @info.exercise_name == "Curl"
   #      tally_old +=1
   #      p "Curl"
   #      error += [(@info.reps_counted.to_i- 10).abs / 10.0]
   #      p"10"
# ########################################################################
      # x = Algorithm.array_string_to_array("")
      # y = Algorithm.array_string_to_array("")
      # z = Algorithm.array_string_to_array("")

      # x = Algorithm.array_string_to_array("234.0,1203.0,984.0,1078.0,1062.0,-93.0,1203.0,1062.0,640.0,1000.0,1000.0,625.0,1218.0,437.0,703.0,671.0,671.0,")
      # y = Algorithm.array_string_to_array("625.0,-562.0,-31.0,-15.0,-625.0,703.0,-296.0,0.0,-46.0,-890.0,156.0,187.0,-500.0,250.0,-562.0,-625.0,-734.0,")
      # z = Algorithm.array_string_to_array("171.0,-218.0,-125.0,-125.0,-250.0,328.0,-125.0,-78.0,78.0,-218.0,15.0,-31.0,-296.0,31.0,-234.0,-265.0,-281.0,")

 		# x = Algorithm.array_string_to_array("843.0,812.0,828.0,1000.0,1218.0,843.0,953.0,828.0,843.0,765.0,")
   #    y = Algorithm.array_string_to_array("-453.0,-406.0,-500.0,-625.0,-640.0,-406.0,-375.0,-390.0,-437.0,-421.0,")
   #    z = Algorithm.array_string_to_array("-187.0,-234.0,-156.0,-234.0,-218.0,-62.0,-187.0,-281.0,-203.0,-125.0,")
      # p "TEST"
      # p Algorithm.is_not_walking?(x,y,z)
      # p "TEST"
# ########################################################################
      # @info.exercise_name = @info.classify_exercise(@info.x_motion,@info.y_motion,@info.z_motion)
      # @info.reps_counted = Rep.rep_predict(@info.x_motion,@info.y_motion,@info.z_motion, @info.exercise_name)
      # @info.save
        
	    @data = Ibeacon.all

   #      end_time = Time.now
   #      p "this took: " + (end_time - beginning_time).to_s + "  seconds!"
   #      p "========================"
   #      p "Master Score Normal: " + correct.to_s + " / " + tally.to_s
   #      p "========================"
   #      p "Master Score Rotated: " + correct_rot.to_s + " / " + tally_rot.to_s
   #      p "========================"
   #      p "Master Score Old: " + correct_old.to_s + " / " + tally_old.to_s
   #      p "========================"
   #      p "Reps On the Money: " + error.count(0.0).to_s + " / " + error.length.to_s
   #      p error
   #      p "Average Rep Error %: " + (100*error.mean).to_s
   #      p "========================"
	end
	
	def new
	end
	
	def create
      x = Algorithm.array_string_to_array(beacon_params["x_motion"])
      y = Algorithm.array_string_to_array(beacon_params["y_motion"])
      z = Algorithm.array_string_to_array(beacon_params["z_motion"])
      if Algorithm.is_not_walking?(x,y,z) || x.length >= 6 || Rep.rep_predict(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"], "Shoulder Press") >= 1
   		@info = Ibeacon.new 
   		@info.x_motion = beacon_params["x_motion"]
    		@info.y_motion = beacon_params["y_motion"]
    		@info.z_motion = beacon_params["z_motion"]
    		@info.exercise_name = @info.classify_exercise(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"])
    		@info.reps_counted = Rep.rep_predict(beacon_params["x_motion"],beacon_params["y_motion"],beacon_params["z_motion"], @info.exercise_name)
    		@info.save
      end
		redirect_to ibeacons_path
	end
	
	
	private
	
	def beacon_params
		params.require(:ibeacon).permit(:x_motion, :y_motion, :z_motion)
	end 
end
