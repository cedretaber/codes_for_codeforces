require "open3"

loop do
  a = rand(1..200)
  b = rand(1..200)
  l = rand(1..200)
  r = rand(l..1000)

  res = (l..r).count { |n| n%a%b != n%b%a }.to_s

  stdin, stdout, _, _ = Open3.popen3('./c')
  stdin.puts "1"
  stdin.puts "#{a} #{b} 1"
  stdin.puts "#{l} #{r}"
  out = stdout.gets.chomp
  if out != res
    puts "Fail! a=#{a}, b=#{b}, l=#{l}, r=#{r}, expected: #{res}, but: #{out}"
    exit!
  end
end