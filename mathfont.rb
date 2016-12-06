module Font
  def self.register c, &block
    @faces ||= {}
    @faces[c.to_s.upcase] = @faces[c.to_s.downcase] = Face.new &block
  end
  def self.face c
    @faces[c.to_s[0]] ||= none
  end
  def self.none
    @none ||= Face.new{-1}
  end
  def self.aa_table
    [
      'MM#TT',
      'Qd0V*',
      'par<?',
      'gu!:^',
      'g,,. '
    ]
  end
  class Face
    def initialize &defs
      @defs = defs
    end
    def value x, y
      n = 128
      ix, iy = [x,y].map { |v| i = (n*(v+1)/2.0).round; i < 0 ? 0 : i >= n ? n-1 : i }
      @values ||= (0...n).to_a.repeated_permutation(2).map do |ix, iy|
        __value 2.0*ix/n-1, 2.0*iy/n-1
      end
      @values[n*ix+iy]
    end
    def __value x, y
      scale = 1.2
      @defs.call(scale*x, scale*y, scale*Math.sqrt(x*x+y*y), Math.atan2(y, x))
    end
    def include? x, y
      value(x, y) > 0
    end
  end
  module Definitions
    def self.register *args, &block
      Font.register *args, &block
    end
    include Math
    register('!'){|x,y|(1/32.0-x**2-(y+3/4.0)**2)*(4*x**2+(y-1/3.0)**6-1/8.0)}
    register('"'){|x,y|1-(16*x**4+1/64.0/x**2-1/4.0)*16**(1-y)-(4*y-3)**2}
    register('#'){|x,y|1/4.0-(((3*x-y/2)**2+4*y**2)/5)**8-(Math.cos(6*x-y)*Math.cos(4*y))**2}
    register('$'){|x,y,r,th|1/4.0-(32*(r*Math.cos(th+8*r-4*r**2-7/2.0))**2+(r*Math.sin(th+8*r-4*r**2-7/2.0))**4-1/2.0)*(32*x**2+4*y**2*(y**2-1/2.0)**4-1/32.0)}
    register('%'){|x,y|(((6*x+2)**2+(6*y-3)**2-2)**2-2)*(((6*x-2)**2+(6*y+3)**2-2)**2-2)*(3-(12*x-8*y)**2-(y+3*x/4)**8)}
    register('&'){|x,y|1-13/(16+100*y**2)-1/80.0/((x+1/16.0)**2+(y-7/16.0)**2)-1/(30*(x-(5*y+1)/15)**2+50*(y+2/5.0)**2)-3*(x+(1-y)/8)**2*Math.exp(y/2)-2*y**4+2/(1+10*(x-y-1)**4+80*(x+y)**2)+2/(1+80*(x-y-3/4.0)**2+10*(y+x-3/4.0)**4)}
    register("'"){|x,y|1-24*x**2*8**(1-y)-(4*y-3)**2}
    register('('){|x,y|1-(8*x-4*y**2+2)**2-y**16}
    register(')'){|x,y|1-(8*x+4*y**2-2)**2-y**16}
    register('*'){|x,y,r,th|3-Math.cos(6*th)-6*r}
    register('+'){|x,y,r,th|2+Math.cos(4*th)+Math.cos(8*th)/6-5*r}
    register(','){|x,y|1/32.0-x**2-(y+3/4.0)**2-128*x*y/(1+(128*x)**2+(64*y+72)**2)}
    register('-'){|x,y|1-6*x**4-40*y**2}
    register('.'){|x,y|1/32.0-x**2-(y+3/4.0)**2}
    register('/'){|x,y|8-64*(y-2*x)**2-(y+x/2)**8}

    register(':'){|x,y|-(1/32.0-x**2-(y+3/4.0)**2)*(1/32.0-x**2-(y-1/2.0)**2)}
    register(';'){|x,y|-(1/32.0-x**2-(y+3/4.0)**2-128*x*y/(1+(128*x)**2+(64*y+72)**2))*(1/32.0-x**2-(y-1/2.0)**2)}
    register('<'){|x,y|1-(4*x+3-3*Math.sqrt(1+32*y**2)/2)**2-64*y**8}
    register('='){|x,y|1-3*x**4-10*y**4-1/20.0/y**2}
    register('>'){|x,y|1-(4*x-3+3*Math.sqrt(1+32*y**2)/2)**2-64*y**8}
    register('?'){|x,y|20-1/(2*(x-y/2+1/3.0)**2+y**2)**2+1/(x**2+(y+3/4.0)**2)**2+1/8.0/(4*x**2+(y+1/4.0)**2)**2-(24*x**2+48*(y-1/3.0)**2-6)**2}
    register('@'){|x,y|2/(1+2*(8*x**2+8*y**4-2)**4)+1/(1+(12*(x-1/5.0)**2+(2*y+1/4.0)**4-1)**4)+4/((4*x-1)**4+(24*y+16)**2)-1}

    register('['){|x,y|1-128/(1+16*(2*x-1)**8+(2*y)**16)-32*x**4-2*y**8}
    register('\\'){|x,y|8-64*(y+2*x)**2-(y-x/2)**8}
    register(']'){|x,y|1-128/(1+16*(2*x+1)**8+(2*y)**16)-32*x**4-2*y**8}
    register('^'){|x,y|1-(6*y-5+Math.sqrt(1+32*x**2))**2-64*x**8}
    register('_'){|x,y|1-6*x**4-40*(y+4/5.0)**2}
    register('`'){|x,y|1/4.0-(2*x-y+5/6.0)**4-4*(2*y-5/3.0+x)**2}

    register('{'){|x,y|1-(8*x+2*y**2-3*y**4+3/(2+64*y**2))**2-y**16}
    register('|'){|x,y|4-256*x**2-y**16}
    register('}'){|x,y|1-(8*x-2*y**2+3*y**4-3/(2+64*y**2))**2-y**16}
    register('~'){|x,y|1/32.0-x**8-(y+Math.sin(6*x)/8)**2}

    register(0){|x,y|1-(8*(x-y/8)**2+4*y**2-8/3.0)**2}
    register(1){|x,y|1-32*(x-y/8)**2-2*y**8}
    register(2){|x,y|1/32.0-Math.exp(-4*x-2*y-4)+1/(2*(x-1/8)**8+4*(4*y+3)**2)-((x+(1-y)/2)**2+y**2-1/2.0)**2}
    register(3){|x,y|1-8*x**2/(1+64*y**2)-1/(20*(x+(1-y)/8)**2+32*(y-2/5.0)**2)-1/(20*(x+(1-y)/8)**2+20*(y+2/5.0)**2)-(Math.exp(y/2-4*x)-y**2)/8-2*(x+(1-y)/8)**2-y**4}
    register(4){|x,y|1-1/((x-1/8.0)**2+((4*y-3)/2)**2)-(12*(x-y/3)**2+2*y-2/3.0+(2*y-2/3.0)**4-1/2.0)*(12*(x-y/3)**2+3*y-1+16*(y-1/3.0)**4-2)*((8*x-3-y/2)**2+(2*y+1)**4-1)}
    register(5){|x,y|1+1/((2*x-1)**4+(5*y-4)**2)-(x/4+y)**4-(8*x-2*y+2+4*Math.sin((x+4*y)*5/6)/(1+Math.exp(4*x+16*y)))**2}
    register(6){|x,y|4/(1+32*(x**2+(y+1/2.0)**2-1/5.0)**2)+4/(1+32*(x+(1-y)/3-y**2/2)**2+4*(y-1/2.0)**4)-3}
    register(7){|x,y|2-(4*x+4*y-1+8*(x-y)/3-3*Math.cos((12*x-12*y+3)/5))**2-(x-y+1/4.0)**4}
    register(8){|x,y|1-1/(4+64*y**2)-1/(20*(x-y/8)**2+32*(y-2/5.0)**2)-1/(16*(x-y/8)**2+24*(y+2/5.0)**2)-2*(x-y/8)**2*Math.exp(y/4)-y**4}
    register(9){|x,y|4/(1+32*(x**2+(y-1/2.0)**2-1/5.0)**2)+4/(1+32*(x-(1+y)/3+y**2/2)**2+4*(y+1/2.0)**4)-3}

    register(:a){|x,y|1/2.0+32/(1+512*(x**4+(y+1/4.0)**2))-x**6-(3/2.0-2*y-8*x**2+5*x**4)**2}
    register(:b){|x,y|2-1/(Math.cos(4*y)**2+16*x**4)-8*(x-(Math.sqrt(16/16-Math.cos(7*y))-1)/5/(1+Math.exp(-8*x)))**4-y**4}
    register(:c){|x,y,r,th|1/2.0-((1+Math.cos(th))/2)**16-(4*x**2+3*y**2-2)**2}
    register(:d){|x,y|1/12.0-(y**2+(3*x/2+y**2/2+y**4/16)**2-3/4.0)**2}
    register(:e){|x,y|2-6*x**4-y**4-4*(1-Math.cos(4*y)**4)/(1+Math.exp(-16*x-8))}
    register(:f){|x,y|2-8*x**4-2*y**4+y**2-2*(1-Math.cos(y**2+3*y)**6)*(2-y)/(1+Math.exp(-16*x-6))}
    register(:g){|x,y,r,th|1/2.0-((1+Math.cos(th))/2)**16+2/(1+4*(4*x-1)**8+2*(8*y+2)**4)-((2*x+1/(4+4*(2*x-1)**4+(4*y+1)**4))**2+3*y**2-2)**2}
    register(:h){|x,y|-5*(16*x**8+y**8-1)-9/((5*x/2)**16+2*(y**2-1)**4)}
    register(:i){|x,y|2-(8*x)**4-y**8}
    register(:j){|x,y|1/6.0-Math.exp(8*y-10/(1+Math.exp(-16*x)))-(3*x**2+6*(y/2-1/4.0)**4-1)**2}
    register(:k){|x,y|1/8.0-64*x**8-((x+1/8.0-Math.sqrt(1/64.0+y**2))**2-1/32.0)*((8*x+3)**2+y**8-1)}
    register(:l){|x,y|1-16*x**8-y**8-64.0/((2*x-1)**8+(y-1)**8)}
    register(:m){|x,y|1-12/(4+4*(2*x)**8+(y-2+(4+6*x**4)/(1+2*x**2))**8)-8*x**8-(y+(4+6*x**4)/(1+2*x**2)-11/4.0)**8}
    register(:n){|x,y|1/(4+64*(2*x+y)**2)-64*x**8+8*x**4-(y-x/8)**8-1/8.0}
    register(:o){|x,y|1/4.0-(3*x**2+2*y**4-1)**2}
    register(:p){|x,y|1-((8*x**2+2*(2*y-1)**2-2)**2-1)*((8*x+4)**4+y**8-1)}
    register(:q){|x,y|1/4.0+(2+4*x)/(1+(8*y-2*Math.cos(3*x)+5)**8)/(1+Math.exp(-32*x-10))-(3*x**2+2*y**4-1)**2}
    register(:r){|x,y|-(Math.atan(3*x**2+3*(y-1/2.0)**2)*Math.atan((8*x+4)**4+y**8)*Math.atan((8*x-1+2*y)**4+4*(y+1/4.0)**4)-2)*(8*x**2+2*(2*y-1)**2-1)}
    register(:s){|x,y|1/6.0-x**4-((x-y/2)**3+2*(x+y)*(1-(y+x/4)**2))**2}
    register(:t){|x,y|1-(4*x**8+3*(4*y-3)**2-1)*(32*x**2+3*(y+1/4.0)**8-1)}
    register(:u){|x,y|1/6.0-Math.exp(16*y-16)-(3*x**2+5*(y/2-1/4.0)**4-1)**2}
    register(:v){|x,y|1/2.0-x**6-(2*y+3/2.0-8*x**2+5*x**4)**2}
    register(:w){|x,y|1-x**8-(3*y-2*Math.cos(6*x)-3*x**2+2*x**4)**2}
    register(:x){|x,y,r,th|3*Math.atan((2+Math.tan(2*th-Math.sin(2*th)/4)**2)/6)-4*r}
    register(:y){|x,y,r,th|3*Math.atan((2+Math.tan(3*th/2+Math::PI/4-Math.cos(th)/2-Math.sin(2*th)/4)**2)/8)-4*r}
    register(:z){|x,y|1/(4+128*(x-y)**2)-2*y**8+5*y**4/4-(x+y/8)**8-1/8.0}
  end
  def self.chars char, size
    font = face char
    to_aa(size){|x,y|font.include? x,y}
  end
  def self.mix_char c1, c2, val, size
    f1, f2 = face(c1), face(c2)
    to_aa(size){|x,y|
      d1, d2 = val, val-1
      v1 = f1.value(x+d1/2,y-d1/4)
      v2 = f2.value(x+d2/2,y-d2/4)
      Math.atan(v1)*(1-val) + val*Math.atan(v2) > 0
    }
  end
  def self.to_aa size, &block
    (size/2).times.map{|iy|
      s=size.times.map{|ix|
        u, d = 2.times.map{|ud|
          2.times.to_a.repeated_permutation(2).count{|jx, jy|
            x, y = (ix+jx.fdiv(2))/size*2-1, 1-(2*iy+(ud+jy.fdiv(2)))/size*2
            block.call x, y
          }
        }
        aa_table[4-u][4-d]
      }.join
    }
  end
end


require 'io/console'
h, w = ($>.winsize rescue [24, 80])
msg = ARGV[0] || "hello ruby "
msg.chars.each{|c|puts Font.chars(c, h)}
sleep 1
$> << "\e[1;1H"
loop.with_index{|_,i|
  h, w = ($>.winsize rescue [24, 80])
  t = i/20.0%msg.size
  x = ->x{3*x*x-2*x*x*x}
  lines = Font.mix_char msg[t.to_i], msg[(t.to_i+1)%msg.size], x[t%1], 2*h
  print lines.map{|s|s[0,w]}.join("\n")
  $> << "\e[1;1H"
  sleep 0.05
}
