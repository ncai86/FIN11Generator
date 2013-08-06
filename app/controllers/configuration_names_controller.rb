class ConfigurationNamesController < ApplicationController

	def new
		@config_name = ConfigurationName.new		
	end

	def create
		@config_name = ConfigurationName(params[:config_name].permit(:name))
	end

end
