module TestLinkModule
  class ListService
    def initialize(params, action)
      # TODO: identify origin and set company
      @company = Company.last
      @action = action
      @query = params["query"]
    end

    def call
      links = @company.links
      
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
