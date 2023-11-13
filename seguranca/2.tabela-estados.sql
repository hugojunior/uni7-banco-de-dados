--
-- Apaga a tabela "estados" caso ela exista
--
DROP TABLE IF EXISTS estados;

--
-- Estrutura da tabela "estados"
--
CREATE TABLE estados (
  id int NOT NULL,
  nome varchar(75) NOT NULL,
  uf varchar(2) NOT NULL,
  ibge int DEFAULT NULL,
  pais int NOT NULL,
  ddd varchar(50) DEFAULT NULL
);

--
-- Indexs da tabela "estados"
--
ALTER TABLE estados ADD PRIMARY KEY (id);
ALTER TABLE estados ADD FOREIGN KEY (pais) REFERENCES paises(id);
CREATE NONCLUSTERED INDEX nci_estados_nome ON estados(nome);

--
-- Inserindo dados na tabela "estados"
--
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(1, 'Acre', 'AC', 12, 1, '68')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(2, 'Alagoas', 'AL', 27, 1, '82')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(3, 'Amazonas', 'AM', 13, 1, '97,92')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(4, 'Amapá', 'AP', 16, 1, '96')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(5, 'Bahia', 'BA', 29, 1, '77,75,73,74,71')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(6, 'Ceará', 'CE', 23, 1, '88,85')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(7, 'Distrito Federal', 'DF', 53, 1, '61')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(8, 'Espírito Santo', 'ES', 32, 1, '28,27')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(9, 'Goiás', 'GO', 52, 1, '62,64,61')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(10, 'Maranhão', 'MA', 21, 1, '99,98')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(11, 'Minas Gerais', 'MG', 31, 1, '34,37,31,33,35,38,32')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(12, 'Mato Grosso do Sul', 'MS', 50, 1, '67')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(13, 'Mato Grosso', 'MT', 51, 1, '65,66')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(14, 'Pará', 'PA', 15, 1, '91,94,93')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(15, 'Paraíba', 'PB', 25, 1, '83')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(16, 'Pernambuco', 'PE', 26, 1, '81,87')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(17, 'Piauí', 'PI', 22, 1, '89,86')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(18, 'Paraná', 'PR', 41, 1, '43,41,42,44,45,46')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(19, 'Rio de Janeiro', 'RJ', 33, 1, '24,22,21')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(20, 'Rio Grande do Norte', 'RN', 24, 1, '84')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(21, 'Rondônia', 'RO', 11, 1, '69')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(22, 'Roraima', 'RR', 14, 1, '95')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(23, 'Rio Grande do Sul', 'RS', 43, 1, '53,54,55,51')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(24, 'Santa Catarina', 'SC', 42, 1, '47,48,49')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(25, 'Sergipe', 'SE', 28, 1, '79')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(26, 'São Paulo', 'SP', 35, 1, '11,12,13,14,15,16,17,18,19')
INSERT INTO estados (id, nome, uf, ibge, pais, ddd) VALUES(27, 'Tocantins', 'TO', 17, 1, '63');