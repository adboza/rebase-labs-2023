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
**Acesse a pasta** <br>
`cd rebase-labs-2023`<br>
**Instale as imagens do Docker com o comando:** <br>
`docker compose up` <br>
**Popule o banco de dados com o comando:** <br>
`make seed-db` <br>
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
- [x] Botão importar dados no front-end


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

### GET /exams/count
<p>Endpoint criado para resolver a tarefa de exibição amigável de informações. </p>
<p>Com o valor total dos dados retornados pelo banco de dados, gera 1 botão que agrupa dados de 100 em 100 ocorrências.</p>
Script que realiza a iteração está no arquivo `public/index.html`  .

### GET /tests_list/limit/*/offset/
Endpoint utilizado em conjunto com `GET /exams/count` para exibição amigável de informações.

### GET /tests/:token
Endpoint para exibir informações de exames agrupadas por token.

### GET '/' : Index

Principais funções da página estão na navbar:

![image](https://user-images.githubusercontent.com/99356646/211236752-53fc6bd6-a248-4dcc-9db7-b1f3509d3b25.png)

#### Botão "Exibe todo DB"
Por meio dos endpoints `GET /tests/count` e `GET /tests_list/limit/*/offset/` exibe as 100 primeiras ocorrências e uma lista de botões para a exibição do restante das entradas.

![image](https://user-images.githubusercontent.com/99356646/211236866-60c6148c-f95e-469c-afc7-e0e79498d9c1.png)


#### Buscar token exame
Aproveitando o endpoint `GET /tests/token` exibe de forma amigável os resultados dos exames de determinado token.
![image](https://user-images.githubusercontent.com/99356646/211236675-7c0941fb-e712-442a-a0da-2dab43948d41.png)

#### Botão "Importar resultados"
Implementado um formulário para fazer o `post /import` de arquivos na página inicial.

## Futuro do projeto
- [ ]  Criar restrição de entradas únicas de dados para token de exames;
- [ ]  Melhorar respostas ao usuário em caso de erros do banco de dados;
- [ ]  Criar ambiente de testes no Postgres com integração temporária ao banco de dados;
- [ ]  Melhorar o banco de dados com a criação de 4 tabelas: USERS, DOCTORS, RESULTS, EXAM_TYPES;
- [ ]  Gerar container docker que possibilite testes front-end.
