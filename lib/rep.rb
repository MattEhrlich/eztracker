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

    def self.regularize(x)
        matrix_x = N[*x]
        final = []
        (0..(matrix_x.cols - 1)).each do |col_i|
            curr_arr = matrix_x.column(col_i).transpose.to_a 
            p "*************************"
            p curr_arr
            final += [(curr_arr).collect{ |num| (num - curr_arr.mean) / ((curr_arr.max - curr_arr.mean)/ 1.633) }]
        end
        return final.transpose
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
                    curr_num *= curr_x[multi_index].to_f
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
        # matrix_theta = N[*[[-5.309575207882087], [0.0002531245579895821], [0.005180486264794318], [0.8012800842301145], [5.927152829519896e-09], [3.323754848002685e-07], [-2.160859974858134e-05], [-3.7795459125656428e-06], [-0.00016899041498311462], [-0.004027244478202384]]]
        i = 0
        i_max = 601
        r = -Rep.compute_cost_multi_df(matrix_theta,matrix_x,matrix_y)
        # p "r"
        d = r
        # p r
        alphastore = []
        hess = Rep.hessian(matrix_x)
        while (i < i_max)
                if i % 200 == 0
                    curr = Rep.compute_cost_multi_var(matrix_x.to_a,matrix_y.to_a,matrix_theta.to_a)
                    z = (Matrix[*Algorithm.meshing(xx,pol2)] * Matrix[*matrix_theta.to_a] ).to_a.transpose[0]
                    p "cost at iter" + i.to_s + " is :" + curr.to_s + " ====== " + z.to_s
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
        # p matrix_theta.to_a.transpose[0]
        # p matrix_theta.to_a.transpose[0].mean
        p "coffs:"
        p matrix_theta.to_a
        z = (Matrix[*Algorithm.meshing(xx,pol2)] * Matrix[*matrix_theta.to_a] ).to_a.transpose[0]
        return z
    end
    def self.rep_predict(arr_x,arr_y,arr_z)

        x1 = Algorithm.array_string_to_array("500.0,390.0,921.0,62.0,93.0,375.0,328.0,-187.0,-281.0,31.0,-203.0,15.0,")
        y1 = Algorithm.array_string_to_array("-640.0,-515.0,-734.0,-500.0,-250.0,-453.0,-156.0,-515.0,-281.0,-265.0,-562.0,-31.0,")
        z1 = Algorithm.array_string_to_array("937.0,-328.0,1828.0,-2000.0,406.0,437.0,718.0,-1875.0,-1546.0,546.0,156.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus = [[mag1.sum, mag1.standard_deviation]]
        plus1 = [mag1.length]
        y = [[9.0]]

        x1 = Algorithm.array_string_to_array("531.0,-125.0,-515.0,265.0,-93.0,-640.0,265.0,-187.0,-500.0,171.0,-796.0,-390.0,93.0,-703.0,171.0,0.0,-703.0,328.0,-781.0,-531.0,109.0,-609.0,-109.0,-62.0,-734.0,156.0,-484.0,-734.0,93.0,0.0,")
        y1 = Algorithm.array_string_to_array("-562.0,-203.0,218.0,-468.0,-375.0,359.0,-484.0,-140.0,-31.0,-421.0,296.0,-93.0,-312.0,312.0,-312.0,-390.0,109.0,-484.0,250.0,78.0,-531.0,234.0,-343.0,-343.0,187.0,-375.0,-93.0,171.0,-250.0,-15.0,")
        z1 = Algorithm.array_string_to_array("625.0,906.0,265.0,984.0,1093.0,531.0,953.0,1046.0,1031.0,1156.0,453.0,1171.0,1109.0,-265.0,1000.0,1062.0,578.0,1031.0,343.0,859.0,1187.0,-453.0,1078.0,1140.0,93.0,984.0,968.0,-359.0,890.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[10.0]]

        x1 = Algorithm.array_string_to_array("296.0,500.0,359.0,-250.0,437.0,-359.0,-390.0,312.0,-437.0,328.0,-93.0,-312.0,437.0,-562.0,546.0,-156.0,468.0,109.0,0.0,")
        y1 = Algorithm.array_string_to_array("-593.0,-328.0,-671.0,156.0,-546.0,-62.0,62.0,-562.0,-31.0,-671.0,-328.0,-187.0,-640.0,62.0,-656.0,-187.0,-640.0,-312.0,-15.0,")
        z1 = Algorithm.array_string_to_array("984.0,1171.0,1250.0,296.0,1203.0,484.0,546.0,1203.0,-562.0,1187.0,1062.0,734.0,984.0,-218.0,1093.0,1234.0,1015.0,1531.0,1015.0,")        
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[10.0]]

        x1 = Algorithm.array_string_to_array("625.0,-265.0,218.0,265.0,-234.0,78.0,421.0,-390.0,93.0,15.0,")
        y1 = Algorithm.array_string_to_array("-562.0,0.0,-562.0,-453.0,140.0,-125.0,-203.0,250.0,-140.0,-31.0,")
        z1 = Algorithm.array_string_to_array("593.0,-93.0,1562.0,1328.0,31.0,1281.0,1203.0,-109.0,906.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[5.0]]

        
        x1 = Algorithm.array_string_to_array("765.0,1015.0,984.0,812.0,531.0,734.0,765.0,0.0,93.0,453.0,1015.0,0.0,")
        y1 = Algorithm.array_string_to_array("-171.0,-93.0,-546.0,-453.0,-578.0,-515.0,-625.0,-203.0,-265.0,-218.0,-265.0,-15.0,")
        z1 = Algorithm.array_string_to_array("640.0,1984.0,1890.0,1515.0,1843.0,1562.0,1734.0,-625.0,-812.0,109.0,-1953.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[10.0]]

        x1 = Algorithm.array_string_to_array("-78.0,78.0,609.0,-281.0,515.0,250.0,-187.0,93.0,156.0,46.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-171.0,-218.0,-343.0,109.0,-718.0,-671.0,0.0,-234.0,-375.0,-203.0,0.0,")
        z1 = Algorithm.array_string_to_array("-1328.0,937.0,968.0,-109.0,1515.0,1078.0,437.0,1078.0,1421.0,-328.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[7.0]]

        x1 = Algorithm.array_string_to_array("-468.0,515.0,-46.0,125.0,15.0,")
        y1 = Algorithm.array_string_to_array("109.0,-625.0,-187.0,-562.0,-31.0,")
        z1 = Algorithm.array_string_to_array("781.0,984.0,921.0,1109.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[2.0]]
# ===================
        x1 = Algorithm.array_string_to_array("781.0,-109.0,671.0,31.0,93.0,406.0,-187.0,-171.0,15.0,")
        y1 = Algorithm.array_string_to_array("-406.0,-187.0,-609.0,-359.0,-687.0,-671.0,-125.0,-718.0,-31.0,")
        z1 = Algorithm.array_string_to_array("796.0,-281.0,859.0,906.0,1156.0,968.0,718.0,1203.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[4.0]]
  
        # x1 = Algorithm.array_string_to_array("-78.0,-750.0,484.0,359.0,343.0,-15.0,")
        # y1 = Algorithm.array_string_to_array("-625.0,-140.0,-500.0,-234.0,-640.0,-15.0,")
        # z1 = Algorithm.array_string_to_array("1984.0,1687.0,-2000.0,1421.0,1406.0,1031.0,")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.sum, mag1.standard_deviation]
        # plus1 += [mag1.length]
        # y += [[4.0]]

        # x1 = Algorithm.array_string_to_array("656.0,-15.0,281.0,812.0,140.0,125.0,687.0,578.0,265.0,-62.0,-187.0,218.0,0.0,0.0,")
        # y1 = Algorithm.array_string_to_array("-671.0,-500.0,-468.0,-781.0,-765.0,-640.0,-593.0,-578.0,-546.0,-468.0,-125.0,-312.0,0.0,0.0,")
        # z1 = Algorithm.array_string_to_array("390.0,-1703.0,-812.0,1546.0,1625.0,1562.0,1578.0,1234.0,1281.0,1046.0,-1437.0,578.0,1000.0,1015.0,")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.sum, mag1.standard_deviation * mag1.standard_deviation, mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[10.0]]
# ===================



                
        x1 = Algorithm.array_string_to_array("906.0,328.0,500.0,-312.0,406.0,218.0,203.0,-375.0,500.0,250.0,-609.0,484.0,578.0,-562.0,-375.0,281.0,0.0,")
        y1 = Algorithm.array_string_to_array("-515.0,-468.0,-750.0,15.0,-546.0,-718.0,-218.0,-250.0,-609.0,-578.0,-15.0,-593.0,-515.0,-78.0,-281.0,-375.0,-15.0,")
        z1 = Algorithm.array_string_to_array("218.0,1062.0,1250.0,515.0,1328.0,1296.0,1031.0,-578.0,1484.0,1468.0,62.0,1171.0,1437.0,62.0,718.0,1343.0,1031.0,")

        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[10.0]]

        # plus += [[0.0,0.]]
        # plus1 += [1.0]
        # y += [[0.0]]

        # ========== new curls ===========

        x1 = Algorithm.array_string_to_array("-15.0,390.0,828.0,437.0,-140.0,750.0,-93.0,500.0,312.0,578.0,359.0,281.0,625.0,93.0,-234.0,-125.0,781.0,-218.0,-281.0,500.0,0.0,500.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-15.0,-296.0,-750.0,-312.0,46.0,-750.0,-15.0,-375.0,-343.0,406.0,-328.0,-31.0,187.0,-156.0,0.0,-93.0,-531.0,46.0,156.0,-171.0,46.0,-109.0,-15.0,")
        z1 = Algorithm.array_string_to_array("984.0,734.0,1671.0,1015.0,-140.0,1453.0,953.0,1890.0,937.0,-1687.0,1281.0,1265.0,-1984.0,1750.0,1234.0,421.0,1734.0,359.0,-140.0,1281.0,593.0,671.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[12.0]]
        
        x1 = Algorithm.array_string_to_array("-15.0,281.0,-1015.0,359.0,1234.0,687.0,375.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-15.0,-343.0,78.0,343.0,-171.0,-78.0,-390.0,-15.0,")
        z1 = Algorithm.array_string_to_array("1015.0,1062.0,-1093.0,546.0,890.0,937.0,1250.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[3.0]]

        x1 = Algorithm.array_string_to_array("265.0,500.0,-62.0,328.0,593.0,-312.0,546.0,-265.0,328.0,-15.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-453.0,-437.0,296.0,-437.0,-375.0,203.0,-453.0,140.0,-156.0,-15.0,-15.0,")
        z1 = Algorithm.array_string_to_array("1078.0,1250.0,-500.0,890.0,1484.0,-218.0,1703.0,1671.0,500.0,1031.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[6.0]]

        x1 = Algorithm.array_string_to_array("46.0,-546.0,515.0,-484.0,-703.0,406.0,-234.0,-500.0,140.0,-125.0,")
        y1 = Algorithm.array_string_to_array("-250.0,0.0,-359.0,203.0,500.0,93.0,218.0,234.0,78.0,78.0,")
        z1 = Algorithm.array_string_to_array("1031.0,1171.0,859.0,953.0,375.0,1046.0,562.0,828.0,1031.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[3.0]]

        x1 = Algorithm.array_string_to_array("671.0,-93.0,-125.0,593.0,500.0,546.0,156.0,296.0,-203.0,46.0,921.0,406.0,-296.0,671.0,859.0,125.0,250.0,703.0,937.0,62.0,359.0,343.0,-15.0,")
        y1 = Algorithm.array_string_to_array("0.0,46.0,62.0,-593.0,-531.0,1203.0,-171.0,203.0,-78.0,15.0,-421.0,-312.0,125.0,296.0,-125.0,-78.0,-250.0,-234.0,-343.0,31.0,31.0,-250.0,-15.0,")
        z1 = Algorithm.array_string_to_array("1640.0,1078.0,640.0,1468.0,1000.0,-1968.0,687.0,1390.0,906.0,390.0,1796.0,1328.0,375.0,1421.0,1343.0,562.0,1187.0,1968.0,1687.0,250.0,1265.0,1078.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[15.0]]

        x1 = Algorithm.array_string_to_array("31.0,953.0,875.0,-765.0,906.0,640.0,-765.0,1031.0,781.0,-515.0,500.0,281.0,-578.0,812.0,531.0,375.0,890.0,-62.0,281.0,0.0,")
        y1 = Algorithm.array_string_to_array("187.0,-203.0,-203.0,-312.0,-109.0,78.0,-718.0,-187.0,-375.0,-125.0,-234.0,187.0,-812.0,-46.0,187.0,156.0,-312.0,234.0,-187.0,-15.0,")
        z1 = Algorithm.array_string_to_array("406.0,1546.0,1062.0,-953.0,1453.0,1046.0,-1250.0,1171.0,812.0,-828.0,1312.0,1093.0,-1671.0,1593.0,1453.0,875.0,1343.0,1359.0,1234.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[12.0]]

        # x1 = Algorithm.array_string_to_array("703.0,390.0,-93.0,625.0,-78.0,-375.0,578.0,-437.0,-156.0,296.0,-62.0,359.0,546.0,-31.0,-203.0,390.0,-375.0,125.0,62.0,-343.0,296.0,0.0,")
        # y1 = Algorithm.array_string_to_array("-453.0,-203.0,-218.0,-703.0,-421.0,15.0,-546.0,218.0,-234.0,-437.0,-31.0,-343.0,-343.0,46.0,-140.0,-328.0,-109.0,-437.0,-375.0,140.0,-296.0,-15.0,")
        # z1 = Algorithm.array_string_to_array("1312.0,1281.0,812.0,1484.0,1218.0,312.0,1375.0,125.0,843.0,1250.0,484.0,1156.0,1375.0,1343.0,812.0,1187.0,484.0,1218.0,1156.0,15.0,875.0,1031.0,")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [[mag1.sum, mag1.standard_deviation]]
        # plus1 += [mag1.length]
        # y += [[13.0]]

        x1 = Algorithm.array_string_to_array("656.0,-296.0,687.0,-312.0,-171.0,640.0,-468.0,484.0,15.0,-609.0,625.0,-546.0,531.0,-265.0,-78.0,")
        y1 = Algorithm.array_string_to_array("-203.0,0.0,-78.0,-46.0,-140.0,-250.0,-93.0,-140.0,187.0,-171.0,-46.0,-265.0,-250.0,-296.0,93.0,")
        z1 = Algorithm.array_string_to_array("765.0,343.0,1265.0,265.0,640.0,1156.0,-328.0,1281.0,1312.0,-31.0,1078.0,-515.0,1421.0,656.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[8.0]]

        x1 = Algorithm.array_string_to_array("-93.0,62.0,187.0,31.0,-250.0,312.0,31.0,78.0,375.0,156.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-156.0,-203.0,-359.0,-140.0,-265.0,-265.0,-406.0,-281.0,-343.0,-546.0,-15.0,")
        z1 = Algorithm.array_string_to_array("1078.0,906.0,1468.0,1312.0,-765.0,1859.0,1468.0,1359.0,-1265.0,734.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[6.0]]

        x1 = Algorithm.array_string_to_array("-312.0,453.0,-156.0,531.0,359.0,-234.0,78.0,203.0,-250.0,437.0,140.0,-562.0,484.0,515.0,-203.0,312.0,171.0,-15.0,")
        y1 = Algorithm.array_string_to_array("62.0,-93.0,-218.0,93.0,-78.0,15.0,-93.0,93.0,-46.0,-234.0,-187.0,62.0,-375.0,-15.0,0.0,-109.0,-640.0,0.0,")
        z1 = Algorithm.array_string_to_array("906.0,984.0,-640.0,1453.0,1250.0,1093.0,1171.0,1421.0,843.0,1187.0,1406.0,359.0,1375.0,1359.0,375.0,1296.0,1218.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[ 11.0]]

        x1 = Algorithm.array_string_to_array("500.0,218.0,265.0,515.0,78.0,46.0,609.0,453.0,-203.0,390.0,296.0,-375.0,265.0,343.0,-484.0,-500.0,31.0,0.0,")
        y1 = Algorithm.array_string_to_array("-218.0,-359.0,-234.0,-78.0,-125.0,-46.0,-125.0,-328.0,-31.0,-406.0,-453.0,-140.0,-203.0,-250.0,-125.0,0.0,-515.0,0.0,")
        z1 = Algorithm.array_string_to_array("1296.0,1359.0,1265.0,1125.0,968.0,890.0,1453.0,1312.0,546.0,1421.0,1375.0,-31.0,1328.0,1593.0,-250.0,375.0,1015.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[ 11.0]]

        x1 = Algorithm.array_string_to_array("-343.0,625.0,343.0,203.0,546.0,0.0,-109.0,578.0,-171.0,171.0,375.0,-281.0,-312.0,515.0,-296.0,-171.0,250.0,-15.0,")
        y1 = Algorithm.array_string_to_array("-46.0,-468.0,-296.0,-171.0,-109.0,187.0,-171.0,-437.0,-156.0,-109.0,-484.0,-203.0,31.0,-500.0,-109.0,-46.0,-500.0,-15.0,")
        z1 = Algorithm.array_string_to_array("-562.0,1046.0,1250.0,1078.0,1296.0,1015.0,671.0,1109.0,1125.0,968.0,1265.0,812.0,328.0,1343.0,46.0,781.0,937.0,1031.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[ 11.0]]

        x1 = Algorithm.array_string_to_array("390.0,-500.0,578.0,203.0,-218.0,-265.0,390.0,-406.0,375.0,-296.0,0.0,")
        y1 = Algorithm.array_string_to_array("-281.0,140.0,-234.0,-46.0,-109.0,62.0,-15.0,-375.0,-218.0,0.0,-15.0,")
        z1 = Algorithm.array_string_to_array("1468.0,46.0,1421.0,1125.0,609.0,625.0,1312.0,906.0,1218.0,1390.0,1015.0,")
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]
        plus1 += [mag1.length]
        y += [[ 7.0]]

        # x1 = Algorithm.array_string_to_array("")
        # y1 = Algorithm.array_string_to_array("")
        # z1 = Algorithm.array_string_to_array("")
        # mag1 = Rep.mags(x1,y1,z1)
        # plus += [mag1.mean ]
        # plus1 += [mag1.length]
        # y += [[ ]]




        # old_plus = plus.collect{|ele| ele}
        # plus = plus.collect{|ele| ele }
        # plus = (plus.transpose << plus1).transpose
        # x1 = Algorithm.array_string_to_array(arr_x)
        # y1 = Algorithm.array_string_to_array(arr_y)
        # z1 = Algorithm.array_string_to_array(arr_z)
        # mag1 = Rep.mags(x1,y1,z1)
        # xx = [[mag1.sum, mag1.standard_deviation, mag1.length]]


        x1 = Algorithm.array_string_to_array(arr_x)
        y1 = Algorithm.array_string_to_array(arr_y)
        z1 = Algorithm.array_string_to_array(arr_z)
        mag1 = Rep.mags(x1,y1,z1)
        plus += [[mag1.sum, mag1.standard_deviation]]


        # plus = Rep.regularize(plus)


        xx = plus.pop
        plus = (plus.transpose << plus1).transpose
        xx += [mag1.length]
        xx = [xx]


        p "======"
        p "wierd datr"
        p "======"
        p plus
        p "======"
        p "time"
        p "======"
        p plus1
        # p Rep.regularize([plus1].transpose).transpose[0]
        p "======"
        p "reps"
        p "======"
        p y.transpose
        p "======"
        p xx
        p "======"
        # TODO: Need more data, get 20 points
        ans = Rep.nonlinear_regression(plus,y,xx, 2)[0]
        p "prediction: " + ans.to_s
        return (ans).round
    end      

end