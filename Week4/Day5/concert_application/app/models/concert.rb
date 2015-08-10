class Concert < ActiveRecord::Base
	has_many :comments
	belongs_to :city
	has_attached_file :poster, styles: {:medium => "300x300>", :thumb => "100x100>"}
	validates_attachment_content_type :poster, :content_type => /\Aimage\/.*\z/
	validates :band, :venue, :city, :date, :price, :description, :poster, presence: true

	def self.later_concerts
		Concert.where("date >= ?", Date.today)
	end

	def self.later_concerts_this_month
		Concert.later_concerts.where("date <= ?",Date.today.end_of_month)
	end

	def self.with_price_lower_than price
		Concert.later_concerts.where("price < ?", price)
	end

	def self.most_commented
		Concert.later_concerts.order("comments_count DESC").limit(10)
	end
end
