require 'factory_girl'

# RSpec without Rails
#configurando o RSpec, incluindo module FactoryGirl com Syntax dentro e Methods dentro
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  #configura a definição do FactoryGirl
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
