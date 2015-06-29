require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}


class ShortenedUrl < ActiveRecord::Base
	validates_uniqueness_of :url
	validates_presence_of :url
	validates_format_of :url, :with => /^\b((?:https?:\/\/)(?:[^\s()<>]+|(([^\s()<>]+|(([^\s()<>]+)))))+(?:(([^\s()<>]+|(([^\s()<>]+))))|[^\s`!()[]{};:'".,<>?«»“”‘’]))$/ 
end

get '/' do
	
end

post '/' do
end

get '/:shortened' do
	short_url = ShortenedUrl.find(params[:shortened])
	redirect short_url.url
end
