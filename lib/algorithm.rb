require 'matrix.rb'
require 'polynomial'
require 'ruby-prof'
require 'rubystats'
require 'nmatrix'
class Array

        def sum
          self.inject(0){|accum, i| accum + i }
        end

        def mean
          self.sum/self.length.to_f
        end

        def sample_variance
          m = self.mean
          sum = self.inject(0){|accum, i| accum +(i-m)**2 }
          sum /(self.length - 1).to_f
        end

        def standard_deviation
          return Math.sqrt(self.sample_variance)
        end

    end 
class Algorithm
    def self.sigmoid_function(g)
        return 1.0/(1.0 + Math.exp(-g))
    end

    def self.feature_normalize(x)
        sd = x.standard_deviation
        mean = x.mean
        return x.collect { |e| (e - mean) / sd}
    end
    def self.feature_matrix(x)
        final = []
        (0..(x.length - 1)).each do |i|
            x[i] = Algorithm.feature_normalize(x[i])
        end
        return x
    end

    def self.y_sort(x_length,choice_length,position)
        y = []
        (0..(x_length - 1)).each do |i|
            if ((i /  (x_length / choice_length)) == position)
                y = y + [1.0]
            else
                y = y + [0.0]
            end
        end
        return y
    end
    def self.num_reg(num)
        if num > 0.99999999   
            return 0.9999999
        elsif num < 0.0000001
              return 0.0000001
        else
            return num
        end
    end
    def self.reg(l)
        (0..(l.length - 1)).each do |row|
            l[row] = l[row].collect { |e| Algorithm.num_reg(e)}
        end
        return l
    end

    def self.compute_cost_multi_logistic(theta,x,y)# input as a array
        m = x.length
        matrix_x = N[*x]
        matrix_y = N[*y]
        matrix_t = N[*theta]
        predictions = (matrix_x.dot(matrix_t)).collect{ |e| Algorithm.num_reg(Algorithm.sigmoid_function(e)) }
        j1 = (matrix_y.collect{ |e| -1*e }).transpose.dot(predictions.collect{|e| Math.log(e)})
        j2 = (matrix_y.collect{ |e| 1 - e }).transpose.dot(predictions.collect{ |e| Math.log(1 - e) })
        j = (j1 - j2).to_a

        return j[0].mean / (1.0*m)

    end
    def self.compute_cost_multi_logistic_df(matrix_t,matrix_x,matrix_y) # input as a array
        predictions = N[(matrix_x.dot(matrix_t)).collect{ |e| Algorithm.num_reg(Algorithm.sigmoid_function(e)) }].transpose
        return matrix_x.transpose.dot(matrix_y - predictions)
    end
    def self.hessian(x) # input as a matrix
        return x.transpose.dot(x)
    end
    def self.polyfunc(x,y,pol)
            matrix_x = N[*x]
            matrix_y = N[*y]
            matrix_theta = N.zeros([matrix_x.cols,1])
            i = 0
            i_max = 200
            r = -Algorithm.compute_cost_multi_logistic_df(matrix_theta,matrix_x,matrix_y)
            # p "r"
            d = r
            # p r
            alphastore = []
            hess = Algorithm.hessian(matrix_x)
            while (i < i_max)
                if i% i_max==0
                    # curr = Algorithm.compute_cost_multi_logistic(matrix_theta.to_a,matrix_x.to_a,matrix_y.to_a)
                    # p "cost at iter" + i.to_s + " is :" + curr.to_s
                    # TODO: check logistic_df, and make sure poly functions are actually doing their jobs!
                end
                alpha = ((-r.transpose.dot(d)) /  (( d.transpose.dot(hess)).dot( d) ))[0,0]
                alphastore = alphastore+[alpha]
                # p "alpha: "
                # p alpha
                matrix_theta = matrix_theta + ( NMatrix.new( [d.rows, d.cols], alpha)*d )
                dr = r
                r = -Algorithm.compute_cost_multi_logistic_df(matrix_theta,matrix_x,matrix_y)
                beta = (r.transpose.dot(r)) / (dr.transpose.dot(dr))
                beta = beta[0,0]
                # p "beta: "
                # p beta
                d = r + ( NMatrix.new( [d.rows, d.cols], beta)*d )
                i += 1
            end
            return N[*matrix_theta.to_a.reverse.transpose]
    end
    def self.power_element(x,p)
        return x.collect{|e| e ** p}
    end

    def self.meshing(x,pol)
        main_final = []
        base_possible = (0..(x[0].length - 1)).to_a
        possible = []
        (2..pol).each do |pow|
            possible.push(*base_possible.repeated_combination(pow).to_a)
        end
        (0..(x.length - 1)).each do |i|
            curr_x = x[i]
            current = [1.0] + curr_x
            possible.each do |block|
                curr_num = 1.0
                block.each do |multi_index|
                    curr_num *= curr_x[multi_index]
                end
                current.push(curr_num)
            end
            main_final.push(current)
        end
        return main_final
    end

    def self.ranging(array)
        l = array[0]
        new_l = l.collect{ |ele| ele / 1224.75}
        return [new_l]
    end

    def self.nonlinear_logistic_regression_tester(choices ,data, pol, pol2)
        results = data[0..16]
        guesses = []
        lead_guess = -1
        lead_prob = 0
        x = Algorithm.meshing(data[17..(data.length-1)],pol2)
        matrix_x = N[*x]
        hess = Algorithm.hessian(matrix_x)
        m = x.length
        (0..(choices.length - 1)).each do |pos|
            matrix_y = N[Algorithm.y_sort(m,choices.length,pos)].transpose
            matrix_theta = N.zeros([matrix_x.cols,1])

            i = 0
            i_max = 100

            # p matrix_x.shape
            # p matrix_y.shape
            # p matrix_theta.shape

            r = -Algorithm.compute_cost_multi_logistic_df(matrix_theta,matrix_x,matrix_y)
            # p "r"
            d = r
            # p r
            alphastore = []
            while (i < i_max)
                if i% i_max==0
                    # curr = Algorithm.compute_cost_multi_logistic(matrix_theta.to_a,matrix_x.to_a,matrix_y.to_a)
                    # p "cost at iter" + i.to_s + " is :" + curr.to_s
                    # TODO: check logistic_df, and make sure poly functions are actually doing their jobs!
                end
                alpha = ((-r.transpose.dot(d)) /  (( d.transpose.dot(hess)).dot( d) ))[0,0]
                alphastore = alphastore+[alpha]
                # p "alpha: "
                # p alpha
                matrix_theta = matrix_theta + ( NMatrix.new( [d.rows, d.cols], alpha)*d )
                dr = r
                r = -Algorithm.compute_cost_multi_logistic_df(matrix_theta,matrix_x,matrix_y)
                beta = (r.transpose.dot(r)) / (dr.transpose.dot(dr))
                beta = beta[0,0]
                # p "beta: "
                # p beta
                d = r + ( NMatrix.new( [d.rows, d.cols], beta)*d )
                i += 1
            end
            z = (Matrix[*Algorithm.meshing(results,pol2)] * Matrix[*matrix_theta.to_a] ).collect{ |e| Algorithm.num_reg(Algorithm.sigmoid_function(e)) }.to_a.transpose[0]
            if lead_prob < z.mean
                lead_guess = pos
                lead_prob = z.mean
            end
            guesses = guesses + [z.mean]
        end
        p guesses

        return lead_guess

    end

    def self.linspace(low, high, num)                                                                                                                  
        return [*0..(num-1)].collect { |i| low + i.to_f * (high-low)/(num-1) }                                                                             
    end
    
    def self.classify
        # RubyProf.start

        # curl1
        x1 = Algorithm.ranging([[531.0,-31.0,-125.0,265.0,-281.0,375.0,250.0,-437.0,359.0,-171.0,-46.0,-156.0,-46.0]])
        y1 = Algorithm.ranging([[ -593.0,-406.0,-125.0,-546.0,140.0,-625.0,-531.0,62.0,-531.0,62.0,-93.0,281.0,0.0]])
        z1 = Algorithm.ranging([[843.0,1531.0,1031.0,1312.0,468.0,1312.0,1078.0,-703.0,1281.0,750.0,984.0,890.0,1015.0]])

        # press1
        x2 = Algorithm.ranging([[-984.0,0.0,-156.0,234.0,281.0,-687.0,-234.0,62.0,125.0,-171.0,-62.0,-656.0,-62.0]])
        y2 = Algorithm.ranging([[-140.0,843.0,1421.0,1093.0,812.0,1078.0,546.0,1031.0,1109.0,750.0,828.0,609.0,-234.0]])
        z2 = Algorithm.ranging([[171.0,-593.0,-718.0,-484.0,-328.0,-578.0,-296.0,-546.0,-453.0,-593.0,-625.0,640.0,1031.0]])

        # row1
        x3 = Algorithm.ranging([[62.0,875.0,421.0,546.0,1203.0,1062.0,734.0,1203.0,671.0,781.0,656.0,937.0,796.0,0.0,-31.0]])
        y3 = Algorithm.ranging([[-968.0,-843.0,-1000.0,-750.0,-437.0,-687.0,-421.0,-421.0,-78.0,-296.0,-171.0,-265.0,-109.0,-156.0,-15.0]])
        z3 = Algorithm.ranging([[359.0,609.0,796.0,562.0,671.0,500.0,156.0,250.0,281.0,781.0,390.0,468.0,718.0,703.0,1031.0]])


        # row2
        # xx = Algorithm.ranging([[-109.0,703.0,375.0,359.0,437.0,796.0,250.0,531.0,640.0,406.0,171.0,328.0,328.0,421.0,-31.0]])
        # yy = Algorithm.ranging([[-406.0,-843.0,-890.0,-375.0,-796.0,-1046.0,140.0,-281.0,-1078.0,-953.0,-296.0,-484.0,-1000.0,-750.0,0.0]])
        # zz = Algorithm.ranging([[1000.0,828.0,515.0,453.0,703.0,796.0,656.0,406.0,984.0,812.0,484.0,671.0,609.0,234.0,1031.0]])


        # # press2
        # xx = Algorithm.ranging([[234.0,-515.0,-687.0,-218.0,-93.0,-218.0,-187.0,-187.0,-78.0,-328.0,-156.0,-46.0,-421.0,-31.0,-46.0]])
        # yy = Algorithm.ranging([[ -500.0,-343.0,125.0,625.0,1218.0,515.0,968.0,953.0,625.0,781.0,953.0,546.0,203.0,0.0,0.0]])
        # zz = Algorithm.ranging([[890.0,406.0,-328.0,-421.0,-890.0,-453.0,-406.0,-671.0,-515.0,-390.0,-437.0,-296.0,1046.0,1015.0,1031.0]])

        # curl2
        # xx = Algorithm.ranging([[140.0,-125.0,-125.0,-421.0,-312.0,-93.0,-250.0,-187.0,250.0,-312.0,281.0,-15.0,-421.0,46.0,-15.0,-31.0]])
        # yy = Algorithm.ranging([[-546.0,62.0,-531.0,0.0,359.0,-421.0,171.0,-156.0,-531.0,343.0,-109.0,-296.0,578.0,-500.0,-656.0,-15.0]])
        # zz = Algorithm.ranging([[593.0,968.0,1281.0,1406.0,812.0,1390.0,546.0,1187.0,1390.0,656.0,1171.0,1500.0,687.0,1359.0,781.0,1031.0]])

        # mysterydata1 (curl)
        # xx = Algorithm.ranging([[328.0,593.0,1328.0,-62.0,453.0,-453.0,-578.0,-46.0,265.0,187.0,796.0,968.0,265.0,265.0,-46.0]])
        # yy = Algorithm.ranging([[-562.0,-468.0,-828.0,-265.0,-578.0,-343.0,-390.0,-156.0,-218.0,-250.0,-640.0,-687.0,-78.0,-78.0,-31.0]])
        # zz = Algorithm.ranging([[890.0,812.0,-31.0,125.0,-187.0,-2000.0,-2000.0,-1718.0,859.0,265.0,1031.0,1640.0,609.0,609.0,1031.0]])

        # mysterydata2 (press)
        xx = Algorithm.ranging([[421.0,-593.0,-750.0,-1140.0,-1359.0,-1343.0,-640.0,-1140.0,-921.0,-718.0,-859.0,-796.0,-546.0,-671.0,-46.0,46.0]])
        yy = Algorithm.ranging([[-640.0,-250.0,-1171.0,390.0,-1468.0,281.0,343.0,93.0,343.0,265.0,500.0,359.0,671.0,546.0,484.0,46.0]])
        zz = Algorithm.ranging([[890.0,-343.0,343.0,-187.0,703.0,296.0,-406.0,-156.0,-140.0,-437.0,-265.0,-218.0,-375.0,-328.0,406.0,1015.0]])




        

        choices = ["Curl","Shoulder Press","Row"]
        correct = 0
        possible = 1

        pol = 4
        pol2 = 4

        beginning_time = Time.now
        (0..(possible - 1)).each do |rep|
            p rep if rep % 10 == 0
            # actual = rand(choices.length)
            # xy = Marshal.load(Marshal.dump(l1[actual]))
            # normal = Rubystats::NormalDistribution.new(1.0, 0.6).rng(xy[0].length - 1)
            # xy_real = [normal.zip(xy[0]).map{|n1, n2| n1 * n2}]
            actual = 0
            # fix data!!!!!!!!
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
            # TODP: figure out multivarble function... dot product a new 
            # meshing func with some theta stuff
            logistic_guess = nonlinear_logistic_regression_tester(choices ,data,pol,pol2)
             if logistic_guess == actual
                correct += 1
                p choices[logistic_guess].to_s
             else
                p "WRONG: " + choices[logistic_guess].to_s
                p "ACTUAL: " + choices[actual].to_s
            end

        end

        end_time = Time.now
        p correct.to_s +  "/" + possible.to_s
        p "this took: " + (end_time - beginning_time).to_s + "  seconds!"

        # result = RubyProf.stop
        # printer = RubyProf::CallStackPrinter.new(result)
        # File.open("tmp/profile_data2.html", 'w') { |file| printer.print(file) }
    end
end
