require_relative './../../spec_helper.rb'

#descrição do que se pretende testar
describe FaqModule::CreateService do
  #roda antes de cada it
  before do
    @company = create(:company)

    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  #testa o método call...
  describe '#call' do
    #sem o parâmetro hashtar recebe um erro
    it "Without hashtag params, will receive a error" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer})

      response = @createService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    #com parâmetros válidos, recebe mensagem de sucesso
    it "With valid params, receive success message" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find question and anwser in database" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(Faq.last.question).to eq(@question)
      expect(Faq.last.answer).to eq(@answer)
    end

    #com parâmetros válidos, as hashtags são criadas
    it "With valid params, hashtags are created" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
