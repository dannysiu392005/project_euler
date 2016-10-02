# The following solution is for Hacker Rank - Project Euler #123: Prime square remainders
# It is a more general solution

$primes = [2, 3, 5, 7]
# $hash[x] stores the least value of n for which the remainder first exceeds x
$hash = {}
# The biggest remainder occured and the corresponding least value of n for which 
# the remainder first exceeds it
$biggest_r = 0
$biggest_n = 1

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

# Using some basic modulo operation, you can obtain the following result
def calRemainder(pN, n)
    if n % 2 == 0
        2
    else
        # 2*n*pN <= 2 * pN * pN if and only if n <= pN which is true for all n
        # For those which exceed pN * pN, simply minus pN * pN
        r = 2 * n * pN
        r = r - pN * pN if r >= pN*pN
        r
    end
end

def binary_search(primes, left, mid, right, wantedRemainder)
    returnV = 1
    while true do
        r = calRemainder(primes[mid-1], mid)
        r2 = calRemainder(primes[mid+2-1], mid+2)
        midPlus2 = mid + 2
        midMinus2 = mid - 2
        if r < wantedRemainder
            left = mid
            mid = (left + right) / 2
            mid -= 1 if mid % 2 == 0
            if r2 > wantedRemainder
                returnV = midPlus2
                break
            end
        elsif r > wantedRemainder
            r3 = calRemainder(primes[midMinus2-1], midMinus2)
            oldMid = mid
            right = mid
            mid = (left + right) / 2
            mid -= 1 if mid % 2 == 0
            if r3 < wantedRemainder
                returnV = oldMid
                break
            end
        else
            returnV = midPlus2
            break
        end
    end
    returnV
end

num = gets.to_i
i = 1
while i <= num do
    wantedRemainder = gets.to_i
    if $hash[wantedRemainder].nil?
        if wantedRemainder == 1
            $hash[wantedRemainder] = 2
            puts 2
        elsif wantedRemainder == 2
            $hash[wantedRemainder] = 3
            puts 3
        else
            j = 1
            if wantedRemainder > $biggest_r
                j = $hash[$biggest_r] unless $hash[$biggest_r].nil?
                # As calRemainder is always 2 if j is even
                # we need to make sure j is odd before going forward
                j += 1 if j % 2 == 0
                while calRemainder($primes[j-1], j) <= wantedRemainder do
                    j+=2
                    genNextPrime if $primes[j-1].nil?
                    genNextPrime if $primes[j].nil?
                end
            else
                # wantedRemainder won't equal $biggest_r otherwise $hash[wantedRemainder].nil? won't be true at the beginning
                left = 1
                right = $biggest_n
                mid = (left + right) / 2
                mid -= 1 if mid % 2 == 0
                j = binary_search $primes, left, mid, right, wantedRemainder
            end
            puts j
            $hash[wantedRemainder] = j
        end
    else
        puts $hash[wantedRemainder]
    end
    if wantedRemainder > $biggest_r
        $biggest_r = wantedRemainder
        $biggest_n = $hash[wantedRemainder]
    end
    i+=1
end