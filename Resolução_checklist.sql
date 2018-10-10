


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


--50)USO DE IF-THEN-ELSE
--51)USO DE ELSIF

DECLARE
    h_frase personagem.frase_de_efeito%TYPE;
    h_date NUMBER;
BEGIN
    SELECT frase_de_efeito, EXTRACT(month FROM data_de_nascimento) INTO h_frase, h_date
    FROM personagem WHERE personagem.codinome = 'Deku';
    IF h_date = 07 THEN
        DBMS_OUTPUT.PUT_LINE('Deku nasceu em julho e sua frase de efeito é: '||h_frase);
    ELSIF h_date = 12 THEN
        DBMS_OUTPUT.PUT_LINE('Deku nasceu em dezembro e sua frase de efeito é: '||h_frase);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Deku não nasceu nem em julho nem em dezembro e sua frase de efeito é: '||h_frase);
    END IF;
END;

--52) Uso de CASE

DECLARE
    h_frase personagem.frase_de_efeito%TYPE;
    h_date NUMBER;
    frase_output VARCHAR2(150);
BEGIN
    SELECT frase_de_efeito, EXTRACT(month FROM data_de_nascimento) INTO h_frase, h_date
    FROM personagem WHERE personagem.codinome = 'Deku';
    
    frase_output :=
    CASE
        WHEN (h_date <= 07 AND h_date > 0) THEN 'Deku nasceu entre janeiro e fevereiro e tem frase de efeito '||h_frase
        WHEN h_date > 7 AND h_date <= 10 THEN 'Deku nasceu entre agosto e outubro e tem frase de efeito '||h_frase
        WHEN (h_date > 10 AND h_date <=12) THEN 'Deku nasceu entre novembro e dezembro e tem frase de efeito '||h_frase
        ELSE 'Tem que rever esse banco de dados aí, ein rogerinho'
    END;
    DBMS_OUTPUT.PUT_LINE(frase_output);
END;
    

    
--53)Loop com Condição de Saída
--59)Uso de cursor explícito com variável
DECLARE
    h_name personagem.codinome%TYPE;
    h_frase personagem.frase_de_efeito%TYPE;
    h_date NUMBER;
    frase_output VARCHAR2(150);
    CURSOR cur_hero IS
        SELECT codinome, frase_de_efeito, EXTRACT(month FROM data_de_nascimento)
        FROM personagem;
BEGIN
    OPEN cur_hero;
    LOOP
        FETCH cur_hero INTO h_name, h_frase, h_date;
        EXIT WHEN cur_hero%NOTFOUND;
        frase_output :=
        CASE
            WHEN (h_date <= 07 AND h_date > 0) THEN h_name||' nasceu entre janeiro e julho e tem frase de efeito '||h_frase
            WHEN (h_date > 7 AND h_date <= 10) THEN h_name||' nasceu entre agosto e outubro e tem frase de efeito '||h_frase
            WHEN (h_date > 10 AND h_date <=12) THEN h_name||' nasceu entre novembro e dezembro e tem frase de efeito '||h_frase
            ELSE 'Tem que rever esse banco de dados aí, ein rogerinho'
        END;
        DBMS_OUTPUT.PUT_LINE(frase_output);
    END LOOP;
END;

--60)Uso de cursor explícito com registro    
DECLARE
    frase_output VARCHAR2(150);
    CURSOR cur_hero IS
        SELECT codinome, frase_de_efeito, EXTRACT(month FROM data_de_nascimento) mes
        FROM personagem;
    reg_hero cur_hero%ROWTYPE;
BEGIN
    OPEN cur_hero;
    LOOP
        FETCH cur_hero INTO reg_hero;
        EXIT WHEN cur_hero%NOTFOUND;
        frase_output :=
        CASE
            WHEN (reg_hero.mes <= 07 AND reg_hero.mes > 0) THEN reg_hero.codinome||' nasceu entre janeiro e julho e tem frase de efeito '||reg_hero.frase_de_efeito
            WHEN (reg_hero.mes > 7 AND reg_hero.mes <= 10) THEN reg_hero.codinome||' nasceu entre agosto e outubro e tem frase de efeito '||reg_hero.frase_de_efeito
            WHEN (reg_hero.mes > 10 AND reg_hero.mes <=12) THEN reg_hero.codinome||' nasceu entre novembro e dezembro e tem frase de efeito '||reg_hero.frase_de_efeito
            ELSE 'Tem que rever esse banco de dados aí, ein rogerinho'
        END;
        DBMS_OUTPUT.PUT_LINE(frase_output);
    END LOOP;
    CLOSE cur_hero;
END;
    
--63)Procedimento sem parâmetro
CREATE OR REPLACE PROCEDURE hero_details IS
    frase_output VARCHAR2(150);
    CURSOR cur_hero IS
        SELECT codinome, frase_de_efeito, EXTRACT(month FROM data_de_nascimento) mes
        FROM personagem;
    reg_hero cur_hero%ROWTYPE;
BEGIN
    OPEN cur_hero;
    LOOP
        FETCH cur_hero INTO reg_hero;
        EXIT WHEN cur_hero%NOTFOUND;
        frase_output :=
        CASE
            WHEN (reg_hero.mes <= 07 AND reg_hero.mes > 0) THEN reg_hero.codinome||' nasceu entre janeiro e julho e tem frase de efeito '||reg_hero.frase_de_efeito
            WHEN (reg_hero.mes > 7 AND reg_hero.mes <= 10) THEN reg_hero.codinome||' nasceu entre agosto e outubro e tem frase de efeito '||reg_hero.frase_de_efeito
            WHEN (reg_hero.mes > 10 AND reg_hero.mes <=12) THEN reg_hero.codinome||' nasceu entre novembro e dezembro e tem frase de efeito '||reg_hero.frase_de_efeito
            ELSE 'Tem que rever esse banco de dados aí, ein rogerinho'
        END;
        DBMS_OUTPUT.PUT_LINE(frase_output);
    END LOOP;
    CLOSE cur_hero;
END;
    
--64) Procedimento com parâmetro IN
CREATE OR REPLACE PROCEDURE hero_details (requestedAdress VARCHAR) IS
    frase_output VARCHAR2(150);
    CURSOR cur_hero IS
        SELECT codinome, frase_de_efeito, EXTRACT(month FROM data_de_nascimento) mes
        FROM personagem WHERE endereço_de_nascimento = requestedAdress;
    reg_hero cur_hero%ROWTYPE;
BEGIN
    OPEN cur_hero;
    LOOP
        FETCH cur_hero INTO reg_hero;
        EXIT WHEN cur_hero%NOTFOUND;
        frase_output :=
        CASE
            WHEN (reg_hero.mes <= 07 AND reg_hero.mes > 0) THEN reg_hero.codinome||' nasceu entre janeiro e julho e tem frase de efeito '||reg_hero.frase_de_efeito
            WHEN (reg_hero.mes > 7 AND reg_hero.mes <= 10) THEN reg_hero.codinome||' nasceu entre agosto e outubro e tem frase de efeito '||reg_hero.frase_de_efeito
            WHEN (reg_hero.mes > 10 AND reg_hero.mes <=12) THEN reg_hero.codinome||' nasceu entre novembro e dezembro e tem frase de efeito '||reg_hero.frase_de_efeito
            ELSE 'Tem que rever esse banco de dados aí, ein rogerinho'
        END;
        DBMS_OUTPUT.PUT_LINE(frase_output);
    END LOOP;
    CLOSE cur_hero;
END;
                                                             
-- 68)
                                                             
CREATE OR REPLACE FUNCTION totalPersonagem 
RETURN number IS 
   total number(3) := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM personagem; 
    
   RETURN total; 
END; 
/ 
                                                             
                                                             
    
--74)AFTER TRIGGER
--75)TRIGGER de Linha sem condição
--80)Uso de NEW e OLD em TRIGGER de atualização
CREATE OR REPLACE TRIGGER trig_msg
AFTER UPDATE OF frase_de_efeito ON personagem
REFERENCING OLD AS V NEW AS N
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Alteração na frase de efeito realizada com sucesso! Frase antiga: '||:V.frase_de_efeito||' e frase nova: '||:N.frase_de_efeito);
END;

