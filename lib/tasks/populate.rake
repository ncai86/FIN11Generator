namespace :populate do
  desc "TODO"
  task :kor_config_field => :environment do
  	ConfigurationName.create name: "KOR"
  	kor = ConfigurationName.where(name: "KOR").first
  	
  	FIELDS.each do |k,v|
  		puts k
  		puts v 
  		kor.configuration_fields.create({name: k, state: v})
  	end

  end

end
