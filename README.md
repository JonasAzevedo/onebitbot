![ruby](https://img.shields.io/badge/Ruby-2.3.1-red.svg)
![docker](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)
**Sinatra**


# Sobre

O OneBitBot é um webhook de chatbot podendo ser adaptado para as mais diversas aplicações.


# Instalação

* Instale o [Docker](https://docs.docker.com/engine/installation/)
* Clone este repositório
* No diretório que clonou o repositório execute:
  * docker-compose build
  * docker-compose run --rm website rake db:reset db:create db:migrate
* Suba o app
  * docker-compose up --build

* Crie um endpoint do seu app. Para isso instale o [ngrok](https://ngrok.com)
* No diretório que instalou o ngrok execute:
  * ./ngrok http 9292
* Copie o link gerado pelo ngrok

* Conecte o chatbot a uma ferramenta de compreensão de linguagem natural (integrar aplicativos com o chatbot)
* Utilizei o dialogflow: https://dialogflow.com
  * O link gerado pelo ngrok, deve ser inserido na opção fulfillment -> webook, sendo acrescido a URN webhook. 
    Exemplo: http://2327c363.ngrok.io/webhook
  * O dialogflow permite a integração com vários aplicativos, exemplos: slack, facebook, twitter, etc.
