FactoryGirl.define do
  factory :link do
    link FFaker::Internet.http_url
    #sabe que o link está relacionado a company, cria uma factory company e associa ao link
    company
  end
end
