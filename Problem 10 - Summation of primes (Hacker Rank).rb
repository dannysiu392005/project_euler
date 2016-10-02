# Enter your code here. Read input from STDIN. Print output to STDOUT

$primes = [2, 3, 5, 7]

# Assume a is odd
def isPrime?(a)
    rootA = Math.sqrt(a).round
    $primes.each do |prime|
        if prime > 2 && prime <= rootA
            if a % prime == 0
                return false
            end
        elsif prime > rootA
            break
        end
    end
    true
end

def genNextPrime
    # Except 2, all primes are add
    tmp = $primes[-1] + 2
    while isPrime?(tmp) == false do
        tmp += 2
    end
    $primes << tmp
end

# Precompute all the primes less than 1000000
while $primes[-1] < 1000000 do
    genNextPrime
end

# Precompute the result for all n
result = [0, 0, 2]
i = 3
prime_index = 2
while i<=1000000 do
    sum = 0
    while $primes[prime_index-1] <= i do
        sum = sum + $primes[prime_index-1]
        prime_index+=1
    end
    result[i] = sum + result[i-1]
    i+=1
end

num = gets.to_i
i = 1
while i <= num do
    n = gets.to_i
    puts result[n]
    i+=1
end