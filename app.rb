require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}


class ShortenedUrl < ActiveRecord::Base
	validates_uniqueness_of :url
	validates_presence_of :url
  	validates_format_of :url, :with => /^\b((?:https?:\/\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))$/, :multiline => true
end

get '/' do
	haml :index
end

post '/' do
	@short_url = ShortenedUrl.find_or_create_by(:url => params[:url])
	if @short_url.valid?
		haml :success
	else
		haml :index
	end
end

get '/:shortened' do
	short_url = ShortenedUrl.find(params[:shortened])
	redirect short_url.url
end
