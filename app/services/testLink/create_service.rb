module TestLinkModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @link = params["link-original"]
      @hashtags = params["hashtags-original"]
    end


    def call
      if @hashtags == nil || @hashtags == ""
        return "Hashtag Obrigatória..."
      end

      begin
        Link.transaction do
          link = Link.create(link: @link, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            link.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Link criado com sucesso"
      rescue
        "Problemas na criação do link"
      end
    end
  end
end
