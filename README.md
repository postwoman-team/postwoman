## Postwoman

Postwoman é uma gem do Ruby criada para realizar chamadas de API. Ela é parecida com outra ferramenta famosa, mas com uma mudança de foco.

Em outras aplicações, principalmente aquelas que usam interface gráfica, é comum perceber que é mais fácil "bagunçar" os parâmetros de uma requisição para fazer um teste rápido do que automatizá-los com variáveis especiais ou coisas do tipo. No Postwoman, temos um design opinado, que faz com que seja mais fácil para um usuário alterar um paramêtro para um teste rápido sem que a alteração seja definitiva do que fazer o contrário.

Além disso, o Postwoman propõe que o usuário crie suas requisições e scripts em Ruby, tendo toda a flexibilidade e facilidade que essa linguagem oferece.

**Esta ferramenta ainda está em uma fase muito inicial de desenvolvimento, e bugs são frequentes.**

[EN](README-EN.md)

### Como instalar
Por enquanto, a gem não foi publicada na RubyGems, então é necessário instalar ela manualmente:

- Clone o repositório
- Deixe seu terminal no diretório do projeto
- Instale [Ruby](https://www.ruby-lang.org/en/documentation/installation/) e Bundler na sua máquina
- Rode no terminal o comando `make install`

### Como usar
Para começar a usar o Postwoman, é necessário criar uma package. Para isso, utilize o comando `$ postwoman -n diretorio_da_package`. Caso você já tenha uma package, utilize o comando `$ postwoman diretorio_da_package`. Digite `help` para mais informações.

