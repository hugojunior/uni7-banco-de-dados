# Linked Server
Um **Linked Server** é uma funcionalidade no SQL Server que permite a criação de uma conexão para acessar e consultar dados de fontes de dados remotas, incluindo outros servidores SQL, bancos de dados de terceiros e fontes de dados externas. Isso possibilita a integração de dados de diversas origens, permitindo que você execute consultas distribuídas e operações de recuperação de dados de diferentes fontes, tudo a partir de uma única instância do SQL Server.​

## Vantagens
1. **Acesso a Dados Distribuídos:** A principal vantagem do Linked Server é a capacidade de acessar dados de fontes distribuídas, sejam outros servidores SQL Server ou fontes de dados externas. Isso permite a integração de dados de várias origens em um único ambiente.
2. **Facilidade de Consulta Distribuída:** O Linked Server simplifica a execução de consultas distribuídas, permitindo que você combine dados de diferentes fontes em consultas SQL, facilitando a análise e relatórios abrangentes.
3. **Centralização de Dados:** O Linked Server permite centralizar o acesso a dados de várias fontes em um único servidor SQL, simplificando o gerenciamento e a consulta de informações.
4. **Recursos de Negócios:** É útil para empresas que precisam acessar dados de sistemas legados ou fontes externas para suportar processos de negócios.

## Desvantagens
1. **Problemas de Segurança**: A configuração incorreta do Linked Server pode levar a problemas de segurança, como acesso não autorizado, exposição de dados confidenciais e vulnerabilidades de injeção de SQL.
2. **Complexidade de Configuração**: Configurar um Linked Server pode ser um processo complexo, exigindo conhecimento avançado e configurações precisas. Erros na configuração podem levar a problemas de desempenho e segurança.
3. **Desempenho Inconsistente**: O desempenho de consultas distribuídas por meio de um Linked Server pode ser afetado pela latência da rede e pela eficiência das consultas, o que pode resultar em desempenho inconsistente.
4. **Manutenção Complexa**: A manutenção de Linked Servers, especialmente em ambientes com muitos servidores e fontes de dados, pode ser desafiadora e requer atualizações periódicas para manter a integridade e a segurança.
5. **Dependência de Conectividade de Rede**: O funcionamento do Linked Server depende da conectividade de rede, o que pode causar problemas se a rede apresentar interrupções.

## Habilitando
### Conexão no SQL Server
1. Abra o SQL Server Management Studio (SSMS).
2. Acesse a pasta "Server Objects" no Object Explorer.
3. Clique com o botão direito em "Linked Servers" e escolha "New Linked Server".
4. Configure as propriedades, incluindo nome, tipo, opções de segurança e servidor remoto.
5. Teste a conexão e, se bem-sucedido, crie o Linked Server.
6. Use o Linked Server para executar consultas distribuídas e acessar dados no servidor remoto.
7. Certifique-se de considerar a segurança e o desempenho ao fazê-lo.
### Conexão com arquivos Excel
1. Baixe o Microsoft Access Database Engine Redistributable do site da Microsoft, escolhendo a versão compatível com a arquitetura do SQL Server (32 bits ou 64 bits).
3. Execute o instalador e siga as instruções.
4. Reinicie o serviço do SQL Server.

## Exemplos
### 1. Consultando Google Maps
Neste exemplo, é realizada uma consulta direta à API XML do Google Maps usando o nome da cidade como entrada, a qual retorna informações adicionais e suas coordenadas geográficas.

**Dados utilizados:**
- [API do Google Maps](https://developers.google.com/maps)

**Código SQL:**
```sql
DECLARE @cidade VARCHAR(100) = 'Fortaleza'
DECLARE
    @obj INT,
    @Url VARCHAR(255),
    @resposta VARCHAR(8000),
    @xml XML

SET @Url = 'https://maps.googleapis.com/maps/api/geocode/xml?address=' + @cidade + '&sensor=false&key=[api-key-here]'

EXEC sys.sp_OACreate 'MSXML2.ServerXMLHTTP', @obj OUT
EXEC sys.sp_OAMethod @obj, 'open', NULL, 'GET', @Url, false
EXEC sys.sp_OAMethod @obj, 'send'
EXEC sys.sp_OAGetProperty @obj, 'responseText', @resposta OUT
EXEC sys.sp_OADestroy @obj

SET @xml = @resposta COLLATE SQL_Latin1_General_CP1251_CS_AS

SELECT
    @xml.value('(/GeocodeResponse/result/address_component/long_name)[1]', 'varchar(200)') AS Cidade,
    @xml.value('(/GeocodeResponse/result/formatted_address)[1]', 'varchar(200)') AS Cidade_Completo,
    @xml.value('(/GeocodeResponse/result/address_component/long_name)[2]', 'varchar(200)') AS Estado,
    @xml.value('(/GeocodeResponse/result/address_component/short_name)[2]', 'varchar(200)') AS Estado_Sigla,
    @xml.value('(/GeocodeResponse/result/address_component/long_name)[3]', 'varchar(200)') AS Pais,
    @xml.value('(/GeocodeResponse/result/address_component/short_name)[3]', 'varchar(200)') AS Pais_Sigla,
    @xml.value('(/GeocodeResponse/result/geometry/location/lat)[1]', 'varchar(200)') AS Latitude,
    @xml.value('(/GeocodeResponse/result/geometry/location/lng)[1]', 'varchar(200)') AS Longitude
```

### 2. Consultando bancos remotos
Neste exemplo, realizamos uma conexão remota com dois bancos de dados diferentes: um para selecionar estados da região Sul e outro para os estados da região Sudeste do Brasil. No final, combinamos e listamos os resultados ordenados por nome.

**Dados utilizados:**
- [Banco de Estados](databases/2.tabela-estados.sql)

**Código SQL:**
```sql
SELECT *
FROM OPENROWSET(
    'SQLNCLI',
    'Server=192.168.56.101,1433;Database=localidades;Uid=hugojunior;Pwd=hugojunior;',
    'SELECT nome, uf, ''Sul do Brasil'' as regiao FROM estados WHERE uf IN(''PR'', ''RS'', ''SC'')'
) AS estados_sul

UNION

SELECT *
FROM OPENROWSET(
    'SQLNCLI',
    'Server=192.168.56.102,1433;Database=localidades;Uid=hugojunior;Pwd=hugojunior;',
    'SELECT nome, uf, ''Sudeste do Brasil'' as regiao FROM estados WHERE uf IN(''ES'', ''MG'', ''RJ'', ''SP'')'
) AS estados_sudeste

ORDER BY nome ASC;
```

### 3. Consultando fontes múltiplas
Neste exemplo, listamos estados da região Nordeste de um banco local e os relacionamos com um banco remoto para filtrar estados brasileiros. Por fim, unimos esses resultados com estados estrangeiros de uma planilha do Excel e os ordenamos por país.

**Dados utilizados:**
- [Banco de Países](databases/1.tabela-paises.sql)
- [Banco de Estados](databases/2.tabela-estados.sql)
- [Excel de Estados estrangeiros](databases/4.tabela-estados-internacionais.xlsx)

**Código SQL:**
```sql
SELECT
    estados.id AS id,
    estados.nome AS nome,
    estados.uf AS uf,
    paises.nome AS pais
FROM
    estados
JOIN
    (
        SELECT *
        FROM OPENROWSET(
            'SQLNCLI',
            'Server=192.168.56.102,1433;Database=localidades;Uid=hugojunior;Pwd=hugojunior;',
            'SELECT * FROM paises'
        )
    ) AS paises
ON
    estados.pais = paises.id
WHERE
    estados.uf IN ('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE')

UNION

SELECT *
FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0 Xml;Database=C:\4.tabela-estados-internacionais.xlsx;',
    'SELECT * FROM [estados_internacionais$]'
)

ORDER BY pais ASC;
```