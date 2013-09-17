class Acquirer < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :currency_merchant_groups, :dependent => :destroy
  attr_accessible :name, :code

  
  validates :name, :code, presence: true
end
