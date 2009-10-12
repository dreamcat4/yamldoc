# clia.rb - Class Level Inheritable Attributes

module ClassLevelInheritableAttributes
   def inheritable_attributes(*args)
     (class << self; self; end).class_eval do
       attr_accessor *args
     end

     @inheritable_attributes ||= []
     @inheritable_attributes.concat(args)
   end

   def inherited(subclass)
     inheritable_attributes.each do |attr|
       subclass.send("#{attr}=", send(attr))
     end
     super
   end
end

class Object
  extend ClassLevelInheritableAttributes
end

