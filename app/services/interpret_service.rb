class InterpretService
  def self.call action, params
    case action
    when "list", "search", "search_by_hashtag"
      FaqModule::ListService.new(params, action).call()
    when "create"
      FaqModule::CreateService.new(params).call()
    when "remove"
      FaqModule::RemoveService.new(params).call()
    when "help"
      HelpService.call()
    when "test_link_list", "test_link_search", "test_link_search_by_hashtag"
      TestLinkModule::ListService.new(params, action).call()
    when "test_link_create"
      TestLinkModule::CreateService.new(params).call()
    when "test_link_remove"
      TestLinkModule::RemoveService.new(params).call()      
    else
      "Não compreendi o seu desejo"
    end
  end
end
