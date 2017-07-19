FactoryGirl.define do
  factory :faq do
    question FFaker::Lorem.phrase
    answer FFaker::Lorem.phrase
    #sabe que a faq está relacionada a company, cria uma factory company e associa a faq
    company
  end
end
