


--15) Modifica o tipo da coluna n_de_fãs
ALTER TABLE equipe
MODIFY n_de_fãs NUMBER;



--15) Adiciona uma coluna na tabela 'poder'
ALTER TABLE poder
ADD nivel_de_forca NUMBER; 

--16) Exclui a coluna nivel_de_forca da tabela 'poder'.

ALTER TABLE poder
DROP COLUMN nivel_de_forca;






--20) Caso um valor esteja duplicado, retorna ele apenas uma vez

SELECT DISTINCT endereço_de_nascimento
FROM personagem

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

--48) Bloco anônimo

DECLARE 
anome personagem.codinome%TYPE;

BEGIN

anome := '******';

UPDATE personagem set codinome = anome
WHERE codinome = 'palavrão';
END;
/


