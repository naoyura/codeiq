# coding: utf-8

def solve(cond)
  es = []
  as = []
  cond.split(',').each do |d|
    as << $2.to_i if d =~ /角([ABC])=(\d+)度/
    es << $2.to_i if d =~ /([ABC]+)=(\d+)cm/
  end
  
  # 3辺が与えられている場合
  if es.size == 3
    # 3辺の長さが等しい
    return 'あ' if es.all?{|e|e == es.first}
    # 2辺の長さが等しい
    return 'い' if (es[0] == es[1]) || (es[1] == es[2]) || (es[2] == es[0])
    # それ以外
    return 'う'
  end

  # 2つ以上の内角が与えられている場合
  if as.size >= 2
    as << 180 - as.reduce(:+) if as.size == 2 # 3つ目の内角を求める
    # 3つの内角が等しい
    return 'あ' if as.all?{|a|a == 60}
    # 2つの内角が等しい
    return 'い' if (as[0] == as[1]) || (as[1] == as[2]) || (as[2] == as[0])
  end
  
  # 2辺の長さと1つ以上の内角が与えられている場合
  if es.size == 2 && as.size >= 1
    # 2辺の長さが等しく、1つの内角が60度なら正三角形
    return 'あ' if es[0] == es[1] && as.include?(60)
    # 上記以外の場合、二等辺三角形
    return 'い' if es[0] == es[1]
  end
  
  # 2辺の長さが与えられている場合  
  return 'い' if es.size == 2 && es[0] == es[1]
  
  # それ以外
  'う'
end

wa = []
$stdin.readlines.each do |line|
  no,cond,ans = line.chomp.split "\t"
  wa << no unless solve(cond) == ans
end
puts wa.join(',')  #=> 31,41,59,265,358,444,555,666,777,888,979,999