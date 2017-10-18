require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)

    @link = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it "Without hashtag params, will receive a error" do
      @createService = LinkModule::CreateService.new({"link-original" => @link})

      response = @createService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      @createService = LinkModule::CreateService.new({"link-original" => @link, "hashtags-original" => @hashtags})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find link in database" do
      @createService = LinkModule::CreateService.new({"link-original" => @link, "hashtags-original" => @hashtags})

      response = @createService.call()
      expect(Link.last.link).to match(@link)
    end

    it "With valid params, hashtags are created" do
      @createService = LinkModule::CreateService.new({"link-original" => @link, "hashtags-original" => @hashtags})

      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
