# puts config.methods.inspect
# puts config.properties.inspect
# puts config.key_type

# puts config.String[0]
# config.defaults.sendary = "overwritten"
# config.defaults["sendary"] = "overwritten"
# config.defaults[:sendary] = "overwritten2"
# config.ymldoc_pfx = "yml_"
# config.reload_hooks
# puts config.methods.inspect
# puts config.properties.inspect
# puts config.yml_methods.inspect
# puts config.yml_properties.inspect
# puts config.properties.each {|p| puts "#{p} => " + eval("config.#{p}").inspect }
# puts config.properties.pretty_print
# puts config.filename


# config.load("new.yml")
# config.save
# puts ""
# config.save() do |c|
#   c.leftjustify = true
# end
# config.save
# puts config.yml_service_hooks.inspect
# 
# puts config.hooks.inspect
# config.hook_pfx=("_")
# puts config.hook_pfx.inspect
# config.reload_hooks
# puts config._hooks.inspect
# puts config.hooks.inspect
# config.save

# require 'matrix'
# config.matrix = Matrix[ [25, 93], [-1, 66] ]

# class Car
#   # attr_accessor :wheels, :engine, :doors, :trunk
#   @wheels = 4
#   @engine = "Big V-6"
#   @doors = 5
#   # def initialize(*args, &block)
#   #   case args.first
#   #   when Hash
#   #     args.first.each do |k,v|        
#   #       s = k.to_s
#   #       eval "self.#{s} = v"
#   #     end
#   #   end
#   # end
# end

# car = Car.new :wheels => 4, :engine => "2.4 Litre Diesel", :doors => 5
# car = Car.new
# puts car.inspect

# config.car = car
# config.car.trunk = "hatchback"
# car.engine = "2.4 Litre Diesel"
# config.car = Car.new :wheels => 4, :engine => "2.4 Litre Diesel", :doors => 5

# config.car.engine = "No engine"
# car.engine = "EasyJet"

# puts ""
# puts car.class.to_s.match("Array|String|Hash")
# puts car.class.to_s.match("Array|String|Hash|Car")
# puts config.yml_filename

# puts "car=#{car.inspect}"
# puts ""
# puts "config.car=#{config.car.inspect}"
# puts "------------------------------------------------------"
# puts ""

# config._foo = "bartender"
# config._foo = String.new "bartender"
# config._root = "somestring"

# # service hook
# config._filename = "filename"
# config._.filename = "filename"
# config._.merge! { filename => "filename" }

# config.defaults.insert "x-plane"
# config.defaults.delete "a"
# config.defaults.update({})
# config.defaults.replace "one"=> 1, :two => 2
# 
# 
# config.tee = "chocolate"
# puts "config[\"tee\"]=#{config["tee"]}"
# config.tee.upcase!
# 
# config.moon = "the lazy cat"
# config.moon.upcase!
# 
# puts config.inspect
# config.__write_file

# puts config.sub1
# config.sub1.a1 = [1]
# # puts config.sub1.a1.inspect
# config.sub1.a1[1] = 2
# # config.sub1.a1 << 2
# # puts config.sub1.a1.inspect
# config.sub1.a1 = [1,2,3]
# # config.sub1.a1.insert (0,3)
# config.sub1.a1.compact!
# # puts config.sub1.a1.inspect

# config[1] = "foo"
# config[2] = "bar"
# puts config.inspect
# config._save

# require 'yamldoc'
# class Settings < AutoYamlDoc
#   self.filename = File.expand_path("~/.moonshadow")
#   self.key_type = Symbol 
#   self.deep_clone = true
#   # self.service_hook = "yml_"
# end

# config = Settings.new() do |c|
#   # c.defaults = {"one"=> 1, :two => 2}
#   c.defaults = {"a"=> 1, :sendary => 3}
#   c.defaults.array = [1,2,3,4]
#   # config = [1,2,3,4]
# end

# puts "YamlDoc  "+YamlDoc.properties.inspect
# puts "AutoYaml "+AutoYamlDoc.properties.inspect
# puts "Settings "+Settings.properties.inspect
# config = Settings.new
# config.key_type = String
# puts "object   "+config.properties.inspect
# puts "object   "+config.instance_eval("@_").inspect
# 
# puts "YamlDoc  "+YamlDoc.properties.inspect
# puts "AutoYaml "+AutoYamlDoc.properties.inspect
# puts "Settings "+Settings.properties.inspect
# 
# puts "AutoYaml autosave = "+AutoYamlDoc.autosave.inspect
# puts "YamlDoc autosave  = "+YamlDoc.autosave.inspect
# puts "YamlDoc key_type  = "+YamlDoc.key_type.inspect


# puts "AutoYamlDoc.object_detection=#{AutoYamlDoc.object_detection}"

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

