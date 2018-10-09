


--14) Modifica o tipo da coluna n_de_fãs
ALTER TABLE equipe
MODIFY n_de_fãs NUMBER;



--15) Adiciona uma coluna na tabela 'poder'
ALTER TABLE poder
ADD nivel_de_forca NUMBER; 

--16) Exclui a coluna nivel_de_forca da tabela 'poder'.

ALTER TABLE poder
DROP COLUMN nivel_de_forca;

--17) Operadores aritméticos no SELECT. Quantia de personagens do SELECT 21)
--21) Uso de HAVING . Retorna todos os poderes que mais de um personagens tem e a quantia de personagens. 

SELECT codigo_do_poder, COUNT(codinome)
FROM heroi_poder
GROUP BY codigo_do_poder
HAVING COUNT(codinome) > 1;

--18)funcao de agregaçao sem group by
-- Pegando o ano de nascimento mais antigo de um personagem registrado no bd
SELECT MIN(EXTRACT(year FROM p.data_de_nascimento)) FROM personagem p




--19) funçao de agregaçao com group by
--22) uso de having com subconsulta
--Pegando o numero de personagens nascidos em anos menores do que a média de ano de nascimento dos personagens do bd, agrupados por ano.
SELECT COUNT(EXTRACT(year FROM p.data_de_nascimento)) contagem, EXTRACT(year FROM p.data_de_nascimento) ano  FROM personagem p
GROUP BY EXTRACT(year FROM p.data_de_nascimento)
HAVING EXTRACT(year FROM p.data_de_nascimento) < (SELECT AVG(EXTRACT(year FROM data_de_nascimento)) FROM personagem)





--20) Caso um valor esteja duplicado, retorna ele apenas uma vez

SELECT DISTINCT endereço_de_nascimento
FROM personagem



--23)Uso de WHERE + HAVING. Retorna o nome dos heróis que já lutaram contra jackson em mais de um lugar.

SELECT codinomeheroi
FROM luta
WHERE codinomevilao='Jackson'
GROUP BY codinomeheroi
HAVING COUNT(endereço_da_luta)>1;

--24) Junção entre duas tabelas
--Pegando todos os endereços de lugares do bd (incluindo os que não são local de nascimento de nenhum personagem cadastrado)
SELECT DISTINCT l.endereço FROM
personagem p RIGHT JOIN lugar l
ON  p.endereço_de_nascimento = l.endereço


--25) Junção entre três tabelas + condição de seleção (M:N)
-- Listando codinomes dos herois e o nome de seus super poderes de herois que tem superpoderes.
SELECT p.codinome "Codinome do Herói", pow.nome "Nome do Poder" FROM personagem p, poder pow, heroi_poder hp
WHERE p.codinome = hp.codinome AND pow.codigo_do_poder = hp.codigo_do_poder;



--26) INNER JOIN (intersecção)

SELECT d.codinome
FROM personagem_filiação_equipe d
INNER JOIN símbolo s on s.codigo_de_equipe = d.codigo_de_equipe

--27) LEFT JOIN , pega só a parte da esquerda (personagem_filiação_equipe)

SELECT d.codinome
FROM personagem_filiação_equipe d
LEFT JOIN símbolo s on s.codigo_de_equipe = d.codigo_de_equipe


--28) RIGHT JOIN, pega só a parte da direita (personagem_filiação_equipe)

SELECT d.codinome
FROM personagem_filiação_equipe d
RIGHT JOIN símbolo s on s.codigo_de_equipe = d.codigo_de_equipe

--29) FULL OUTER JOIN pega tudo(união)

SELECT d.codinome
FROM personagem_filiação_equipe d
FULL OUTER JOIN símbolo s on s.codigo_de_equipe = d.codigo_de_equipe

--30) Uma subconsulta com ​uso de ANY ou SOME. (RETORNA o codinome e a frase de efeito dos personagens que já lutaram na Avenida do desespero, 555).

SELECT codinome, frase_de_efeito
FROM personagem
WHERE codinome = ANY(SELECT codinomeheroi FROM luta WHERE endereço_da_luta='Avenida do desespero, 555' )
        OR
        codinome = ANY(SELECT codinomevilao FROM luta WHERE endereço_da_luta='Avenida do desespero, 555' );

--31) Uma subconsulta com ​uso de ALL (retorna o codinome dos personagens que participam de uma equipe que não tem mais do que 300000 fãs).

SELECT codinome
FROM personagem_filiação_equipe
WHERE codigo_de_equipe <> ALL (SELECT codigo_de_equipe FROM equipe WHERE n_de_fãs > 300000);

--32)  Uma subconsulta com ​uso de EXISTS/NOT EXISTS(retorna os paises que o Heroi Ronaldinho já lutou.)

SELECT país
FROM lugar
WHERE EXISTS (SELECT codinomeheroi FROM luta WHERE endereço_da_luta = lugar.endereço AND codinomeheroi = 'Ronaldinho');

--34) usando union
--Listando a união de todos os personagens que nasceram em julho com todos os personagens cujo uniforme é Emana desespero.
SELECT * FROM personagem p
WHERE EXTRACT(month FROM p.data_de_nascimento) = 07

UNION

SELECT * FROM personagem p1
WHERE p1.uniforme = 'Emana desespero'


--35) usando intersect
--Listando a interseção de todos os personagens que nasceram em dezembro com todos os personagens cujo uniforme é Emana desespero.
SELECT * FROM personagem p
WHERE EXTRACT(month FROM p.data_de_nascimento) = 12

INTERSECT

SELECT * FROM personagem p1
WHERE p1.uniforme = 'Emana desespero'


--36) usando minus
--Listando todos os personagens que nasceram em dezembro, exceto os personagens cujo unifrome é Emana desespero.
SELECT * FROM personagem p
WHERE EXTRACT(month FROM p.data_de_nascimento) = 12

MINUS

SELECT * FROM personagem p1
WHERE p1.uniforme = 'Emana desespero'


--45) junçao de tres tabelas utilizando inner join
-- Listando codinomes dos herois e o nome de seus super poderes de herois que tem superpoderes.
SELECT p.codinome "Codinome do Herói" , pow.nome  "Nome do Poder" FROM personagem p INNER JOIN heroi_poder hp
ON p.codinome = hp.codinome INNER JOIN poder pow
ON pow.codigo_do_poder = hp.codigo_do_poder




--48) Bloco anônimo

DECLARE 
anome personagem.codinome%TYPE;

BEGIN

anome := '******';

UPDATE personagem set codinome = anome
WHERE codinome = 'palavrão';
END;
/


