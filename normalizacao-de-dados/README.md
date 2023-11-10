# Normalização de Dados

## Sobre a Normalização
A normalização é o processo de organização de dados em um banco de dados, que envolve a criação de tabelas e o estabelecimento de relações entre essas tabelas, seguindo regras projetadas para proteger os dados e tornar o banco de dados mais flexível. Isso é alcançado ao eliminar redundâncias e evitar dependências inconsistentes.

Dados redundantes ocupam espaço em disco desnecessariamente e complicam a manutenção. Quando os mesmos dados estão presentes em vários locais, qualquer alteração nesses dados deve ser aplicada de maneira consistente em todos os locais. Por exemplo, a atualização do endereço de um cliente é mais simples de realizar se esses dados estiverem armazenados apenas na tabela de Clientes, em vez de dispersos em todo o banco de dados.

O conceito de "dependência inconsistente" refere-se à relação entre os dados. Enquanto é intuitivo procurar o endereço de um cliente na tabela de Clientes, pode não fazer sentido buscar o salário de um funcionário que atende a esse cliente nessa mesma tabela. O salário de um funcionário está relacionado aos funcionários e, portanto, deve ser armazenado na tabela de Funcionários. Dependências inconsistentes podem dificultar o acesso aos dados, pois o caminho para encontrar informações relevantes pode estar ausente ou ser difícil de seguir.

A normalização segue regras específicas, chamadas de "formas normais". O cumprimento da primeira regra resulta em um banco de dados na "primeira forma normal". O cumprimento das três primeiras regras leva o banco de dados à "terceira forma normal", que é considerada suficiente para a maioria das aplicações. Embora outros níveis de normalização sejam possíveis, a terceira forma normal é geralmente adequada para a maioria dos casos.

No entanto, em cenários do mundo real, nem sempre é possível atender às regras de normalização de maneira perfeita. Em algumas situações, a normalização pode exigir a criação de tabelas adicionais, o que pode parecer complicado para alguns usuários. Se for necessário violar uma das três primeiras regras de normalização, é importante prever e gerenciar possíveis problemas, como redundâncias de dados e dependências inconsistentes, em seu aplicativo.

## Primeira Forma Normal (1FN)
- Elimine grupos repetidos em tabelas individuais.
- Crie tabelas separadas para cada conjunto de dados relacionados.
- Atribua uma chave primária para identificar cada conjunto de dados relacionados.

A primeira forma normal é um princípio de normalização de bancos de dados que visa eliminar grupos repetidos em tabelas individuais. Para alcançar a primeira forma normal, é necessário criar uma tabela separada para cada conjunto de dados relacionados e identificá-los com uma chave primária exclusiva.

Evite o uso de vários campos em uma única tabela para armazenar dados semelhantes. Por exemplo, quando se trata de rastrear um item de inventário que pode ter origem em duas fontes possíveis, não é adequado criar campos separados para o "Código do Fornecedor 1" e o "Código do Fornecedor 2".

O que acontece quando um terceiro fornecedor é adicionado? A solução não é simplesmente adicionar mais campos, pois isso requer modificações no programa e na estrutura da tabela, e não lida bem com um número dinâmico de fornecedores. Em vez disso, é aconselhável criar uma tabela separada denominada "Fornecedores" e vincular as informações do inventário aos fornecedores usando uma chave, como o número do item, ou vincular os fornecedores aos itens de inventário usando uma chave de código do fornecedor.

## Segunda Forma Normal (2FN)
- Crie tabelas separadas para conjuntos de valores compartilhados por vários registros.
- Estabeleça relações entre essas tabelas utilizando chaves estrangeiras.

A segunda forma normal é um princípio de normalização de bancos de dados que recomenda a criação de tabelas separadas para conjuntos de valores que se aplicam a vários registros e estabelecer relacionamentos entre essas tabelas por meio de chaves estrangeiras.

De acordo com a segunda forma normal, os registros não devem depender de nada além da chave primária de uma tabela (ou uma chave composta, se necessário). Por exemplo, considere o endereço de um cliente em um sistema de contabilidade. O endereço é necessário para a tabela de Clientes, mas também é relevante para tabelas como Pedidos, Envio, Faturas, Contas a Receber e Coleções. Em vez de armazenar o endereço do cliente como uma entrada separada em cada uma dessas tabelas, a abordagem recomendada é armazená-lo em um único local, seja na tabela de Clientes ou em uma tabela separada chamada Endereços. Dessa forma, você evita a redundância de dados e mantém uma estrutura mais organizada e eficiente no banco de dados.

## Terceira Forma Normal (3FN)
- Remova campos que não são dependentes da chave.

A terceira forma normal na normalização de bancos de dados implica eliminar campos que não dependem da chave. Isso significa que os valores em um registro não devem estar na tabela se não fizerem parte da chave deste registro. Em geral, quando um grupo de campos se aplica a vários registros na tabela, é recomendável criar uma tabela separada para esses campos.

Por exemplo, se uma tabela de Recrutamento de Funcionários inclui o nome da universidade e o endereço do candidato, mas você também precisa de uma lista completa de universidades, armazenar essas informações na tabela Candidatos não é ideal. A solução é criar uma tabela de Universidades separada e vinculá-la à tabela Candidatos usando uma chave de código da universidade.

No entanto, existem exceções à aplicação rigorosa da terceira forma normal. Em situações em que sua tabela principal tem muitos campos relacionados, como cidades, CEPs, representantes de vendas e classes de clientes, criar várias tabelas separadas para cada um pode impactar o desempenho ou exceder as capacidades de arquivo e memória. Nessas circunstâncias, é mais prático aplicar a terceira forma normal apenas aos dados que mudam com frequência, e projetar o aplicativo para garantir a integridade dos dados, exigindo que o usuário verifique todos os campos relacionados quando qualquer um deles for alterado.

## Outras formas de normalização
A quarta forma normal, frequentemente chamada de BCNF (Boyce-Codd Normal Form), e a quinta forma normal são conceitos existentes, mas raramente são aplicados no design prático de bancos de dados. Ignorar essas regras adicionais pode levar a um design de banco de dados que não é perfeito, mas geralmente não afetará significativamente a funcionalidade do sistema.