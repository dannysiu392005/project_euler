a = 999
b = 999

final_a = 0
final_b = 0
result = 0

while a >= 101 do
  b = a
  while b>=101 do
    tmp = a*b
    break if tmp < result
    if tmp == tmp.to_s.reverse.to_i
      if tmp > result
        result = tmp
        final_a = a
        final_b = b
      end
    end
    b-=1
  end
  a-=1
end

puts "The result is #{result}"
puts "The final_a is #{final_a}"
puts "The final_b is #{final_b}"