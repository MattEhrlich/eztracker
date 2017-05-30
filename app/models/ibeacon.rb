class Ibeacon < ApplicationRecord
    require 'matrix.rb'
    require 'polynomial'
    require 'ruby-prof'
    require 'rubystats'
    require 'nmatrix'
    require './lib/algorithm.rb'


    def classify_exercise(x,y,z)
        # RubyProf.start
        # p Algorithm.array_string_to_array("531.0,-31.0,-125.0,265.0,-281.0,375.0,250.0,-437.0,359.0,-171.0,-46.0,-156.0,-46.0,")
        
        # curl1
        x1 = Algorithm.ranging([[531.0,-31.0,-125.0,265.0,-281.0,375.0,250.0,-437.0,359.0,-171.0,-46.0,-156.0,-46.0]])
        y1 = Algorithm.ranging([[ -593.0,-406.0,-125.0,-546.0,140.0,-625.0,-531.0,62.0,-531.0,62.0,-93.0,281.0,0.0]])
        z1 = Algorithm.ranging([[843.0,1531.0,1031.0,1312.0,468.0,1312.0,1078.0,-703.0,1281.0,750.0,984.0,890.0,1015.0]])

        # press1
        x2 = Algorithm.ranging([[-984.0,0.0,-156.0,234.0,281.0,-687.0,-234.0,62.0,125.0,-171.0,-62.0,-656.0,-62.0]])
        y2 = Algorithm.ranging([[-140.0,843.0,1421.0,1093.0,812.0,1078.0,546.0,1031.0,1109.0,750.0,828.0,609.0,-234.0]])
        z2 = Algorithm.ranging([[171.0,-593.0,-718.0,-484.0,-328.0,-578.0,-296.0,-546.0,-453.0,-593.0,-625.0,640.0,1031.0]])

        # row1
        x3 = Algorithm.ranging([[62.0,875.0,421.0,546.0,1203.0,1062.0,734.0,1203.0,671.0,781.0,656.0,937.0,796.0]])
        y3 = Algorithm.ranging([[-968.0,-843.0,-1000.0,-750.0,-437.0,-687.0,-421.0,-421.0,-78.0,-296.0,-171.0,-265.0,-109.0]])
        z3 = Algorithm.ranging([[359.0,609.0,796.0,562.0,671.0,500.0,156.0,250.0,281.0,781.0,390.0,468.0,718.0]])
        # row2
        # xx = Algorithm.ranging([[-109.0,703.0,375.0,359.0,437.0,796.0,250.0,531.0,640.0,406.0,171.0,328.0,328.0]])
        # yy = Algorithm.ranging([[-406.0,-843.0,-890.0,-375.0,-796.0,-1046.0,140.0,-281.0,-1078.0,-953.0,-296.0,-484.0,-1000.0]])
        # zz = Algorithm.ranging([[1000.0,828.0,515.0,453.0,703.0,796.0,656.0,406.0,984.0,812.0,484.0,671.0,609.0]])


        # # press2
        # xx = Algorithm.ranging([[234.0,-515.0,-687.0,-218.0,-93.0,-218.0,-187.0,-187.0,-78.0,-328.0,-156.0,-46.0,-421.0]])
        # yy = Algorithm.ranging([[ -500.0,-343.0,125.0,625.0,1218.0,515.0,968.0,953.0,625.0,781.0,953.0,546.0,203.0]])
        # zz = Algorithm.ranging([[890.0,406.0,-328.0,-421.0,-890.0,-453.0,-406.0,-671.0,-515.0,-390.0,-437.0,-296.0,1046.0]])

        # curl2
        # xx = Algorithm.ranging([[140.0,-125.0,-125.0,-421.0,-312.0,-93.0,-250.0,-187.0,250.0,-312.0,281.0,-15.0,-421.0]])
        # yy = Algorithm.ranging([[-546.0,62.0,-531.0,0.0,359.0,-421.0,171.0,-156.0,-531.0,343.0,-109.0,-296.0,578.0]])
        # zz = Algorithm.ranging([[593.0,968.0,1281.0,1406.0,812.0,1390.0,546.0,1187.0,1390.0,656.0,1171.0,1500.0,687.0]])

        # mysterydata1 (curl)
        # xx = Algorithm.ranging([[328.0,593.0,1328.0,-62.0,453.0,-453.0,-578.0,-46.0,265.0,187.0,796.0,968.0,265.0]])
        # yy = Algorithm.ranging([[-562.0,-468.0,-828.0,-265.0,-578.0,-343.0,-390.0,-156.0,-218.0,-250.0,-640.0,-687.0,-78.0]])
        # zz = Algorithm.ranging([[890.0,812.0,-31.0,125.0,-187.0,-2000.0,-2000.0,-1718.0,859.0,265.0,1031.0,1640.0,609.0]])

        # mysterydata2 (press)
        # xx = Algorithm.ranging([[421.0,-593.0,-750.0,-1140.0,-1359.0,-1343.0,-640.0,-1140.0,-921.0,-718.0,-859.0,-796.0,-546.0]])
        # yy = Algorithm.ranging([[-640.0,-250.0,-1171.0,390.0,-1468.0,281.0,343.0,93.0,343.0,265.0,500.0,359.0,671.0]])
        # zz = Algorithm.ranging([[890.0,-343.0,343.0,-187.0,703.0,296.0,-406.0,-156.0,-140.0,-437.0,-265.0,-218.0,-375.0]])

        #mysterydata

        xx = Algorithm.ranging([Algorithm.array_string_to_array(x)])
        yy = Algorithm.ranging([Algorithm.array_string_to_array(y)])
        zz = Algorithm.ranging([Algorithm.array_string_to_array(z)])

        choices = ["Curl","Shoulder Press","Row"]

        pol = 4
        pol2 = 4

        beginning_time = Time.now
        p "========================"
        big_1 = x1.transpose
        big_1 = (big_1.transpose << y1[0]).transpose
        big_1 = (big_1.transpose << z1[0]).transpose

        big_2 = x2.transpose
        big_2 = (big_2.transpose << y2[0]).transpose
        big_2 = (big_2.transpose << z2[0]).transpose

        big_3 = x3.transpose
        big_3 = (big_3.transpose << y3[0]).transpose
        big_3 = (big_3.transpose << z3[0]).transpose

        big_4 = xx.transpose
        big_4 = (big_4.transpose << yy[0]).transpose
        big_4 = (big_4.transpose << zz[0]).transpose
        data = big_4 + big_1 + big_2 + big_3

        data = Algorithm.feature_matrix(data.transpose).transpose
        logistic_guess = Algorithm.nonlinear_logistic_regression_tester(choices ,data,pol,pol2, [xx[0].length, x1[0].length, x2[0].length, x3[0].length])
        p "Exercise is a: " + choices[logistic_guess].to_s
        end_time = Time.now
        p "this took: " + (end_time - beginning_time).to_s + "  seconds!"
        p "========================"
        return choices[logistic_guess].to_s
        # result = RubyProf.stop
        # printer = RubyProf::CallStackPrinter.new(result)
        # File.open("tmp/profile_data2.html", 'w') { |file| printer.print(file) }
    end

    def rep_count(x,y,z)
        x = Algorithm.array_string_to_array(x)
        y = Algorithm.array_string_to_array(y)
        z = Algorithm.array_string_to_array(z)
        mags2 = [] 
        (1..((x.length) - 1)).each do |i|
            mags2 = mags2 + [Algorithm.angle(N[[x[i],y[i],z[i]]],N[[x[i-1],y[i-1],z[i-1]]])]
        end 
        p mags2
        return Algorithm.minz(mags2)
    end
end
