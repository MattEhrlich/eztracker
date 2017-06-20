a = [[1,2,3],[4,5,6],[7,8,9]]
p a.transpose
a.transpose[2] = a.transpose[1].collect{|e| e*30}
p a.transpose