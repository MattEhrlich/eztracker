require 'matrix.rb'
require 'nmatrix'
require './lib/algorithm.rb'
class Rep

    def self.compute_cost_multi_var(x,y,theta)# input as a array
        m = x.length
        matrix_x = N[*x]
        matrix_y = N[*y]
        matrix_t = N[*theta]
        predictions = (matrix_x.dot(matrix_t))
        j = (predictions - matrix_y).collect{|e| e ** 2}.to_a
        return j.sum / (1.0*m)
    end

    def self.compute_cost_multi_df(matrix_t,matrix_x,matrix_y) # input as a array
        predictions = N[(matrix_x.dot(matrix_t)).collect{ |e| e }].transpose
        return matrix_x.transpose.dot(matrix_y - predictions)
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

    def self.hessian(x) # input as a matrix
        return x.transpose.dot(x)
    end
    def self.magnitute(x,y,z)
        return Math.sqrt((x**2) + (y**2) + (z**2))
    end
    def self.mags(x,y,z)
        mags = []
        x.each_with_index do |item, i|
            mags = mags + [Rep.magnitute(x[i],y[i],z[i])]
        end
        return mags
    end
    def self.nonlinear_regression(x,y,xx, pol2)
        # TODO: fix!
        x = Rep.meshing(x,pol2)
        matrix_x = N[*x]
        matrix_y = N[*y]
        matrix_theta = N.zeros([matrix_x.cols,1])
        i = 0
        i_max = 201
        r = -Rep.compute_cost_multi_df(matrix_theta,matrix_x,matrix_y)
        # p "r"
        d = r
        # p r
        alphastore = []
        hess = Rep.hessian(matrix_x)
        while (i < i_max)
                if i % 50 == 0
                    curr = Rep.compute_cost_multi_var(matrix_x.to_a,matrix_y.to_a,matrix_theta.to_a)
                    p "cost at iter" + i.to_s + " is :" + curr.to_s
                    # TODO: check logistic_df, and make sure poly functions are actually doing their jobs!
                end
            alpha = ((-r.transpose.dot(d)) /  (( d.transpose.dot(hess)).dot(d)))[0,0]
            alphastore = alphastore+[alpha]
            # p "alpha: "
            # p alpha
            matrix_theta = matrix_theta + ( NMatrix.new( [d.rows, d.cols], alpha)*d )
            dr = r
            r = -Rep.compute_cost_multi_df(matrix_theta,matrix_x,matrix_y)
            beta = (r.transpose.dot(r)) / (dr.transpose.dot(dr))
            beta = beta[0,0]
            # p "beta: "
            # p beta
            d = r + ( NMatrix.new( [d.rows, d.cols], beta)*d )
            i += 1
        end
        z = (Matrix[*Algorithm.meshing(xx,pol2)] * Matrix[*matrix_theta.to_a] ).to_a.transpose[0]
        return z
    end
    def self.rep_predict(arr_x,arr_y,arr_z)

        x1 = Algorithm.array_string_to_array("500.0,390.0,921.0,62.0,93.0,375.0,328.0,-187.0,-281.0,31.0,-203.0,15.0,")
        y1 = Algorithm.array_string_to_array("-640.0,-515.0,-734.0,-500.0,-250.0,-453.0,-156.0,-515.0,-281.0,-265.0,-562.0,-31.0,")
        z1 = Algorithm.array_string_to_array("937.0,-328.0,1828.0,-2000.0,406.0,437.0,718.0,-1875.0,-1546.0,546.0,156.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus = [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 = [mag1.length]
        y = [[9.0]]

        x1 = Algorithm.array_string_to_array("531.0,-125.0,-515.0,265.0,-93.0,-640.0,265.0,-187.0,-500.0,171.0,-796.0,-390.0,93.0,-703.0,171.0,0.0,-703.0,328.0,-781.0,-531.0,109.0,-609.0,-109.0,-62.0,-734.0,156.0,-484.0,-734.0,93.0,0.0,")
        y1 = Algorithm.array_string_to_array("-562.0,-203.0,218.0,-468.0,-375.0,359.0,-484.0,-140.0,-31.0,-421.0,296.0,-93.0,-312.0,312.0,-312.0,-390.0,109.0,-484.0,250.0,78.0,-531.0,234.0,-343.0,-343.0,187.0,-375.0,-93.0,171.0,-250.0,-15.0,")
        z1 = Algorithm.array_string_to_array("625.0,906.0,265.0,984.0,1093.0,531.0,953.0,1046.0,1031.0,1156.0,453.0,1171.0,1109.0,-265.0,1000.0,1062.0,578.0,1031.0,343.0,859.0,1187.0,-453.0,1078.0,1140.0,93.0,984.0,968.0,-359.0,890.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length ]
        plus1 += [mag1.length]
        y += [[10.0]]

        x1 = Algorithm.array_string_to_array("296.0,500.0,359.0,-250.0,437.0,-359.0,-390.0,312.0,-437.0,328.0,-93.0,-312.0,437.0,-562.0,546.0,-156.0,468.0,109.0,0.0,")
        y1 = Algorithm.array_string_to_array("-593.0,-328.0,-671.0,156.0,-546.0,-62.0,62.0,-562.0,-31.0,-671.0,-328.0,-187.0,-640.0,62.0,-656.0,-187.0,-640.0,-312.0,-15.0,")
        z1 = Algorithm.array_string_to_array("984.0,1171.0,1250.0,296.0,1203.0,484.0,546.0,1203.0,-562.0,1187.0,1062.0,734.0,984.0,-218.0,1093.0,1234.0,1015.0,1531.0,1015.0,")        
        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 += [mag1.length]
        y += [[10.0]]

        x1 = Algorithm.array_string_to_array("625.0,-265.0,218.0,265.0,-234.0,78.0,421.0,-390.0,93.0,15.0,")
        y1 = Algorithm.array_string_to_array("-562.0,0.0,-562.0,-453.0,140.0,-125.0,-203.0,250.0,-140.0,-31.0,")
        z1 = Algorithm.array_string_to_array("593.0,-93.0,1562.0,1328.0,31.0,1281.0,1203.0,-109.0,906.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 += [mag1.length]
        y += [[5.0]]

        
        x1 = Algorithm.array_string_to_array("765.0,1015.0,984.0,812.0,531.0,734.0,765.0,0.0,93.0,453.0,1015.0,0.0,")
        y1 = Algorithm.array_string_to_array("-171.0,-93.0,-546.0,-453.0,-578.0,-515.0,-625.0,-203.0,-265.0,-218.0,-265.0,-15.0,")
        z1 = Algorithm.array_string_to_array("640.0,1984.0,1890.0,1515.0,1843.0,1562.0,1734.0,-625.0,-812.0,109.0,-1953.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 += [mag1.length]
        y += [[10.0]]

        x1 = Algorithm.array_string_to_array("-78.0,78.0,609.0,-281.0,515.0,250.0,-187.0,93.0,156.0,46.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-171.0,-218.0,-343.0,109.0,-718.0,-671.0,0.0,-234.0,-375.0,-203.0,0.0,")
        z1 = Algorithm.array_string_to_array("-1328.0,937.0,968.0,-109.0,1515.0,1078.0,437.0,1078.0,1421.0,-328.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 += [mag1.length]
        y += [[7.0]]

        x1 = Algorithm.array_string_to_array("-468.0,515.0,-46.0,125.0,15.0,")
        y1 = Algorithm.array_string_to_array("109.0,-625.0,-187.0,-562.0,-31.0,")
        z1 = Algorithm.array_string_to_array("781.0,984.0,921.0,1109.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 += [mag1.length]
        y += [[2.0]]

        # x1 = Algorithm.array_string_to_array(" ")
        # y1 = Algorithm.array_string_to_array(" ")
        # z1 = Algorithm.array_string_to_array(" ")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]

                
        x1 = Algorithm.array_string_to_array("906.0,328.0,500.0,-312.0,406.0,218.0,203.0,-375.0,500.0,250.0,-609.0,484.0,578.0,-562.0,-375.0,281.0,0.0,")
        y1 = Algorithm.array_string_to_array("-515.0,-468.0,-750.0,15.0,-546.0,-718.0,-218.0,-250.0,-609.0,-578.0,-15.0,-593.0,-515.0,-78.0,-281.0,-375.0,-15.0,")
        z1 = Algorithm.array_string_to_array("218.0,1062.0,1250.0,515.0,1328.0,1296.0,1031.0,-578.0,1484.0,1468.0,62.0,1171.0,1437.0,62.0,718.0,1343.0,1031.0,")

        mag1 = Rep.mags(x1,y1,z1)
        plus += [mag1.mean * mag1.standard_deviation / mag1.length]
        plus1 += [mag1.length]
        y += [[10.0]]

        plus += [0.0]
        plus1 += [0.0]
        y += [[0.0]]
        
        # x1 = Algorithm.array_string_to_array(" ")
        # y1 = Algorithm.array_string_to_array(" ")
        # z1 = Algorithm.array_string_to_array(" ")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]

        # x1 = Algorithm.array_string_to_array(" ")
        # y1 = Algorithm.array_string_to_array(" ")
        # z1 = Algorithm.array_string_to_array(" ")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]

        # x1 = Algorithm.array_string_to_array(" ")
        # y1 = Algorithm.array_string_to_array(" ")
        # z1 = Algorithm.array_string_to_array(" ")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]

        # x1 = Algorithm.array_string_to_array(" ")
        # y1 = Algorithm.array_string_to_array(" ")
        # z1 = Algorithm.array_string_to_array(" ")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]

        # x1 = Algorithm.array_string_to_array(" ")
        # y1 = Algorithm.array_string_to_array(" ")
        # z1 = Algorithm.array_string_to_array(" ")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]


        old_plus = plus.collect{|ele| ele}
        plus = [plus.collect{|ele| ele }].transpose
        plus = (plus.transpose << plus1).transpose
        x1 = Algorithm.array_string_to_array(arr_x)
        y1 = Algorithm.array_string_to_array(arr_y)
        z1 = Algorithm.array_string_to_array(arr_z)


        mag1 = Rep.mags(x1,y1,z1)
        xx = [[mag1.mean * mag1.standard_deviation /  mag1.length  ,mag1.length]]
        
        p "======"
        p "wierd datr"
        p "======"
        p old_plus
        p "======"
        p "time"
        p "======"
        p plus1
        p "======"
        p "reps"
        p "======"
        p y.transpose
        p "======"
        p xx
        p "======"
        # TODO: Need more data, get 20 points
        ans = Rep.nonlinear_regression(plus,y,xx,3)[0]
        p "prediction: " + ans.to_s
        return ans.round
    end      

end