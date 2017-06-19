require 'matrix.rb'
require 'nmatrix'
require './lib/algorithm.rb'
require './lib/rep.rb'

class Rotate
    def self.slope(x,y)
        n = 1.0*x.to_a.length
        return (n*(x*y).sum.to_f - (x).sum.to_f*(y).sum.to_f)/(n*(x*x).sum.to_f - (x).sum.to_f**2)
    end

    def self.rotate_2d(big_l, angles)
        rad_angle = angles[0]*Math::PI/180.0
        rotate_matrix = N[[Math.cos(rad_angle),-Math.sin(rad_angle)],[Math.sin(rad_angle), Math.cos(rad_angle)]]
        final_tots = []
        big_l.each do |l|
            current = N[l[0..(l.length - 2)]]
            tots = current.dot(rotate_matrix)
            final_tots += [tots.to_a]
        end
        return final_tots
    end
    def self.rotate_3d(big_l, angles)
        angle_x = angles[0]*Math::PI/180.0
        rotate_x =  N[[1.0,0.0,0.0],[0.0,Math.cos(angle_x),-Math.sin(angle_x)],[0.0,Math.sin(angle_x),Math.cos(angle_x)]]
        angle_y = angles[1]*Math::PI/180.0
        rotate_y = N[[Math.cos(angle_y),0.0,Math.sin(angle_y)],[0.0,1.0,0.0],[-Math.sin(angle_y),0.0,Math.cos(angle_y)]]
        angle_z = angles[2]*Math::PI/180.0
        rotate_z =  N[[Math.cos(angle_z),-Math.sin(angle_z),0.0],[Math.sin(angle_z),Math.cos(angle_z),0.0],[0.0,0.0,1.0]]      
        final_tots = []
        big_l.each do |l|
            tots = N[l].dot(rotate_x)
            tots = tots.dot(rotate_y)
            tots = tots.dot(rotate_z)
            final_tots += [tots.to_a]
        end
        return final_tots
    end

    def self.rotate_3d_df(big_l,angles, turn)
        angle_x = angles[0]*Math::PI/180.0
        angle_y = angles[1]*Math::PI/180.0
        angle_z = angles[2]*Math::PI/180.0
        if turn[0] == 1
            rotate = N[[0.0,-Math.sin(angle_x)*Math.sin(angle_z) + Math.cos(angle_x)*Math.sin(angle_y)*Math.cos(angle_z),Math.cos(angle_x)*Math.sin(angle_z) + Math.sin(angle_x)*Math.sin(angle_y)*Math.cos(angle_z)],[0.0,-Math.sin(angle_x)*Math.cos(angle_z) -Math.cos(angle_x)*Math.sin(angle_y)*Math.sin(angle_z),Math.cos(angle_x)*Math.cos(angle_z) -Math.sin(angle_x)*Math.sin(angle_y)*Math.sin(angle_z)],[0.0,-Math.cos(angle_x)*Math.cos(angle_y),-Math.sin(angle_x)*Math.cos(angle_y)]]
        elsif turn[1] == 1
            rotate = N[[-Math.sin(angle_y)*Math.cos(angle_z),Math.cos(angle_y)*Math.sin(angle_x)*Math.cos(angle_z),-Math.cos(angle_y)*Math.cos(angle_x)*Math.cos(angle_z)],[Math.sin(angle_y)*Math.sin(angle_z),-Math.cos(angle_y)*Math.sin(angle_x)*Math.sin(angle_z), Math.cos(angle_y)*Math.cos(angle_x)*Math.sin(angle_z)],[Math.cos(angle_y), Math.sin(angle_y)*Math.sin(angle_x), -Math.sin(angle_y)*Math.cos(angle_x)]]
        elsif turn[2] == 1
            rotate = N[[-Math.sin(angle_z)*Math.cos(angle_y),Math.cos(angle_z)*Math.cos(angle_x) -Math.sin(angle_z)*Math.sin(angle_x)*Math.sin(angle_y), Math.cos(angle_z)*Math.sin(angle_x) + Math.sin(angle_z)*Math.sin(angle_y)*Math.cos(angle_x)],[-Math.cos(angle_z)*Math.cos(angle_y), -Math.sin(angle_z)*Math.cos(angle_x) -Math.cos(angle_z)*Math.sin(angle_x)*Math.sin(angle_y), -Math.sin(angle_z)*Math.sin(angle_x) +Math.cos(angle_z)*Math.sin(angle_y)*Math.cos(angle_x)],[0.0,0.0,0.0]]
        end
        final_tots = []
        big_l.each do |l|
            tots = N[l].dot(rotate)
            final_tots += [tots.to_a]
        end
        return final_tots
    end

    def self.computeCost_2d(theta,x)
        new_data = Rotate.rotate_2d(x, theta).transpose
        return Rotate.slope(N[*new_data[1]],N[*new_data[0]])**2
    end

    def self.computeCost_df_2d(theta,x)
        new_data = Rotate.rotate_2d(x, theta).transpose
        return N[[2.0*Rotate.slope(N[*new_data[1]],N[*new_data[0]])],[0.0]]
    end
    def self.computeCost_3d(theta,x)
        new_data = Rotate.rotate_3d(x, theta).transpose
        new_x = (new_data[0]).mean 
        new_y = (new_data[1]).mean 
        new_z = (new_data[2]).mean + 3000.0
        return (( (new_x)**2 + new_y**2 + (new_z)**2)**0.5)
    end

    def self.computeCost_df_3d(theta,x)
        new_data = Rotate.rotate_3d(x, theta)
        xnd_df = Rotate.rotate_3d_df(new_data, theta, [1,0,0]).transpose
        ynd_df = Rotate.rotate_3d_df(new_data, theta, [0,1,0]).transpose
        znd_df = Rotate.rotate_3d_df(new_data, theta, [0,0,1]).transpose
        new_data = new_data.transpose
        new_x = (new_data[0]).mean 
        new_y = (new_data[1]).mean 
        new_z = (new_data[2]).mean + 3000.0
        return N[[((( (new_x)**2 + new_y**2 + (new_z)**2)**-0.5))*((new_x)*(xnd_df[0]).mean + new_y*(ynd_df[0]).mean + (new_z )*(znd_df[0]).mean)] , [((( (new_x)**2 + new_y**2 + (new_z)**2)**-0.5))*((new_x)*(xnd_df[1]).mean + new_y*(ynd_df[1]).mean + (new_z )*(znd_df[1]).mean)] , [((( (new_x)**2 + new_y**2 + (new_z)**2)**-0.5))*((new_x)*(xnd_df[2]).mean + new_y*(ynd_df[2]).mean + (new_z)*(znd_df[2]).mean)]]
    end

    def self.angle_guess_2d(x)
        # TODO: fix!
        matrix_x = N[*x]
        matrix_theta = N[[0.0],[0.0]]
        i = 0
        i_max = 181
        r = -Rotate.computeCost_df_2d(matrix_theta.to_a.transpose[0],matrix_x.to_a)
        # p "r"
        d = r
        # p r
        alphastore = []
        prev = 1000000000000000000
        prev_theta = [0.0]
        while (i < i_max)
            if i % 10 == 0
                # curr = Rotate.computeCost_2d(matrix_theta.to_a.transpose[0],matrix_x.to_a)
                # p "cost at iter" + i.to_s + " is :" + curr.to_s
            end
            if prev - computeCost_2d(matrix_theta.to_a.transpose[0],matrix_x.to_a) < 0
                # p prev_theta
                return prev_theta
            end
            alpha = 0.5
            alphastore = alphastore+[alpha]
            # p "alpha: "
            # p alpha
            prev = Rotate.computeCost_2d(matrix_theta.to_a.transpose[0],matrix_x.to_a).to_f
            prev_theta = [matrix_theta.to_a.transpose[0][0]]
            matrix_theta = matrix_theta + ( NMatrix.new( [d.rows, d.cols], alpha)*d )
            dr = r
            r = -Rotate.computeCost_df_2d(matrix_theta.to_a.transpose[0],matrix_x.to_a)
            beta = (r.transpose.dot(r)) / (dr.transpose.dot(dr))
            beta = beta[0,0]
            # p "beta: "
            # p beta
            d = r + ( NMatrix.new( [d.rows, d.cols], beta)*d )
            i += 1
        end
        z = [matrix_theta.to_a.transpose[0][0]]
        # p z
        return z
    end
    def self.angle_guess_3d(x)
        # TODO: fix!
        matrix_x = N[*x]
        matrix_theta = N[[0.0],[0.0],[0.0]]
        i = 0
        i_max = 251
        r = -Rotate.computeCost_df_3d(matrix_theta.to_a.transpose[0],matrix_x.to_a)
        # p "r"
        d = r
        # p r
        alphastore = []
        prev = 1000000000000000000
        prev_theta = [0.0,0.0,0.0]
        while (i < i_max)
            if i % 10 == 0
                # curr = Rotate.computeCost_3d(matrix_theta.to_a.transpose[0],matrix_x.to_a)
                # p "cost at iter" + i.to_s + " is :" + curr.to_s
            end
            if prev - Rotate.computeCost_3d(matrix_theta.to_a.transpose[0],matrix_x.to_a).to_f < 0
                # p prev_theta[0]
                return prev_theta[0]
            end
            alpha=0.1**4
            alphastore = alphastore+[alpha]
            # p "alpha: "
            # p alpha
            prev = Rotate.computeCost_3d(matrix_theta.to_a.transpose[0],matrix_x.to_a).to_f
            prev_theta = [matrix_theta.to_a.transpose[0]]
            matrix_theta = matrix_theta + ( NMatrix.new( [d.rows, d.cols], alpha)*d )
            dr = r
            r = -Rotate.computeCost_df_3d(matrix_theta.to_a.transpose[0],matrix_x.to_a)
            beta = (r.transpose.dot(r)) / (dr.transpose.dot(dr))
            beta = beta[0,0]
            # p "beta: "
            # p beta
            d = r + ( NMatrix.new( [d.rows, d.cols], beta)*d )
            i += 1
        end
        z = matrix_theta.to_a.transpose[0]
        # p z
        return z
    end



    # TODO: compute_Costs (2d,3d) and NCG
end