namespace :db do
  namespace :xml_fixtures do
    desc "Dump db data to the test/fixtures/ directory as table_name.xml. Use MODEL=ModelName and LIMIT (optional)"
    task :dump => :environment do
      XmlFixture::model_or_raise.constantize.dump_to_xml_file
    end
  end
  namespace :has_many_xml_fixtures do
    desc "Dump db data to the test/fixtures/ directory as table_name.xml and also specified has_many_table_names.xml."
    desc "Use MODEL=ModelName, OFFSET (optional), HAS_MANY = ModelName and LIMIT (optional)"
    task :dump => :environment do
      XmlFixture::has_many_model_or_raise.constantize.dump_to_xml_file(ENV['HAS_MANY'],ENV['LIMIT'])
    end
  end
end
