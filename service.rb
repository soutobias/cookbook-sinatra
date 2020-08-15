require "open-uri"
require "nokogiri"

class ScrapeBbcGoodFoodService # or ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)

    name = []
    doc.search('[class="teaser-item__title"]').each_with_index do |element, index|
      break if index >= 5

      name << element.text.strip
    end

    description = []
    doc.search('.teaser-item__title a').each_with_index do |element, index|
      break if index >= 5
      description << call_description(element['href'])
    end

    prep_time = []
    doc.search('[class="teaser-item__info-item teaser-item__info-item--total-time"]').each_with_index do |element, index|
      break if index >= 5
      value = element.text.strip
      prep_time0 = 0
      if value.match("hour")
        value1 = value.split("hour")
        prep_time0 += value1[0].strip.to_i * 60
      end
      if value.match("min")
        value1 = value.split(/min/)
        prep_time0 += value1[0].strip[-2..].to_i
      end
      prep_time << prep_time0
    end

    difficulty = []
    doc.search('[class="teaser-item__info-item teaser-item__info-item--skill-level"]').each_with_index do |element, index|
      break if index >= 5

      difficulty << element.text.strip
    end

    return [name, description, prep_time, difficulty]
  end

  def call_description(local)
    url = "https://www.bbcgoodfood.com#{local}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    doc.search('[class="field-item even"]').text.strip
  end
end
