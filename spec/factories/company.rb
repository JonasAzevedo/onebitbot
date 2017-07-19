FactoryGirl.define do
  factory :company do
    #FFaker = module, Lorem = classe, word = método
    #gera uma palavra aleatória para name
    name FFaker::Lorem.word
  end
end
