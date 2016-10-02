# Enter your code here. Read input from STDIN. Print output to STDOUT
# This solution is for HackerRank which is a more general solution for Project Euler

require 'matrix'

T = gets.to_i # number of inputs
Root5 = Math.sqrt(5)
Alpha = (1+Root5)/2
A = Matrix[[1,1],[1,0]]

i = 1
while i<=T do
    a = gets.to_i - 1
    aPower10 = 10 ** a
    lower = ((a+Math.log(Root5, 10))/Math.log(Alpha, 10)).ceil
    matrix = A ** (lower+1)
    if matrix[1, 1] >= aPower10
        puts lower
    elsif matrix[0, 1] >= aPower10
        puts (lower + 1)
    elsif matrix[0, 0] >= aPower10
        puts (lower + 2)
    else
        matrix = matrix * (A**3)
        if matrix[1, 1] >= aPower10
            puts (lower + 3)
        elsif matrix[0, 1] >= aPower10
            puts (lower + 4)
        else
            puts (lower + 5)
        end
    end
    i+=1
end