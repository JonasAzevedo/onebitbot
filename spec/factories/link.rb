FactoryGirl.define do
  factory :link do
    #link FFaker::Internet.uri
    #todo arrumar
#Faker::Internet.http_url
    #link FFaker::Lorem.phrase
    link "google.com"
    #xxxxxxxxxxxx sem ponto vai
    #sabe que a faq está relacionada a company, cria uma factory company e associa ao link
    company
  end
end
