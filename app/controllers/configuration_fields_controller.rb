class ConfigurationFieldsController < ApplicationController

	RECORDS = []
	MERCHANT_ID_CHARACTERS = 15

	def index
		# even = []
		# fields = ConfigurationField.display
		# fields.each_index{ |i| (even << fields[i] if i % 2 == 0) }
		# @left_half = even
		# @right_half = fields - @left_half
		gon.hiddenFields = ConfigurationField.disabled_fields.collect{|f| 	f.name.parameterize.gsub("company-s-","company-")}

	end

	def add_record
		session[:records] ||= []

		set_ordered_parameters

		fields = params[:fields]
		logger.info 'test fields'
		logger.info fields

		logger.info 'looping'
		# Initialize 
		record = ""

		# looping ordered list
		# checking if parameters in form is present
		# Storing FIN11 record string
		@order.each do |o|
			logger.info o
			logger.info fields.include?(o)
			
			if fields.include?(o)
				if o == "merchant-id"
					record += "0" * (MERCHANT_ID_CHARACTERS - fields[o.to_s].length) + fields[o.to_s] + ";"
				else
					record += (fields[o.to_s] + ";")
				end
			end
		end

		session[:records] << record
		logger.info 'SESSION RECORDS'
		logger.info session[:records]

		
		# order.each do |ordered_param|
		# 	fields

		# fields.each do |k,v|
		# 	k = k.underscore
		# 	logger.info k
		# 	if k == 'merchant_id'
		# 		k = '0' * (MERCHANT_ID_CHARACTERS - v.length) + v
		# 	else
		# 		k = v
		# 	end
		# 	logger.info " value is #{k}"

		# 	logger.info ""
		# end

		redirect_to root_url
	end

private

	def set_ordered_parameters
		@order = []
		FIELDS.each do |f|
			@order << f.parameterize.gsub("company-s-", "company-")
		end
		logger.info 'Order is '
		logger.info @order
		@order
	end

end
