class Link < ActiveRecord::Base
	ALPHANUMERIC = ('a'..'z').to_a.join + ('A'..'Z').to_a.join + (0..9).to_a.join

	validates :url, uniqueness: true

	before_validation do
		self.url = Link.add_http_to url
	end

	before_create do
		self.visited = 0;
	end

	def self.order_URL_by_visited_times
		Link.order(visited: :desc)
	end

	def self.order_URL_by_last_visit_date
		Link.order(last_visit: :desc).limit(10)
	end

	def self.visit_URL_of short_url
		short_link = Link.where(shortlink: short_url).first
		Link.visit_link short_link
		short_link.url
	end

	def self.visit_link link
		link.last_visit = Time.current
		link.visited += 1
		link.save
	end

	def self.short_link 
		shorten = random_short 3
		until (Link.where(shortlink: shorten).empty?)
			shorten = random_short 3
		end
		shorten
	end

	def self.random_short length
		shorten_link = ""
		length.times do
			shorten_link += ALPHANUMERIC[Random.rand(ALPHANUMERIC.length)]
		end
		shorten_link
	end

	def Link.add_http_to url
		( url.include? "http://" ) ? url : "http://" + url
	end
end
