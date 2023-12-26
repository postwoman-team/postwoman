<p align="center">
  <img src="https://github.com/postwoman-team/postwoman/assets/66630725/a01dcbf1-9974-48af-9734-2d8d9a5ce695" width="50%" height="50%">
</p>

<h2>
  Postwoman
  <br>
  <a href="README-EN.md">
    <img src="https://img.shields.io/badge/English-blue">
  </a>
</h2>

<p align="justify">
Postwoman é uma gem do Ruby criada para realizar chamadas de API. Ela é parecida com outra ferramenta famosa, mas com uma mudança de foco.
</p>

<p align="justify">
Em outras aplicações, principalmente aquelas que usam interface gráfica, é comum perceber que é mais fácil "bagunçar" os parâmetros de uma requisição para fazer um teste rápido do que automatizá-los com variáveis especiais ou coisas do tipo. No Postwoman, temos um design opinado, que faz com que seja mais fácil para um usuário alterar um paramêtro para um teste rápido sem que a alteração seja definitiva do que fazer o contrário.
</p>

<p align="justify">
Além disso, o Postwoman propõe que o usuário crie suas requisições e scripts em Ruby, tendo toda a flexibilidade e facilidade que essa linguagem oferece.
</p>

**Esta ferramenta ainda está em uma fase muito inicial de desenvolvimento, e bugs são frequentes.**

### Como instalar
Por enquanto, a gem não foi publicada na RubyGems, então é necessário instalar ela manualmente:

- Clone o repositório
- Deixe seu terminal no diretório do projeto
- Instale [Ruby](https://www.ruby-lang.org/en/documentation/installation/) e Bundler (que já vem instalado com o Ruby!) na sua máquina
- Rode no terminal o comando:

```bash
$ make install
```

### Como usar
Para começar a usar o Postwoman, você pode usar o modo sandbox com o comando:

```bash
$ postwoman
```

No entanto, é possível criar uma package. Para isso, utilize o comando:

```bash
$ postwoman -n diretorio_da_package
```

Caso você já tenha uma package, utilize o comando:
```bash
$ postwoman diretorio_da_package
```
para interagir com ela.

Digite `help` para mais informações.

