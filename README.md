# govdados.io
Ferramenta para automatizar o processo de importação de dados do dados.gov.br para o postgres.

**Requisitos**

1- Linux (por enquanto, somente testado com ubuntu 16.04)

2- Docker e Docker-Compose

**Esse projeto já possui os documentos necessários para importar dados de eleições do dados.gov**

Se você quer somente ver o negócio funcionando por enquanto, faça:

    sudo chmod +x deploy.sh
    ./deploy.sh

Para entender o que ocorre e poder adicionar outros dados, leia o texto abaixo.


**Como usar ?**

1- git clone https://github.com/vmvini/govdados.io.git

2- navegue até a pasta do projeto (pelo terminal)

3- Adicione permissões para o script de montagem da infraestrutura: 
  
  ` sudo chmod +x deploy.sh`

4- Verifique se possui o docker e o docker-compose instalados. Se não tiver, instale-os.

5- Veja o arquivo **datasource.txt** que se encontra na pasta do projeto. Ele serve para dizer ao govdados.io quais arquivos 
do governo ele deverá baixar e importar para o postgres.

Para que seja interpretado, ele deve seguir uma formatação específica. É simples, exemplo:

  
    
    CONSULTA_CAND
  
    http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2002.zip
  
    http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2004.zip
  
  

`CONSULTA_CAND` é nome da tabela para a qual você quer que os links de arquivos abaixos sejam enviados.

**OBS: Essas tabelas não são automaticamente criadas pelo govdados.io, você deve criar scripts sql para criação das tabelas e colocar na pasta tabelas dentro da pasta do projeto, lá já tem alguns scripts sql para servir como modelo**

**Outro aspecto interessante do datasource.txt**


    DESPESA_CAND_2002
    
    (DespesaCandidato)
    
    http://agencia.tse.jus.br/estatistica/sead/odsele/prestacao_contas/prestacao_contas_2002.zip
    
    RECEITA_CAND_2002
    
    (ReceitaCandidato)
    
    http://agencia.tse.jus.br/estatistica/sead/odsele/prestacao_contas/prestacao_contas_2002.zip
    

Observe que os links acima são iguais: `prestacao_contas_2002.zip`, mas eles são usados para popular diferentes tabelas:
`DESPESA_CAND_2002` e `RECEITA_CAND_2002`.  

E os nomes entre parênteses servem para dizer ao govdados.io quais arquivos extraídos devem ser enviados para a tabela. 

No exemplo acima, para a tabela DESPESA_CAND_2002, somente arquivos com o nome DespesaCandidato devem ser importados. Para a tabela RECEITA_CAND_2002, somente arquivos com o nome ReceitaCandidato.

Caso você queira que mais nomes de arquivos sejam válidos, basta adicionar o outro nome depois de um `;`. Ex: 

    (DespesaCandidato;DespCand)
    

**Utilização de Cache**

Todos os arquivos baixados pelo govdados.io são mantidos na pasta `cache` dentro do projeto.

Portanto, se você já tem os arquivos (zipados) mova-os para a pasta cache para que o govdados.io não precise baixar novamente.

Obs: Todos os arquivos devem ficar na raiz da pasta cache para serem identificados. Então não mova pastas que possuem esses arquivos, mova os arquivos.

Obs: Os arquivos devem estar zipados como os originais.


6- Para executar a ferramenta, execute no terminal, (estando na pasta do projeto):

    ./deploy.sh



