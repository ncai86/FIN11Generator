require 'spec_helper'

describe ConfigurationName do
	it 'should not allow configuration name to be null or empty' do
		@new_name = ConfigurationName.new(name: '')
		expect{@new_name.save!}.to raise_error
	end

	
end