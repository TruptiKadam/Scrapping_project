class Scrapper

  def initialize(url, search)
    @url = url
    @search = search
    @browser = Watir::Browser.new
  end

  def browse_and_get_data
    @browser.goto(@url)
    @browser.text_field(id: 'ss').set(@search)
    @browser.ul(class: 'c-autocomplete__list').lis.first.click
    @browser.button(class: 'sb-searchbox__button ').click
    @browser.element(id: 'hotellist_inner').wait_until(message: 'Loading result...', &:present?)
  end

  def save_data(hotels)
    if hotels.present? && Hotel.create(hotels)
       puts "Hotels data scrapped and saved successfully."
    else
      puts "Something went wrong."
    end
  end

  def perform
    browse_and_get_data
    hotels = []
    @browser.divs(class: 'sr_item').each do |div|
      name = div.element(class: 'sr-hotel__title').a.span.text
      description = div.element(class: 'hotel_desc').text
      location = div.element(class: 'sr_card_address_line').a.text.remove(' Show on map')
      reviews = div.element(class: 'bui-review-score__text').text.remove(' reviews')
      review_score = div.element(class: 'bui-review-score__badge').text
      hotels << { name: name, description: description, location: location, reviews: reviews, review_score: review_score}
    end
    save_data(hotels)
    @browser.close
  end
end
