class ConfigurationNamesController < ApplicationController

	def new
		@config_name = ConfigurationName.new		
	end

	def create
		@config_name = ConfigurationName.new(params[:config_name].permit(:name))
		@config_name.save
	end

end
