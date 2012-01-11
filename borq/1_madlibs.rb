# solution to simpler part
# puts gets.chop.gsub!( /\(\([^))]*\)\)/) { |w| w=gets.chop}

# part 2 - along with substitution
dict = {}
puts IO.read(ARGV.shift).chop.gsub!( /\(\([^))]*\)\)/) { |w|
  w = w.scan(/[^()]+/)[0]
  combo = w.split(":")
  if (combo.size==2)
    print "Enter #{combo[1]} : "
    w = dict[combo[0]] = gets.chop
  else
    if (dict[combo[0]] == nil)
      print "Enter #{combo[0]} : "
      w=gets.chop
    else
      w = dict[combo[0]]
    end
  end 
}