#Graham Roberts
#graham.roberts@uconn.edu


#mean residuals
#Input X: A vector of floats
#
#Returns: A vector V such that V_i = X_i-mean[X]
function meanResiduals(X)
   return X .- mean(X)
end

#Pearson Coefficient
#INPUT X: A vector of floats, length n
#      Y: A vector of floats, length n
# 
#RETURNS:
#   (Sum_{i=1}^n((X_i-mean[X])*(Y_i-mean[y])))
#----------------------------------------------------------
#   (Sum_{i=1}^n(X_i-mean[X])^2Sum_{i=1}^n(Y_i-mean[Y])^2)
function PearsonCoefficient(X, Y)
   Xresid = meanResiduals(X)
   Yresid = meanResiduals(Y)
   numerator = sum(Xresid .* Yresid)
   denominator = sum(Xresid.^2)*sum(Yresid.^2)
   return numerator/denominator
end

#isTriangle
#Input X:
#  this is an nX3 matrix where each line represents a potential triangle, and the three entries are the possible side lengths
#
#Computes whether or not the three lengths could possible be a triangle by computing the triangle inequality
#Assuming side c is the longest side three length form a triangle if A+B>C = A+B+C>2C =A+B+C-2C>0
#Returns a vector of the same length as the input array 1s indicate that the three sides could be a triangle, 0 otherwise
#Note: Does not assume that the thirs entry is the longest, it runs maximum to find that
function isTriangle(X)
   maxs = maximum(X, dims=2)
   return sum(X, dims=2)-(2*maxs).>0
end

function mean(x)
   return sum(x)/length(x)
end


function main()
   using Random; 
   Random.seed!(2022);
   n = 100
   x = randexp(n)
   y = x .+ randn(n)
   p = PearsonCoefficient(x, y)
   using DelimitedFiles;
   tlines = readdlm("triangle.csv", ',');
   vtriangles = isTriangle(tlines)
