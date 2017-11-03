require_relative './../../spec_helper.rb'

describe LinkModule::ListService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "with list command: With zero links, return don't find message" do
      @listService = LinkModule::ListService.new({}, 'link_list')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with list command: With two links, find link in response" do
      @listService = LinkModule::ListService.new({}, 'link_list')

      link1 = create(:link, company: @company)
      link2 = create(:link, company: @company)

      response = @listService.call()

      expect(response).to match(link1.link)
      expect(response).to match(link2.link)
    end

    it "with search command: With empty query, return don't find message" do
      @listService = LinkModule::ListService.new({'query' => ''}, 'link_search')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search command: With valid query, find link in response" do
      link = create(:link, company: @company)

      @listService = LinkModule::ListService.new({'query' => link.link.split(" ").sample}, 'link_search')

      response = @listService.call()

      expect(response).to match(link.link)
    end

    it "with search command: With valid query, find link create in response" do
      link = create(:link, company: @company)

      @link = "google"
      @listService = LinkModule::ListService.new({'query' => @link}, 'link_search')
      puts link.link
      ## xxxxxxxxxxxxxxxxxxxxxxxxxx

      response = @listService.call()

      expect(response).to match(link.link)
    end

    it "with search_by_hashtag command: With invalid hashtag, return don't find message" do
      @listService = LinkModule::ListService.new({'query' => ''}, 'link_search_by_hashtag')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search_by_hashtag command: With valid hashtag, find link in response" do
      link = create(:link, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:link_hashtag, link: link, hashtag: hashtag)

      @listService = LinkModule::ListService.new({'query' => hashtag.name}, 'link_search_by_hashtag')

      response = @listService.call()

      expect(response).to match(link.link)
    end
  end
end
