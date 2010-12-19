class Fixtures < (RUBY_VERSION < '1.9' ? YAML::Omap : Hash)

  def xml_file_path
    "#{@fixture_path}.xml"
  end

  def read_fixture_files
    if File.file?(xml_file_path)
      read_xml_fixture_files
    else
      super
    end
  end

  def read_xml_fixture_files
    reader = IO.read(xml_file_path)
    data = Hash.from_xml(reader)
    data[@table_name.to_s].each_with_index do |data, i|
      self["#{@class_name.to_s.underscore}_#{i += 1}"] = Fixture.new(data, model_class, @connection)
    end
  end

end
