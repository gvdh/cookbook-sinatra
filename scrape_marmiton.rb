require "open-uri"
require "nokogiri"

class ScrapeMarmiton # or ScrapeMarmitonService
  def initialize
    # @keyword = keyword
    @my_array = []
    @my_url_array = []
  end

  def call(keyword)
    @keyword = keyword
    url = 'http://www.marmiton.org/recettes/recherche.aspx?s=' + @keyword
    doc = Nokogiri::HTML(open(url).read)
    doc.search('.m_titre_resultat > a').each do |element|
      @my_array << element.text
      @my_url_array << element.attr('href')
    end
    return @my_array
  end

  def import_selection(selection)
    url = 'http://www.marmiton.org' + @my_url_array[selection]
    doc = Nokogiri::HTML(open(url).read)
    {
      name: doc.search('.main-title').text,
      cooking_time: doc.search('div.recipe-infos > div.recipe-infos__total-time > span.title-2.recipe-infos__total-time__value').text,
      difficulty: doc.search('div.recipe-infos > div.recipe-infos__level > span').text,
      preparation: doc.search('.recipe-preparation__list').text.delete("\r", "").delete("\t", " ").delete("\n", "").squeeze(" "),
      ingredients: doc.search('.recipe-ingredients__list').text.delete("\r", "").delete("\t", " ").delete("\n", "").squeeze(" ")
    }
  end
end
