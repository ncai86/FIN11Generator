namespace :populate do
  desc "TODO"
  task :config_field => :environment do
  	FIELDS.each do |f|
  		puts f
  		ConfigurationField.create({name: f, state: 'Mandatory'})
  	end

  end

end
