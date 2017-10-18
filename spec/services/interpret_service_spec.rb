require_relative './../spec_helper.rb'

describe InterpretService do
  before :each do
    @company = create(:company)
  end

  describe '#list' do
    it "With zero faqs, return don't find message" do
      response = InterpretService.call('list', {})
      expect(response).to match("Nada encontrado")
    end

    it "With two faqs, find questions and answer in response" do
      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = InterpretService.call('list', {})

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end
  end

  describe '#search' do
    it "With empty query, return don't find message" do
      response = InterpretService.call('search', {"query": ''})
      expect(response).to match("Nada encontrado")
    end

    it "With valid query, find question and answer in response" do
      faq = create(:faq, company: @company)

      response = InterpretService.call('search', {"query" => faq.question.split(" ").sample})

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end

  describe '#search by category' do
    it "With invalid hashtag, return don't find message" do
      response = InterpretService.call('search_by_hashtag', {"query": ''})
      expect(response).to match("Nada encontrado")
    end

    it "With valid hashtag, find question and answer in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      response = InterpretService.call('search_by_hashtag', {"query" => hashtag.name})

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end

  describe '#create' do
    before do
      @question = FFaker::Lorem.sentence
      @answer = FFaker::Lorem.sentence
      @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    end

    it "Without hashtag params, receive a error" do
      response = InterpretService.call('create', {"question-original" => @question, "answer-original" => @answer})
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      response = InterpretService.call('create', {"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags})
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find question and anwser in database" do
      response = InterpretService.call('create', {"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags})
      expect(Faq.last.question).to match(@question)
      expect(Faq.last.answer).to match(@answer)
    end

    it "With valid params, hashtags are created" do
      response = InterpretService.call('create', {"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags})
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end

  describe '#remove' do
    it "With valid ID, remove Faq" do
      faq = create(:faq, company: @company)
      response = InterpretService.call('remove', {"id" => faq.id})
      expect(response).to match("Deletado com sucesso")
    end

    it "With invalid ID, receive error message" do
      response = InterpretService.call('remove', {"id" => rand(1..9999)})
      expect(response).to match("Questão inválida, verifique o Id")
    end
  end

  describe '#link_list' do
    it "With zero links, return don't find message" do
      response = InterpretService.call('link_list', {})
      expect(response).to match("Nada encontrado")
    end

    it "With two links, find links in response" do
      link1 = create(:link, company: @company)
      link2 = create(:link, company: @company)

      response = InterpretService.call('link_list', {})

      expect(response).to match(link1.link)
      expect(response).to match(link2.link)
    end
  end

  describe '#link_search' do
    it "With zero links, return don't find message" do
      response = InterpretService.call('link_search', {})
      expect(response).to match("Nada encontrado")
    end

    it "With two links, find links in response" do
      link1 = create(:link, company: @company)

      response = InterpretService.call('link_search', {'query' => link1.link.split(" ").sample})

      expect(response).to match(link1.link)
    end
  end

  describe '#link_search_by_hashtag' do
    it "With zero links, return don't find message" do
      response = InterpretService.call('link_search_by_hashtag', {})
      expect(response).to match("Nada encontrado")
    end

    it "With one hashtag, find links in response" do
      link = create(:link, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:link_hashtag, link: link, hashtag: hashtag)

      response = InterpretService.call('link_search_by_hashtag', {'query' => hashtag.name})

      expect(response).to match(link.link)
    end
  end

  describe '#link_create' do
    before do
      @link = FFaker::Lorem.sentence
      @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    end

    it "Without hashtag params, receive a error" do
      response = InterpretService.call('link_create', {"link-original" => @link})
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      response = InterpretService.call('link_create', {"link-original" => @link, "hashtags-original" => @hashtags})
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find link in database" do
      response = InterpretService.call('link_create', {"link-original" => @link, "hashtags-original" => @hashtags})
      expect(Link.last.link).to match(@link)
    end

    it "With valid params, hashtags are created" do
      response = InterpretService.call('link_create', {"link-original" => @link, "hashtags-original" => @hashtags})
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end

  describe '#link_remove' do
    it "With valid ID, remove Link" do
      link = create(:link, company: @company)
      response = InterpretService.call('link_remove', {"id" => link.id})
      expect(response).to match("Link deletado com sucesso")
    end

    it "With invalid ID, receive error message" do
      response = InterpretService.call('link_remove', {"id" => rand(1..9999)})
      expect(response).to match("Link inválido, verifique o Id")
    end
  end

  describe '#invalid action' do
    it "With invalid action, receive message" do
      #response = InterpretService.call(FFaker::Lorem.word, {})
      response = InterpretService.call('test', {})
      expect(response).to match("Não compreendi o seu desejo")
    end
  end

end
