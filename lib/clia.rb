# clia.rb - Class Level Inheritable Attributes

class Object
  def deep_clone; Marshal::load(Marshal.dump(self)); end
end

module ClassLevelInheritableAttributes
   def inheritable_attributes(*args)
     (class << self; self; end).class_eval do
       attr_accessor *args
     end

     @inheritable_attributes ||= []
     @inheritable_attributes.concat(args)
   end

   def inherited(subclass)
     inheritable_attributes.each do |a|
       puts "a=#{a}"
       puts "value="
       puts send(a).inspect
       # subclass.send("#{a}=", send(a)) # shared
       subclass.send("#{a}=", send(a).deep_clone)
     end
     super
   end
end

class Object
  extend ClassLevelInheritableAttributes
end

