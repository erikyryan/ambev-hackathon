# Otimização de Vendas Cruzadas aplicando a mineração de dados e técnicas de previsão de séries temporais

## Visão geral
Algoritmo responsavel por otimizar as vendas cruzadas empresa, levando em consideração previsões de series temporais

[Link da Apresentação do Projeto](https://www.canva.com/design/DAEtw5uzZFo/tWwnz8HMQsGlFXBVmPkRkg/view?utm_content=DAEtw5uzZFo&utm_campaign=designshare&utm_medium=link&utm_source=homepage_design_menu)

## Problema
Na sociedade atual, a busca por reinvenção para os meios digitais e a busca por prever o próximo passo do cliente vem sendo imprescindível para o crescimento de um negócio, visando a busca por ganhos. Desse modo, a  utilização técnicas de convenção de cliente, destacando entre elas a venda cruzada, isto é, o site oferece ao usuário produtos semelhantes a sua compra, aumentado o seu potencial de vendas e seus desempenho de lucro. Visto isso, se faz necessário a utilização de métodos para otimizar essa técnica das empresas.

## Proprosta de solução
Para tal problema foi pensado um algoritmo como solução,  o qual faria `Data mining` , ou seja , um tratamento dos dados para determinar os que serão úteis para a aplicação. Com o resultado dessa manutenção é aplicado o método `Holt Witer`, com o intuito de disponibilizar aos fornecedores uma estimativa média da quantidade de bebidas que seus atacadista irão precisar. Além disso, como forma de elevar a quantidade de transações, é feito, por meio do algoritimo `apriore` uma regra de negocio, a qual corressponde que se o cliente comprar mais a bebida A ele tem mais chances de levar a bebida B, proprorcionnando assim aos fornecedores a opção de fazer ofertas personalizadas para cada cliente.

# Informações Técnicas
## Gráfico explicativo
<img src = "https://github.com/erikyryan/ambev-hackathon/blob/main/tutorial/Arquitetura.svg" width="1000"><br><sub>ARQUITETURA DO SISTEMA</sub>

## Pré-requisitos
* Sistema Operacional - Linux, Windows, MacOs
* Linguagem Utilizadas 
    * Back end - R e Git
    * Front end - R , Git, HTML, CSS e JavaScript
* Ambiente Virtual - Rstudio e Vscode
* Arquivos de dados - a linguagem de marcação dos dados deve ser CSV, modelo: `nomedoarquivo.csv`
* Biblioteca 
  1. shiny - facilita a contrução de aplicativos web interativos
  2. shiny.router - facilita a mapeação dos arquivos em HTML, funciona juntamente ao shiny.
  3. gdata - facilita a manipulção de dados, como conversão de unidades mêdicas, operações com vetores, entrre outras
  4. dplyr - facilita a transformações de dados
  5. lubridate - facilita a transformação e extração de datas
  6. dygraphs - interface R para a biblioteca grafica do JavaScrip, responsavel por gerar gráficos de séries temporais.
  7. arules - facilita a manipulação e analise de dados e padrões de trasações(conjuntos de itens frequentes e regras de associação).

## Processo de instalação e execução
[INSTLAÇÃO](https://github.com/erikyryan/ambev-hackathon/blob/main/tutorial/README.md)

[EXECUÇÃO](https://github.com/erikyryan/ambev-hackathon/blob/main/tutorial/README.md)


# Equipe

## Asimov

O nome, Asimov, foi escolhido pensando no escritor e bioquímico norte-americano, Isaac Asimov, autor de grande obras da ficção científica, tendo uma das suas maiores obras, Fundação, baseada na queda do império romano, o autor usa conceitos estatísticos, sociais e históricos para prever um futuro distante da humanidade. Assim, por se tratar de um projeto na área de ciência de dados, na qual, busca-se sugerir a compra de produtos, tendo como base as informações do que o cliente comprou anteriormente e assim prever o volume de produção e recomendar produtos, pensou-se no uso do nome, Asimov, justamente ele ser referência na ficção científica e abordar esse aspecto da previsão.

## Membros
 [<img src = "https://avatars.githubusercontent.com/u/62263916?v=4" width="115"><br><sub>Eriky Ryan</sub>](https://github.com/erikyryan) 
 
 [<img src = "https://avatars.githubusercontent.com/u/57471802?v=4" width="115"><br><sub>Davi Fernandes</sub>](https://github.com/Davizex)
 
 [<img src = "https://avatars.githubusercontent.com/u/82542224?v=4" width="115"><br><sub>Rebecca Lelis</sub>](https://github.com/LopesRebecca)



## Licença

licenciado sob [MIT](https://github.com/erikyryan/trabalho-de-poo/blob/main/LICENSE)
