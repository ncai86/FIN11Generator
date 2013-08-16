class ConfigurationFieldsController < ApplicationController

	RECORDS = []

	def index
		# even = []
		# fields = ConfigurationField.display
		# fields.each_index{ |i| (even << fields[i] if i % 2 == 0) }
		# @left_half = even
		# @right_half = fields - @left_half
		gon.hiddenFields = ConfigurationField.disabled_fields.collect{|f| 	f.name.parameterize.gsub("company-s-","company-")}

	end

	def add_record
		fields = params[:fields]

		logger.info 'testteesttest'
		logger.info fields

		fields.each do |k,v|
			k.underscore = v
		end

		merchant_id = ""


		redirect_to root_url
	end

private
	def validate_fields
		params
	end


end
