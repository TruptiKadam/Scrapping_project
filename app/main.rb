require 'watir'
require 'active_record'
require_relative './scrapper'
require_relative './models/hotel'
require_relative '../db/db_connection'

url = "https://www.booking.com"
search = 'delhi'
@scrapper = Scrapper.new(url, search)
@scrapper.perform
