module Font
  def self.register c, &block
    @faces ||= {}
    @faces[c.to_s.upcase] = @faces[c.to_s.downcase] = Face.new &block
  end
  def self.face c
    @faces[c.to_s[0]] || none
  end
  def self.none
    Face.new{-1}
  end
  def self.aa_table
    [
      %$MM#TT$,
      %$Qd0V*$,
      %$par<"$,
      %$gu(:^$,
      %$g,,. $
    ]
  end
  class Face
    def initialize &defs
      @defs = defs
    end
    def value x, y
      scale = 1.2
      @defs.call(scale*x, scale*y, Math.atan2(y, x), scale*Math.sqrt(x*x+y*y))
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
    register(:a){|x,y|1/2.0+32/(1+512*(x**4+(y+1/4.0)**2))-x**6-(3/2.0-2*y-8*x**2+5*x**4)**2}
    register(:b){|x,y|2-1/(Math.cos(4*y)**2+16*x**4)-8*(x-(Math.sqrt(16/16-Math.cos(7*y))-1)/5/(1+Math.exp(-8*x)))**4-y**4}
    register(:c){|x,y,th|1/2.0-((1+Math.cos(th))/2)**16-(4*x**2+3*y**2-2)**2}
    register(:d){|x,y|1/12.0-(y**2+(3*x/2+y**2/2+y**4/16)**2-3/4.0)**2}
    register(:e){|x,y|2-6*x**4-y**4-4*(1-Math.cos(4*y)**4)/(1+Math.exp(-16*x-8))}
    register(:f){|x,y|2-8*x**4-2*y**4+y**2-2*(1-Math.cos(y**2+3*y)**6)*(2-y)/(1+Math.exp(-16*x-6))}
    register(:g){|x,y,th|1/2.0-((1+Math.cos(th))/2)**16+2/(1+4*(4*x-1)**8+2*(8*y+2)**4)-((2*x+1/(4+4*(2*x-1)**4+(4*y+1)**4))**2+3*y**2-2)**2}
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
    register(:x){|x,y,th,r|3*Math.atan((2+Math.tan(2*th-Math.sin(2*th)/4)**2)/6)-4*r}
    register(:y){|x,y,th,r|3*Math.atan((2+Math.tan(3*th/2+Math::PI/4-Math.cos(th)/2-Math.sin(2*th)/4)**2)/8)-4*r}
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

msg = ARGV[0] || "hello ruby "
chars = msg.chars.map{|c|
  Font.chars(c, 46*2)
}

loop.with_index{|_,i|
  t = i/20.0%msg.size
  x = ->x{3*x*x-2*x*x*x}
  lines = Font.mix_char msg[t.to_i], msg[(t.to_i+1)%msg.size], t%1, 48
  $><< "\e[1;1H"
  puts lines
  sleep 0.05
}
