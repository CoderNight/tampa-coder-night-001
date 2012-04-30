Dir.glob('lib/**/*.rb').sort.each do |filename| 
  require filename
end
