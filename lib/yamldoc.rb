require "yaml"
require "erb"
require "class_attributes"

class Object
  if RUBY_VERSION >= '1.9'
    def to_yaml_properties; instance_variables - [:@_,:@_ro,:@_yp,:@_ym,:@_as]; end
  else
    def to_yaml_properties; instance_variables - ["@_","@_ro","@_yp","@_ym"]; end
  end
  def deep_clone; Marshal::load(Marshal.dump(self)); end
end

class YamlDoc < Hash
  private
  has_class_object_attributes; co_attr_i :_

  @_ = {  
    :filename => nil,
    :key_type => String,
    :force_keys => false,
    :object_detection => false,
    :autosave => false,
    :deep_clone => false,
    :ymldoc_pfx => ""
  }

  def self.properties ; @_ ; end

  def self.inherit(*args, &block)
    # define class accessors for @_ (properties)
    @_.keys.each do |sym|
      getter = sym
      self.class.send(:define_method, getter) { @_[sym] }    
      setter = (sym.to_s+"=").to_sym
      self.class.send(:define_method, setter) { |val| @_[sym] = val }
    end    
  end

  def initialize(*args, &block)

    @_ro = self
    self.send(:reload_hooks)

    case args.first
      when String
        @_[:filename] = args.first
      when Hash
        @_.merge! args.first
      when nil
        ;;
      else
        args.each do |obj|
          self["#{obj.class.inspect}"] ||= []
          self["#{obj.class.inspect}"] << obj
        end
    end
    
    load()
    save(&block) if block_given?
  end

  def inspect
    YAML.dump self
  end

  def load(file=nil)
    f = file || @_[:filename]
    if f
      if File.exists? f
        # yaml = YAML.load(ERB.new(File.read(f)).result)
        yaml = YAML.load(File.read(f))
        hash = yaml.to_hash if yaml
      end

      hash = Hash.new if hash.nil?
      self.merge! hash
      @_[:filename] = f
    end
  end

  def save(file=nil,&block)
    @_[:filename] &&= file
    # always disable autosave for effecient write
    @_as = @_[:autosave] ; @_[:autosave] = false
    _call_block(block) if block_given?
    @_[:autosave] = @_as ; _write_file
  end

  def _call_block(block)
    if block.arity == 1
      # puts "block=#{block}"
      block.call(self)
    else
      raise "Wrong number of arguments (#{block.arity}). This block takes 1 argument"
    end
  end

  def properties ; @_ ; end

  def methods ; @_ym ; end

  def reload_hooks
    pfx = @_[:ymldoc_pfx].to_s

    old_props = @_yp || [] ; @_yp = []
    old_props.each do |sym|
      self.class.send(:remove_method,sym)
    end

    @_.keys.each do |sym|
      getter = (pfx+sym.to_s).to_sym
      self.class.send(:define_method, getter) { @_[sym] }
      @_yp << getter

      setter = (pfx+sym.to_s+"=").to_sym
      self.class.send(:define_method, setter) { |val| @_[sym] = val }
    end
    
    old_methods = @_ym || [] ; @_ym = []
    old_methods.each do |sym|
      self.class.send(:remove_method,sym)
    end

    [:inspect, :load, :save, :methods, :properties, :reload_hooks].each do |sym|
      m = (pfx+sym.to_s).to_sym
      self.class.send(:define_method, m, self.method(sym))
      @_ym << m
    end
  end

  module HashChanged
    def self.object_changed_methods(obj=nil)
      hash_keys_method = [:[]=]
      [:[]=,:clear,:default=,:delete,:delete_if,:merge!,:rehash,:reject,
      :reject!,:replace,:shift,:store,:update] - hash_keys_method
    end
  end
  module ArrayChanged
    def self.object_changed_methods(obj=nil) 
      [:<<,:[]=,:clear,:collect!,:compact!,:delete,:delete_at,:delete_if,
      :fill,:flatten!,:insert,:map!,:pop,:push,:reject!,:replace,:reverse!,
      :shift,:slice!,:sort!,:transpose,:uniq!,:unshift]
    end
  end  
  module StringChanged
    def self.object_changed_methods(obj=nil)
      [:<<,:[]=,:capitalize,:chomp!,:chop!,:concat,:delete!,:downcase!,:gsub!,
      :insert,:lstrip!,:next!,:replace,:reverse!,:rstrip!,:slice!,:squeeze!,
      :strip!,:sub!,:succ!,:swapcase!,:tr!,:tr_s!,:upcase!]
    end
  end
  module ObjectChanged
    def self.object_changed_methods(obj)
      obj.instance_variables.map { |s| s.to_s.delete("@")+"=" }
    end
  end
  module ChangedHook
    def self.extended(base)
      override_obj_changed_methods base
    end
    private

    if RUBY_VERSION >= '1.9'
      def self.override_obj_changed_methods(obj)
        eigen_class = self
        obj_class = obj.class.to_s.match("Hash|Array|String") || "Object"
        m = eval "#{obj_class}Changed::object_changed_methods obj"
        m.each do |method|
          eigen_class.send(:define_method, method) { |*args, &block|
            result = super(*args,&block)
            # eval "puts \"__obj_changed_hook #{method}\""
            __obj_changed_hook
            return result
          }
        end
      end
    else
      def self.override_obj_changed_methods(obj)
        eigen_class = self
        obj_class = obj.class.to_s.match("Hash|Array|String") || "Object"
        m = eval "#{obj_class}Changed::object_changed_methods obj"
        m.each do |method|
          eigen_class.send(:define_method, method) {
            result = super
            # eval "puts \"__obj_changed_hook #{method}\""
            __obj_changed_hook
            return result
          }
        end
      end
    end
  end
  module HashMethods
    def self.extended(hash)
      sanitize_hashes_recursive(hash) if hash.instance_eval{@_}[:force_keys]
    end

    def []=(name, *args, &block)
      if @_[:force_keys]
        name = name.to_s   if name.class == Symbol && @_[:key_type] == String
        name = name.to_sym if name.class == String && @_[:key_type] == Symbol
      end
      result = super
      __obj_changed_hook
      return result
    end

    private
    def self.sanitize_hashes_recursive(hash)
      if hash.instance_eval{@_}[:key_type] == String; force_class = Symbol ; conv = "to_s"   ; end
      if hash.instance_eval{@_}[:key_type] == Symbol; force_class = String ; conv = "to_sym" ; end
      
      hash.each do |k,v|
        v = hash.instance_eval{extend_obj(v)}
        # if v.class == Hash; sanitize_hashes_recursive(v) ; break; end
        if v.class == Hash; sanitize_hashes_recursive(v) ; end
        target = eval "k.#{conv}"
        if (force_class == k.class) && (! hash.include?(target))
         hash.store(target,v);
        end
        hash.delete(k) if force_class == k.class
      end
    end
  end
  module EigenMethodDefiner # :nodoc:
    private
    def method_missing(name, *args, &block)
      value = nil
      str_full = name.to_s
      str = str_full.match("=$") ? str_full.chop : str_full
      sym = str.to_sym

      s = @_[:key_type] == Symbol ? "sym" : "str"
      eval "define_eigen_method_#{s}(#{s})"

      if str_full.match "=$"
        obj = args.first
        obj = Hash.new if obj.nil?
        value = @_[:deep_clone] ? obj.deep_clone : obj
        eval "self[#{s}] = value"
      else
        eval("value = self[#{s}] = self[#{s}].nil? ? Hash.new : self[#{s}]")
      end

      return extend_obj(value)
    end
    def extend_obj(value)
      yaml_types = [Hash, Array, String, Object]
      yaml_types.each do |yaml_type|
        if value.is_a?(yaml_type)
          value.extend(EigenMethodDefiner)
          parent_opts = @_
          value.instance_eval { @_ = parent_opts }
          root_obj = @_ro
          value.instance_eval { @_ro = root_obj }
          value.extend YamlDoc::ChangedHook if @_[:object_detection]
          value.extend(HashMethods) if value.is_a?(Hash)
          break
        end
      end
      return value
    end

    def __obj_changed_hook
        _write_file if @_[:autosave]
    end

    def _write_file
      if @_[:filename]
        File.open(@_[:filename], 'w') do |output|
          output.puts YAML.dump(@_ro)
        end
      end
    end

    def define_eigen_method_sym(sym)
      eigen_class = class << self; self; end
      eigen_class.send(:define_method, sym) { self[sym] }
      eigen_class.send(:define_method, (sym.to_s+'=').to_sym) { |val| self[sym] = val }
    end
    def define_eigen_method_str(str)
      eigen_class = class << self; self; end
      eigen_class.send(:define_method, str.to_sym) { self[str] }
      eigen_class.send(:define_method, (str+'=').to_sym) { |val| self[str] = val }
    end
  end

  include EigenMethodDefiner
end

class AutoYamlDoc < YamlDoc
    self.force_keys = true
    self.object_detection = true
    self.autosave = true  
end



