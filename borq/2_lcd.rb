require 'rubygems'
require 'choice'

Choice.options do
  banner 'q2_lcd_numbers.rb [-shv] string'
  
  separator 'Optional:'
  option :size do
	short '-s'
	desc 'digit size'
	cast Integer
	default 1
  end

  separator 'Common:'
  option :help do
	short '-h'
	long '--help'
	desc 'Show this message.'
  end

  option :version do
	short '-v'
	long '--version'
	desc 'Show version.'
	action do
	  puts 'LCD generator 0.1'
	  exit
	end
  end
end

def paint_map(map,digit,size,start)
  # upper, mid, bottom
  for i in (start+1)...(start+size+1)
    if $digits[digit][0] == 1
      map[[0,i]] = 2
    end
    if $digits[digit][3] == 1
      map[[0 + size + 1,i]] = 2
    end
    if $digits[digit][6] == 1
      map[[0 + size*2 + 2,i]] = 2
    end
  end
  # verticals
  for i in 1...size+1
    if $digits[digit][1] == 1
      map[[i,0+start]] = 1
    end
    if $digits[digit][2] == 1
      map[[i,size+1+start]] = 1
    end
    if $digits[digit][4] == 1
      map[[i+size+1,0+start]] = 1
    end
    if $digits[digit][5] == 1
      map[[i+size+1,size+1+start]] = 1
    end
  end
end

def print_map(map, size, total_digits)
  for j in 0...(size*2+3)
    for i in 0...(total_digits*(size+3))
      if map[[j,i]] == 2
        print '-'
      elsif map[[j,i]] == 1
        print '|'
      else
        print ' '
      end
    end
    puts ''
  end
end

def drive_paint(map, string, size)
  i = 0
  j = 0
  while (i<string.size*(size+3))
    paint_map(map,string[j..j].to_i,size,i)
    i += size+3
    j += 1
  end
end

#  _      0
# | |     1 2
#  -      3
# | |     4 5
#  -      6

$digits = [ 
  [1,1,1,0,1,1,1], [0,0,1,0,0,1,0], # 0 1
  [1,0,1,1,1,0,1], [1,0,1,1,0,1,1], # 2 3
  [0,1,1,1,0,1,0], [1,1,0,1,0,1,1], # 4 5
  [1,1,0,1,1,1,1], [1,0,1,0,0,1,0], # 6 7
  [1,1,1,1,1,1,1], [1,1,1,1,0,1,0], # 8 9
]

string = ARGV[-1]
size = Choice.choices[:size]
digitmap = {}

drive_paint(digitmap, string, size)
print_map(digitmap, size, string.size)
