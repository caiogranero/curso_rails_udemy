# Diário de Aprendizado

[1. Partials](#partials).

[2. Pasta assets](#pasta-assets).

[3. Rails Console & Active Record](#rails-console--active-record)

[4. Populando o banco de dados (db/seeds)](#populando-o-banco-de-dados-dbseeds)

# Partials

É muito comum precisarmos usar o mesmo trecho de código em diversos locais diferentes do nosso projeto. Porém, ficar repetindo esses trechos em todos os locais não é a melhor maneira de se fazer isso. Em rails é possivel simplificar esse processo utilizando as partials.

## Chamando uma partials dentro de um arquivo principal.

1. Crie um arquivo com o nome _nome_do_arquivo.html.erb, por exemplo: _footer.html.erb

	```
	<footer>
		<h2> Aqui está o rodapé da página </h2>
	</footer>
	```

2. Caso você tenha criado a partial na mesma pasta que a index, coloque: 

	```
	<%= render partial: "footer" %>
	```

3. Caso você tenha criado a partial em uma pasta diferente da index, coloque:

	```
	<%= render partial: "/contacts/shared/footer" %>
	```

> Note que não é necessário colocar `_footer` e sim apenas `footer`, pois o Rails sabe que se trata de uma partial.

## Passando variáveis para uma partials

###### Passando a variável do Controller para a Partials.

1. Crie uma variável no Controller correspondente a view que está sendo chamado a partials.

	```
	@variavel_no_controller = "controller1"
	```

2. Vá até a Partials e digite

	```
	<%= @variavel_no_controller %>
	```

###### Passando a variável da View para a Partials.

1. Crie uma variável na View.
 
	```
	<% variavel_na_view = "View1" %>
	```

2. Na inicialização da Partials na view, é necessário declarar as variáveis que você deseja passar:

	```
	<%= render partial: "/contacts/shared/footer", locals: { variavel_na_partial: variavel_na_view } %>
	```

3. E por último, na Partials, chame a variável

	```
	<%= variavel_na_partial %>
	```

# Pasta assets

Em qualquer projeto web utilizamos arquivos complementares ao HTML, como por exemplo os CSS e os JavaScripts. O rails tem um diretório específico para manipular esses arquivos, assim como as imagens.

> Arquivos CSS: `app/assets/stylesheets`

> Arquivos JS: `app/assets/javascripts`

> Arquivos de Imagem (JPG, PNG): `app/assets/images`

# Rails Console & Active Record

Rails Console é um console do Rails que possibilita as ações de CRUD no banco de dados através do Active Record.

## Acessando o Console

Com o terminal aberto, digite `rails c` que irá entrar no console

###### Create

```
<Model>.create(description: "Nova descrição")
```

###### Read

```
<Model>.all
```

```
<Model>.first
```

```
<Model>.where(description: "Nova descrição")
```

```
<Model>.last
```

###### Update

```
x = <Model>.find(1)
x.description = "NOVA DESCRIÇÃO"
```

```
<Model>.find(1)
<Model>.update(description: "Descrição Atualizada")
```

###### Delete

```
x = <Model>.find(1)
x.destroy
```

# Populando o banco de dados (db/seeds)

Na fase de desenvolvimento de um projeto, é muito comum precisarmos ter um banco de dados com uma quantidade x de registros pré cadastrados para usarmos como teste. O Rails possibilita que isso seja feito de uma forma muito prática e escalável.

1. Acesse o arquivo `db/seeds.rb`

	Dentro do arquivo seeds, é possível colocarmos comandos de Active Record, juntamente com Ruby, para popular o banco. Abaixo alguns comandos simples

2. Gerando n registros.

	```
	puts "Gerando os registros de Kind"
	Kind.create(
				[{
					description: "Amigo"
				}, 
				{
					description: "Contato"
				}, 
				{
					description: "Comercial"
				}])
	puts "Gerando os registros de Kind... [OK]"
	```

	A abordagem acima é manual de mais. Suponha que você precise de 100 cadastros em uma tabela com dados ficticios, você não precisa fazer 100x Ctrl + C / Ctrl + V. Para isso, instale a [gem faker](https://github.com/stympy/faker) ela permite que você gere os mais diversos dados de forma aleatória e consistente. Leiam sua documentação, é muito simples de usar.

	Abaixo iremos gerar dados sobre 100 contatos de forma automatica.

	```
	puts "Gerando os registros de Contacts"
	100.times do |i|
		Contact.create(
					[{
						name: Faker::Name.name,
						email: Faker::Internet.email,
						city: Faker::Address.city,
						rmk: Faker::Lorem.sentence(3)
					}])
	end
	puts "Gerando os registros de Contacts... [OK]"
	```

	Caso você precise inserir uma chave estrangeira nessa geração automatica, basta utilizar o seguinte comando: `<Model>.all.sample`. Este comando irá pegar uma amostra de 1 valor da Tabela <Model>.	

	Após digitar os comandos acima, vá até o terminal e digite: `rails db:seed`. Ele irá imprimir os valores inseridos no puts e criará os registros.

# has_only e belongs_to

Durante a modelagem do nosso banco de dados, definimos alguns tipos de relacionamento, sendo esses n:n, n:1 ou 1:1. No Active Record, isso é definido através das declarações `has_only` e `belongs_to`

###### Exemplo

Dado que temos a tabela Contato e Endereço
1 Contato pode ter apenas 1 endereço e 1 endereço corresponde a 1 contato, logo o relacionamento é 1:1
A tabela Endereço terá a FK de Contato.

* O arquivo app/models/contact.rb deverá ter ```has_one :address```
* O arquivo app/models/address.rb deverá ter ```belongs_to contact```

Através do belongs_to, é possível consultar diretamente dados da segunda tabela, por exemplo: `Contact.address.street` irá retornar o valor da rua do contato selecionado.

# Inserindo em um Model, atributos de outro

Ao decorrer do aumento da complexidade dos nossos projetos, é bem comum precisarmos fazer formulários de cadastros aonde será inserido o conteúdo em mais de uma tabela. A declaração `accepts_nested_attributes_for` permite isso`. Através desse atributo, conseguimos alterar os parâmetros enviados para o commit dos novos valores.

######Exemplo no terminal (Continuação do exemplo a cima)

O arquivo contact, contém o has_one :address, isso significa que a FK de Contato está em Endereço, por tanto podemos querer fazer um cadastro de Contato juntamente com um endereço especifico.  

Primeiramente colocamos: `accepts_nested_attributes_for :address` logo abaixo do `has_one :address`, depois no terminal, podemos fazer a declaraçã do params da seguinte forma:

```params = {contact: {name: "Caio", address_attributes: {street: "Rua de Guarulhos"}}}```

Após feito isso, foi criado um registro de contato e um registro de endereço