#==
# Copyright (C) 2008 James S Urquhart
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#++

class String
	def twist(twister)
	  return self if self.length != twister.length
	  
	  untwist_arr = self.split('')
	  twist_arr = twister.clone()
	  twister.length.times do |ti|
	  	twist_arr[twister[ti]] = untwist_arr[ti]
	  end
	  
      return twist_arr.join()
	end
	
	def untwist(twister)
	  return self if self.length != twister.length
      
      twist_arr = self.split('')
      untwist_arr = twister.clone()
      twister.length.times do |ti|
      	untwist_arr[ti] = twist_arr[twister[ti]]
      end
      
      return untwist_arr.join()
	end
	
	def valid_hash?
		(self =~ /^([a-f0-9]*)$/) != nil
	end
	
	def sanitize_filename
		fname = File.basename(self)
		fname.gsub(/[^\w\.\-]/,'_') 
	end
end

class Symbol # :nodoc:
  # Localizes the symbol into the current locale. 
  # If there is no translation available, the replacement string will be returned
  def localize(replacement_string = '__localization_missing__', args={})
    I18n.translate(self, {:default => "#{replacement_string}(#{self})"}.merge(args))
  end
  alias :l :localize
  
  def l_in(locale, args={})
    I18n.translate(self, {:locale => locale, :default => "_localization_missing_(#{self})"}.merge(args)) unless locale.nil?
  end
  
  # Note that this method takes the replacement string after the args hash unlike other Globalite methods
  def localize_with_args(args={}, replacement_string = '__localization_missing__')    
    I18n.translate(self, {:default => "#{replacement_string}(#{self})"}.merge(args))
  end
  alias :l_with_args :localize_with_args
  
end

# Fix stupid form defaults
module ActionView
  module Helpers
    class InstanceTag
      DEFAULT_FIELD_OPTIONS = { }
      DEFAULT_TEXT_AREA_OPTIONS = { }
    end
  end
end
