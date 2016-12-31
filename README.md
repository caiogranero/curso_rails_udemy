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

* Passando a variável do Controller para a Partials.

1. Crie uma variável no Controller correspondente a view que está sendo chamado a partials.

	```
	@variavel_no_controller = "controller1"
	```

2. Vá até a Partials e digite

	```
	<%= @variavel_no_controller %>
	```

* Passando a variável da View para a Partials.

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