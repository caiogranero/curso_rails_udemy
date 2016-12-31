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

Obs: Note que não é necessário colocar _footer e sim apenas footer, pois o Rails sabe que se trata de uma partial.

