data_string = "You're moving a Optional(10.0) Lb Dumbbell
1343, 468, -62, 0.000151991844177246.
Sticker is not moving
-234, -515, 187, 0.999909996986389.
Sticker is not moving
-625, -1187, 296, 1.9994740486145.
Sticker is not moving
-718, -1484, 578, 3.00044000148773.
Sticker is not moving
-531, -1078, 359, 3.99981796741486.
Sticker is not moving
-437, -859, 359, 5.00004100799561.
Sticker is not moving
-468, -859, 296, 6.00029098987579.
Sticker is not moving
-437, -781, 281, 7.00035405158997.
Sticker is not moving
-109, -421, 62, 8.00048208236694.
Sticker is not moving
-328, -281, 203, 9.00038206577301.
Sticker is not moving
-468, -937, 234, 10.0004240274429.
Sticker is not moving
-609, -1156, 500, 11.0004600286484.
Sticker is not moving
-625, -1125, 328, 12.0004270076752.
Sticker is not moving
1062, 62, -78, 13.0004160404205.
Sticker is not moving
968, -140, 15, 13.9992040395737.
Sticker is not moving
That dumbbell is no longer moving, You're probably resting, huh?"
data_array = []
old_data_array = data_string.split("\n")
old_data_array.each_with_index do |item,index| 
  if (index % 2 == 1 && index + 1 != old_data_array.length) then 
    data_array.push(item.chop) 
  end
end
# p data_array

x_arr = []
data_array.each_with_index do |item,index| 
    x_arr.push(item.split(",")[0] + ".0") 
end
p x_arr.join(",") + ","

y_arr = []
data_array.each_with_index do |item,index| 
    y_arr.push(item.split(",")[1] + ".0") 
end
p y_arr.join(",") + ","

z_arr = []
data_array.each_with_index do |item,index| 
    z_arr.push(item.split(",")[2] + ".0") 
end
p z_arr.join(",") + ","


