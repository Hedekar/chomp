class Nutrition
  
  @@api_key = "uBPsjBf2zJAeyEzXZm2ZCGPflTdRAV17zXW1soUf"
  
  def self.get_detail ndbno
    api_response = HTTParty.get "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=b&format=json&api_key=#{@@api_key}"
    JSON.parse(api_response.body)
  end
  
  def self.search keyword, page_number
    
    page_number = (page_number < 1) ? 1 : page_number
    num_items = 25
    offset = (page_number - 1) * num_items
    api_response = HTTParty.get "http://api.nal.usda.gov/ndb/search/?format=json&q=#{CGI.escape keyword}&sort=n&max=#{num_items}&offset=#{offset}&api_key=#{@@api_key}"
    data = JSON.parse(api_response.body)
    
    is_error = data["errors"] != nil
    
    # get total page
    total_pages = 0
    if !is_error
      t = data["list"]["total"].to_f
      s = data["list"]["start"].to_f
      e = data["list"]["end"].to_f
      total_pages = (t / (e - s)).ceil
    end
    
    # calculate minimum page for current data
    leftover = 0
    if page_number + 7 > total_pages
      leftover = page_number + 7 - total_pages
    end
    min = page_number - ( 7 + leftover )
    if min < 1
      min = 1
    end
    
    # calculate maximum page for current data
    leftover = 0
    if page_number - 7 < 1
      leftover = 1 - ( page_number - 7 )
    end
    max = page_number + 7 + leftover
    if max > total_pages
      max = total_pages
    end
    
    #merge data
    data.merge({ 'min_page' => min, 'max_page' => max, 'current_page' => page_number, 'total_pages' => total_pages })
  end
  
end