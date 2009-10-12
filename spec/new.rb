
# config = Settings.new("filename")
# config = Settings.new("file.yml"){}
# config = Settings.new :filename => "file.yml", :autosave => true
# config = Settings.new(:filename => "file.yml", :autosave => true){}
# config = Settings.new

# config.sub2.hash1.two = 2
# config.sub2.hash1.three = 3
# config.sub1.a1 = [1,2,3]
# config.strings.about = "About string for this ruby application"
# 
# require 'matrix'
# config.matrix = Matrix[ [25, 93], [-1, 66] ]
# config.strings.about.reverse!
# puts config.strings.about

# puts config.sub1
# config.sub1.a1 = [1]
# puts config.sub1.a1.inspect
# # config.sub1.a1 = [2]
# config.sub1.a1 << 2
# puts config.sub1.a1.inspect
# config.sub1.a1 = [1,2,3]
# config.sub1.a1.insert (0,3)
# puts config.sub1.a1.inspect
# 
# # puts config.sub1.hash1.inspect
# config.sub1.sub2.hash1 = {"2" => 2, "three" => 3, :three => "three"}
# puts config.sub1.sub2.hash1.inspect

# config = Settings.new "filename"
# config = Settings.new "filename2"
# config = Settingslogic.new "filename2"
# puts config.ancestors
# config = Settings.new(:config1 => 1, :config2 => 2)
# config[:config1] = 1
# config[:config2] = 2
# config[:blue] = "Nixon"
# puts config.blue
# # config["blue"] = 3
# config["blue"] = "four"
# puts config.blue

# puts ""
# # puts config[:config2]
# # puts config.settings
# puts config.blue
# # puts config.config2
# 
# config.blue = "canary"
# puts config.blue

# config.sub1.hash1 = {"2" => 2, "three" => 3, :three => "three"}
# config.sub1 = {}

# config.foo = {"hash1"=>"one"}
# config.yellow = true

# config = Settings.new
# config.transaction("file.yml", hash){ |config|
#   # config.defaults = {"one"=> 1, :two => 2}
#   # config.defaults.array = [1,2,3,4]
#   config.defaults = {"one"=> 1, :two => 2}
#   # config = [1,2,3,4]
#   }

