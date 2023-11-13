# SQL com IA Generativa
![IA Generativa](images/banner.png)

> **ATIVIDADE**: Quem tem 1 Atividade faltando - Pedir para uma Generative AI, criar 2 tabelas, informe para ele o nomes das tabelas, os campos, qual a relação entre elas e peça para ele criar essas tabelas, inserir dados e gerar algumas consultas.

Usei o [chatGPT](https://chat.openai.com) para essa tarefa.

## Gerando tabelas
### Prompt
```
Crie as instruções SQL para criar duas tabelas no SQL Server. Uma delas será denominada 'Cursos' e conterá os seguintes campos:
- 'id' (chave primária)
- 'nome_curso' (texto obrigatório)
A segunda tabela será chamada 'Alunos' e terá os seguintes campos:
- 'matrícula' (chave primária)
- 'nome_completo' (texto obrigatório com até 100 caracteres)
- 'cpf' (apenas números, obrigatório, único e com exatamente 11 caracteres)
- 'telefone' (texto opcional com até 15 caracteres)
- 'curso_id' (chave estrangeira para relacionamento com a tabela 'Cursos', obrigatório para representar um relacionamento onde cada aluno pode ter apenas um curso).
```
### Resultado
![Gerando tabelas no chatGPT](images/img-01.png)

## Gerando dados
### Prompt
```
Crie registros em cada uma das tabelas com dados fictícios
```
### Resultado
![Gerando dados fictícios no chatGPT](images/img-02.png)

## Gerando consultas
### Prompt
```
Crie algumas consultas aleatórias que relacionem essas duas tabelas
```
### Resultado
#### Listar todos os cursos:
![SQL - Listar todos os cursos](images/img-03.png)

#### Listar todos os alunos e o curso que estão cursando:
![SQL - Listar todos os alunos e o curso que estão cursando](images/img-04.png)

#### Encontrar o curso de um aluno específico pelo número de matrícula:
![SQL - Encontrar o curso de um aluno específico pelo número de matrícula](images/img-05.png)

#### Listar todos os cursos e a quantidade de alunos em cada curso:
![SQL - Listar todos os cursos e a quantidade de alunos em cada curso](images/img-06.png)

#### Encontrar todos os alunos que não estão atualmente matriculados em nenhum curso:
![SQL - Encontrar todos os alunos que não estão atualmente matriculados em nenhum curso](images/img-07.png)

---
**Outros Formatos:**
- [Google Docs](https://docs.google.com/document/d/1PwKY0ayeWYLy800srLoyIaOU1ngHfYQSOo1okp4Pkjs/edit?usp=sharing)

**Referências:**
- [ChatGPT](https://chat.openai.com/)

