module TestLinkModule
  class ListService 
    def initialize(params, action)
      # TODO: identify origin and set company
      @company = Company.last
      @action = action
      @query = params["query"]
    end

    def call
      if @action == "test_link_search"
        links = Link.search(@query).where(company: @company)
      elsif @action == "test_link_search_by_hashtag"
        links = []
        @company.links.each do |link|
          link.hashtags.each do |hashtag|
            links << link if hashtag.name == @query
          end
        end
      elsif @action == "test_link_list"
        links = @company.links
      else
        links = nil
      end

      response = "*Link's* \n\n"
      links.each do |link|
        response += "*#{link.id}* - "
        response += "*#{link.link}*\n"
        link.hashtags.each do |h|
          response += "_##{link.name}_ "
        end
        response += "\n\n"
      end
      (links.count > 0)? response : "Nenhum link encontrado"
    end
  end
end
