module Mirrored
  class Tag < Base
    attr_accessor :count, :name
    
    class << self
      def new_from_xml(xml) #:nodoc:
        t       = Tag.new
        t.count = (xml)['count']
        t.name  = (xml)['tag']
        t
      end
      
      # Does all the hard work finding your tags and how much you've used them.
      #
      # Usage:
      #   Mirrored::Tag.find(:get)
      def find(*args)
        raise ArgumentError, "Only takes a symbol as the argument (:get, :all)" unless args.first.kind_of?(Symbol)
        doc = Hpricot::XML(connection.get('tags/get'))
        (doc/:tag).inject([]) { |elements, el| elements << Tag.new_from_xml(el); elements }
      end
      
      # Renames a tag from the old name to a new one.
      #
      # Usage:
      #   Mirrored::Tag.rename('microsoft', 'suckfest')
      def rename(old, new)
        doc    = Hpricot::XML(connection.get('tags/rename'))
        result = (doc).at(:result)
        (result && result.inner_html == 'done') ? true : false
      end
    end
  end
end