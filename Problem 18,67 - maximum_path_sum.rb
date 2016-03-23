# We use dynamic programming to remember the maximum sum at each position

def max(a, b)
  a > b ? a : b
end

tri = "3 7 4 2 4 6 8 5 9 3"
triArray = tri.split(' ')
len = tri.length
max_sum = Array.new(len, 0)
noRow = ((Math.sqrt(8*len+1)-1)/2).to_i # noRow * (noRow+1) / 2 = len

sum = 0
row = 1
while row<=noRow do
  # i is the counter of each row from 0 to row-1
  i = 0
  while i < row do
    # The index of the first element of each row is sum
    # The first element of each row has one parent only
    if i==0
      max_sum[sum+i] = max_sum[sum+i-row+1] + triArray[sum+i].to_i
    end
    # Not the first nor the last element, i.e. two parents
    if i!= 0 && i!= row-1
      # Left parent
      tmp1 = max_sum[sum+i-row] + triArray[sum+i].to_i
      # Right parent
      tmp2 = max_sum[sum+i-row+1] + triArray[sum+i].to_i
      max_sum[sum+i] = max(tmp1, tmp2)
    end
    # The last element of each row has one parent only
    if i==row-1
      max_sum[sum+i] = max_sum[sum+i-row] + triArray[sum+i].to_i
    end
    i+=1
  end
  sum += row
  row += 1
end

puts max_sum.max