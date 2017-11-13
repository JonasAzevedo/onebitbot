class HelpService
  def self.call
    response  = "*O que eu sei fazer* \n\n"
    response += ">Lista de comandos que eu conheço\n\n"
    response += "*FAQ's*\n"
    response += "-> Adicione ao faq\n\n"
    response += "-> Me mostre o faq\n\n"
    response += "-> Encontre a faq x\n\n"
    response += "-> Pesquise a hashtag x\n\n"
    response += "-> Remova do faq x\n\n"
    response += "*LINK's*\n\n"
    response += "-> Novo link\n\n"
    response += "-> Me mostre os links\n\n"
    response += "-> Conhece o link x\n\n"
    response += "-> hashtag link x\n\n"
    response += "-> remova link x\n\n"
    response
  end
end
