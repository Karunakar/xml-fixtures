# XmlFixtures
module XmlFixture
  MODEL = "MODEL"
  HAS_MANY = "HAS_MANY"
  def self.env_or_raise
    if ENV[MODEL].blank?
      raise RuntimeError,  "No MODEL value given. Set MODEL = ModelName"
    else
      return ENV[MODEL]
    end
  end

  def self.has_many_model_or_raise
    if ENV[HAS_MANY].blank?
      raise RuntimeError,  "No HAS_MANY MODEL value given. Set HAS_MANY = ModelName"
    end
    env_or_raise
  end

  def self.model_or_raise
    return env_or_raise()
  end

  def self.limit_or_nil_string
    ENV['LIMIT'].blank? ? 'nil' : ENV['LIMIT']
  end

  class ActiveRecord::Base
    class << self
      def dump_to_xml_file (has_many = nil,limit = nil, opts = {})
        opts[:limit] = limit if limit
        content = self.find(:all, opts).to_xml
        write_file(File.expand_path("test/fixtures/#{self.table_name}.xml", Rails.root), content)
        if !has_many.blank?
           content = has_many.constantize.find(:all,:limit => opts[:limit]).to_xml# ()
           write_file(File.expand_path("test/fixtures/#{has_many.constantize.table_name}.xml", Rails.root), content)
        end
      end

      def write_file(path, content = nil)
        f = File.new(path, "w+")
        f.puts content
        f.close
      end
    end
  end
end

