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
            i_max = 200

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
    
    def self.classify(x,y,z)
        # RubyProf.start

        x1 = [[734.0,-109.0, -687.0,390.0,-828.0,62.0,62.0,-562.0,203.0,-609.0,343.0,-687.0,0.0,-593.0,-421.0,62.0,-953.0]]
        y1 = [[0.0,-78.0,125.0,-203.0,-218.0,-203.0,-203.0,-46.0,-234.0,-203.0,-203.0,-218.0,1109.0,-156.0,-125.0,-250.0,-140.0]]
        z1 = [[859.0,1312.0,968.0,1109.0,312.0,1062.0,984.0,953.0,1250.0,390.0,937.0,187.0,1109.0,546.0,843.0,890.0,468.0]]

        x2 = [[-640.0, 156.0, 125.0,281.0,359.0,109.0,437.0,156.0,171.0,562.0,328.0,296.0,15.0,250.0,343.0,-93.0,750.0]]
        y2 = [[-1078.0,-234.0,-265.0,-265.0,-421.0,-312.0,-234.0,-93.0,-250.0,-515.0,-187.0,-218.0,-390.0, -250.0,-343.0,-171.0,625.0]]
        z2 = [[1125.0,734.0,1000.0,1171.0,656.0,1015.0,750.0,1031.0,890.0,640.0,1203.0,796.0,1078.0,812.0,906.0,1156.0,-546.0]]

        x3 = [[-46.0,125.0,968.0,203.0,468.0,375.0,390.0,546.0,968.0,734.0,484.0,750.0,765.0,953.0,562.0,546.0,484.0]]
        y3 = [[-187.0,-171.0,-250.0,-687.0, -437.0, -515.0, -390.0, -328.0,-265.0,-484.0, -31.0,-859.0,-125.0,-546.0,-312.0,-500.0,-421.0]]
        z3 = [[531.0,781.0,781.0,656.0, 828.0,406.0,906.0,703.0,828.0,578.0,812.0,765.0,1093.0,468.0,875.0,625.0,781.0]]

        # test Curl
        # xx = [[265.0,-859.0,-93.0,-187.0,-718.0, -140.0, -781.0, -15.0, -515.0,-78.0,15.0,656.0,-578.0,750.0,-546.0,-437.0,1500.0]]
        # yy = [[-46.0,-109.0,-296.0,-203.0,-62.0,-359.0,-78.0,-687.0,-62.0,-421.0,-1140.0, -15.0, -203.0, -1015.0,-265.0,-390.0,-1734.0]]
        # zz = [[968.0, 390.0, 1531.0, -343.0, 1062.0, 1109.0, 203.0,875.0,62.0,484.0,1984.0,171.0,906.0,1328.0,453.0,812.0,1609.0]]

        # test Press

        # xx = [[-703.0,984.0,-796.0,-609.0,-343.0,-875.0,-531.0,-468.0,-609.0,-484.0,-968.0,-734.0,-515.0,-843.0,-625.0,-453.0,-546.0]]
        # yy = [[906.0,343.0,-93.0,156.0,187.0,359.0,359.0,140.0,437.0,562.0,609.0,218.0,296.0,265.0,234.0,328.0,265.0]]
        # zz = [[ 375.0, 1140.0, 718.0, 812.0, 609.0, 937.0,203.0,593.0,781.0,359.0,968.0,734.0,46.0, 1281.0, 828.0,31.0, 546.0 ]]


        xx = [x]
        yy = [y]
        zz = [z]

        

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
            actual = 1
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
             else
                p "WRONG: " + logistic_guess.to_s
                p "ACTUAL: " + actual.to_s
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
