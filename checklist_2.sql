1)
    SELECT codigo_de_equipe
    FROM equipe                         --Retorna todos as equipes com o determinado numero de fãs
    WHERE n_de_fãs BETWEEN 1 AND 999999
2)
    SELECT codinome
    FROM personagem --Retorna todos os personagems com a data de nascimento no intervalo especificado
    WHERE data_de_nascimento BETWEEN to_date('1996-07-01', 'yyyy-mm-dd') AND to_date('2000-07-31', 'yyyy-mm-dd')
3)
    SELECT codinome
    FROM personagem --Retorna todos os personagens que tem 'Might' no nome
    WHERE codinome LIKE '%Might%'
4)
    SELECT *
    FROM personagem --Retorna todos os heróis
    WHERE codinome IN (SELECT codinome FROM heroi)
5)
    SELECT frase_de_efeito
    FROM personagem   --Retorna as frases de efeito de todos os heróis que tem CRH
    WHERE codinome IN (SELECT codinome FROM heroi WHERE crh IS NOT NULL)
6)
    SELECT *
    FROM personagem
    ORDER BY data_de_nascimento ASC;
7)
    CREATE VIEW MATERNIDADES AS
    SELECT endereço, latitude, longitude
    FROM lugar, (SELECT endereço_de_nascimento FROM personagem) aux
    WHERE lugar.endereço = aux.endereço_de_nascimento
8)
    SELECT *
    FROM MATERNIDADES
    GROUP BY endereço, latitude, longitude
42)
    SELECT endereço, latitude, longitude
    FROM lugar, (SELECT endereço_de_nascimento FROM personagem)aux
    WHERE lugar.endereço = aux.endereço_de_nascimento
    GROUP BY endereço, latitude, longitude
44)
    SELECT codinome
    FROM heroi
    WHERE crh MIN(data_de_nascimento) AND AVG(data_de_nascimento) --RETORNA TODOS OS NOMES DE HERÓIS COM DATA DE NASCIMENTO MÍNIMA ATÉ O NUMERO MÉDIO


