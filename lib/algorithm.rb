require 'matrix.rb'
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
            x[i] = Algorithm.ranging(x[i])
            # Algorithm.feature_normalize(
        end
        return x
    end

    def self.y_sort(x_length, data_placement,length_of_data)
        y = []
        # lengths_of_data
        # N[Algorithm.y_sort(m,choices.length,pos)].transpose
        (0..(x_length - 1)).each do |i|
            if ( i >= data_placement && i < length_of_data)
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

    def self.compute_cost_multi_logistic(x,y,theta)# input as a array
        m = x.length
        matrix_x = N[*x]
        matrix_y = N[*y]
        matrix_t = N[*theta]
        predictions = (matrix_x.dot(matrix_t)).collect{ |e| Algorithm.num_reg(Algorithm.sigmoid_function(e)) }
        part1 = N[*[y.transpose[0].collect{ |e| -1*e }]]       
        part2 = N[*[predictions.collect{|e| Math.log(e)}].transpose]
        part3 = N[*[y.transpose[0].collect{ |e| 1 - e }]]
        part4 = N[*[predictions.collect{ |e| Math.log(1 - e) }].transpose]
        j1 = part1.dot(part2)
        j2 = part3.dot(part4)
        j = (j1 - j2).to_a

        return j[0] / (1.0*m)
    end
    def self.compute_cost_multi_logistic_df(matrix_t,matrix_x,matrix_y) # input as a array
        predictions = N[(matrix_x.dot(matrix_t)).collect{ |e| Algorithm.num_reg(Algorithm.sigmoid_function(e)) }].transpose
        return matrix_x.transpose.dot(matrix_y - predictions)
    end
    def self.hessian(x) # input as a matrix
        return x.transpose.dot(x)
    end
    def self.polyfunc(x,y,pol)
            # TODO: fix!
            matrix_x = N[*x]
            matrix_y = N[*y]
            matrix_theta = N.zeros([matrix_x.cols,1])
            i = 0
            i_max = 2
            r = -Algorithm.compute_cost_multi_logistic_df(matrix_theta,matrix_x,matrix_y)
            # p "r"
            d = r
            # p r
            alphastore = []
            hess = Algorithm.hessian(matrix_x)
            while (i < i_max)
                # if i % 1 == 0
                #     # curr = Algorithm.compute_cost_multi_logistic(matrix_x.to_a,matrix_y.to_a,matrix_theta.to_a)
                #     # p "cost at iter" + i.to_s + " is :" + curr.to_s
                #     # TODO: check logistic_df, and make sure poly functions are actually doing their jobs!
                # end
                alpha = ((-r.transpose.dot(d)) /  (( d.transpose.dot(hess)).dot(d)))[0,0]
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
    def self.regress(x, y, degree)
        x_data = x.map { |xi| (0..degree).map { |pow| (xi**pow).to_f } }
 
        mx = Matrix[*x_data]
        my = Matrix.column_vector(y)
 
        ((mx.t * mx).inv * mx.t * my).transpose.to_a[0]
    end
    def self.polyfunc(x,y,pol)
         coffs = Algorithm.regress(x,y,pol)
         return Polynomial.new(coffs)
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

    def self.ranging(l)
        return l.collect{ |ele| ele / (1530.925)}
        # 1224.74
    end

    def self.nonlinear_logistic_regression_tester(choices ,data, pol, pol2, lengths_of_data)
        results = data[0..(lengths_of_data[0] -1) ]
        guesses = []
        lead_guess = -1
        lead_prob = 0
        x = Algorithm.meshing(data[(lengths_of_data[0])..(data.length-1)],pol2)
        matrix_x = N[*x]
        hess = Algorithm.hessian(matrix_x)
        m = x.length
        data_placement = 0
        (0..(choices.length - 1)).each do |pos|
            matrix_y = N[Algorithm.y_sort(m,data_placement,data_placement + lengths_of_data[pos + 1])].transpose
            matrix_theta = N.zeros([matrix_x.cols,1])
            data_placement += lengths_of_data[pos + 1]
            i = 0
            i_max = 751
            r = -Algorithm.compute_cost_multi_logistic_df(matrix_theta,matrix_x,matrix_y)
            d = r
            while (i < i_max)
                if i % 350 == 0
                    curr = Algorithm.compute_cost_multi_logistic(matrix_x.to_a,matrix_y.to_a,matrix_theta.to_a)
                    z = (Matrix[*Algorithm.meshing(results,pol2)] * Matrix[*matrix_theta.to_a] ).collect{ |e| Algorithm.num_reg(Algorithm.sigmoid_function(e)) }.to_a.transpose[0].mean
                    p "cost at iter" + i.to_s + " is :" + curr.to_s + " ====== " + z.to_s
                end
                alpha = ((-r.transpose.dot(d)) /  (( d.transpose.dot(hess)).dot( d) ))[0,0]
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

    def self.array_string_to_array(string)
        arr = []
        curr_string = ""
        string.each_char.with_index do |char, index|
            next if char == " "
            if char != ","
                curr_string += char
            else
                arr += [curr_string.to_f]
                curr_string = ""
            end
        end
        return arr
    end
    def self.angle(v1,v2)
        cat = v1.dot(v2.transpose())/ (v1.norm2() * v2.norm2())
        return (180.0/ Math::PI)*Math.acos( cat.to_f.round(6))
    end

    def self.minz(l)
        counter = 0
        (1..((l.length) - 2)).each do |i|
            counter += 1 if (l[i-1] - l[i] >= 0 && l[i+1] - l[i] >= 0) || (l[i-1] - l[i] <= 0 && l[i+1] - l[i] <= 0)
        end
        return counter
    end


    
    
end
