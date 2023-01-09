# Rebase Labs

An application to manage laboratory exams. 
This project is in Portuguese [pt-br] and is part of Rebase Labs course, sponsored by [Rebase](https://rebase.com.br/) and [Campus Code](https://www.campuscode.com.br/).
Current progress available at: [Trello - Rebase Labs Card](https://trello.com/c/2IUQpLu4/42-rebase-labs)

Uma app web para listagem de exames médicos.
Este projeto é parte do curso Rebase Labs, patrocinado por [Rebase](https://rebase.com.br/) e [Campus Code](https://www.campuscode.com.br/).
Acompanhamento do progresso disponível em: [Trello - Rebase Labs Card](https://trello.com/c/2IUQpLu4/42-rebase-labs)

## Rodando a aplicação

**Clone o repositório** <br>
`git clone git@github.com:adboza/rebase-labs-2023.git`<br>
**Instale as imagens do Docker com o comando:** <br>
`docker compose up` <br>
**Acesse a aplicação em:** <br>
<p>http://localhost:3000</p>

**Os testes podem ser verificados em outro bash com o comando:** <br>
`make this-rspec` <br>

## Realizado
- [x] Endpoint `/tests` com leitura diretamente de DB SQL;
- [x] Configurações para popular dados com script `make seed-db `;
- [x] Exibição dos dados com front-end amigável acessando <http://localhost:3000> ;
- [x] Carregamento de exames da API com JS (arquivos de suporte na pasta public Sinatra);
- [x] Endpoint `/tests/:token` ;
- [x] Endpoint  `/tests_list/limit/*/offset/` ;
- [x] Endpoint `POST /import`  pode ser usado para importar os dados do CSV de forma assíncrona;
- [x] Busca e exibição de dados de resultados amigável a partir de token;
- [ ] Botão importar dados no front-end


## Endpoints e front-end explicados

### POST /import
Os testes foram realizados com a extensão RESTer para Firefox utilizando dados de solicitação conforme abaixo:

- Body
Name: `results`
Filename: `new_data.csv`
Method: `POST`
URL: `http://localhost:3000/import`
- Headers
Name: `Content-Type`
Value: `multipart/form-data`

No diretório de arquivos do projeto, descrito em `app.rb`
```ruby
post '/import' do
  csv = params[:results][:tempfile]
  json_file = DbMethods.new.csv_iteration(csv)
  MyJob.perform_async(json_file)
end
```

### GET /tests
Exibe banco de dados, para não travar a aplicação e manter o exemplo solicitado neste momento exibe apenas os 100 primeiros resultados.

### GET /exams					/count
<p>Endpoint criado para resolver a tarefa de exibição amigável de informações. </p>
<p>Com o valor total dos dados retornados pelo banco de dados, gera 1 botão que agrupa dados de 100 em 100 ocorrências.</p>
Script que realiza a iteração está no arquivo `public/index.html`  .

### GET /tests_list/limit/*/offset/
Endpoint utilizado em conjunto com `GET /exams/count` para exibição amigável de informações.

### GET /tests/:token
Endpoint para exibir informações de exames agrupadas por token.

### GET '/' : Index

Principais funções da página estão na navbar:

![e239f1987aee0ed7fb0148a018f6b6ac.png](:/d4d3d5d602da4d97b3035d59331af77f)

#### Botão "Exibe todo DB"
Por meio dos endpoints `GET /tests/count` e `GET /tests_list/limit/*/offset/` exibe as 100 primeiras ocorrências e uma lista de botões para a exibição do restante das entradas.
![a7974d7af03f99c100e55c4cb31cfd00.png](:/170f22ce74a4482b848c748a39e0056d)

#### Buscar token exame
Aproveitando o endpoint `GET /tests/token` exibe de forma amigável os resultados dos exames de determinado token.
![d3b7223723c4f625a2940c4309ae408e.png](:/c9023f9d3b384d4eb25d026b4fb56789)


## Futuro do projeto
- [ ]  Criar restrição de entradas únicas de dados para token de exames;
- [ ]  Melhorar respostas ao usuário em caso de erros do banco de dados;
- [ ]  Criar ambiente de testes no Postgres com integração temporária ao banco de dados;
- [ ]  Melhorar o banco de dados com a criação de 4 tabelas: USERS, DOCTORS, RESULTS, EXAM_TYPES.
- [ ]  Gerar container docker que possibilite testes front-end.
