-- 1. Criação de tipo e subtipo
-- 5. Criação e chamada de um método construtor (diferente do padrão)
-- 6. Criação e chamada de um função membro em um comando SELECT e em um bloco PL
CREATE OR REPLACE TYPE PersonagemType AS OBJECT(
	codinome VARCHAR(50),
	frase_de_efeito  VARCHAR (255),
	uniforme  VARCHAR(255),
	endereço_de_nascimento VARCHAR(100),
	data_de_nascimento DATE,
	CONSTRUCTOR FUNCTION PersonagemType(prefixo VARCHAR, 
		codinome VARCHAR, frase_de_efeito  VARCHAR,
		uniforme  VARCHAR,
		endereço_de_nascimento VARCHAR,
		data_de_nascimento DATE) RETURN SELF AS RESULT,
	MEMBER FUNCTION idade RETURN NUMBER
);
/

-- Modificação do Construtor
CREATE OR REPLACE TYPE BODY PersonagemType AS
	CONSTRUCTOR FUNCTION PersonagemType(
		prefixo VARCHAR, 
		codinome VARCHAR, frase_de_efeito  VARCHAR,
		uniforme  VARCHAR,
		endereço_de_nascimento VARCHAR,
		data_de_nascimento DATE) 
		RETURN SELF AS RESULT 
	AS 
	BEGIN
		SELF.codinome := CONCAT(prefixo, codinome);
		SELF.frase_de_efeito := frase_de_efeito;
		SELF.uniforme := uniforme;
		SELF.endereço_de_nascimento := endereço_de_nascimento;
		SELF.data_de_nascimento := data_de_nascimento;
		RETURN;
	END;
-- Modificação da Member Function
	MEMBER FUNCTION idade RETURN NUMBER IS
	idadeAno NUMBER;
	BEGIN
	    idadeAno := EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM SELF.data_de_nascimento);
		RETURN idadeAno;
	END;
	
END;
/

-- Criação de uma Tabela de Personagens

CREATE TABLE PersonagemTable of PersonagemType;
/

-- Chamada da criação do Tipo e da Member Function
DECLARE
    personagem PersonagemType;
    idade NUMBER;
BEGIN
		-- Inserção de Valores na Tabela de Personagens
    personagem := PersonagemType('Sr. ', 'Homem de Lata', 'Eu sou o homem de lata', 'Capa de Lata','Rua de Lata', to_date('12/10/1968', 'dd/mm/yyyy'));
    INSERT INTO PersonagemTable VALUES(personagem);
    -- INSERT INTO PersonagemTable VALUES(PersonagemType('123. ', '123123 de Lata', 'Eu 12312 o homem de lata', 'Capa de Lata','Rua de Lata', to_date('12/10/1968', 'dd/mm/yyyy')));
    
    SELECT personagem.idade() 
    INTO idade 
    FROM PersonagemTable personagem;
    
    dbms_output.put_line(idade);
    dbms_output.put_line(personagem.codinome);
END;
/

-- 2. Criação de um tipo que contenha um atributo que seja de um outro tipo

CREATE OR REPLACE TYPE HeroiType AS OBJECT(
	personagem PersonagemType,
	crh NUMBER(10)
);

-- 3. Criação de um tipo que contenha um atributo que seja de um tipo VARRAY
-- Coordenadas representando, latitude e longitude
CREATE OR REPLACE TYPE CoordenadaType AS VARRAY(3) OF NUMBER(15, 10);

CREATE OR REPLACE TYPE LugarType AS OBJECT(
	endereço VARCHAR(100),   
	coordenadas CoordenadaType,
	país VARCHAR (50)
);

-- 4. Criação de um tipo que contenha um atributo que seja de um tipo NESTED TABLE

CREATE OR REPLACE TYPE AreaAtuacao AS TABLE OF VARCHAR(255);

CREATE OR REPLACE TYPE equipeType AS OBJECT(
	codigo_de_equipe NUMBER(10),
	n_de_fãs NUMBER(19),
	areas AreaAtuacao
);

-- Questões 6,7 e 8. --Falta chamar as funções no select


DROP TABLE tb_Arma;
DROP TYPE tp_Arma;

DROP TABLE tb_Bermuda;
DROP TYPE tp_Bermuda;

CREATE OR REPLACE TYPE tp_Bermuda AS OBJECT(
    identificacao NUMBER,
    COR VARCHAR2(100),
    tamanho INTEGER,
     MAP MEMBER FUNCTION RetornoID RETURN NUMBER
    
    );
/
CREATE OR REPLACE TYPE BODY tp_Bermuda IS
    MAP MEMBER FUNCTION RetornoID RETURN NUMBER IS
        BEGIN
            RETURN identificacao;
        END;
        END;
        /
        
        
CREATE TABLE tb_Bermuda OF tp_Bermuda(
    PRIMARY KEY (identificacao)
);

INSERT INTO tb_Bermuda VALUES(tp_Bermuda('111','Azul','38'));
INSERT INTO tb_Bermuda VALUES(tp_Bermuda('222','Verde','40'));

--SELECT * FROM tb_Bermuda;

CREATE OR REPLACE TYPE tp_Arma AS OBJECT(
    IDD NUMBER,
    Nome VARCHAR2(100),
    Qtd_Poder INTEGER,
    MEMBER FUNCTION Soma(i INTEGER) RETURN INTEGER,
    ORDER MEMBER FUNCTION Teste(novo tp_Arma) RETURN INTEGER

    
);
/
CREATE OR REPLACE TYPE BODY tp_Arma IS
    MEMBER FUNCTION Soma(i INTEGER) RETURN INTEGER IS
        BEGIN
            RETURN SELF.Qtd_Poder + i;
        END;
        
    ORDER MEMBER FUNCTION Teste(novo tp_Arma) RETURN INTEGER IS
        BEGIN
            RETURN SELF.Qtd_Poder - novo.Qtd_Poder;
        END;
    
    END;    
       
/

CREATE TABLE tb_Arma OF tp_Arma(
    PRIMARY KEY (IDD)
);
--INSERT INTO tb_Arma VALUES(tp_Arma('123','Machado','10'));
INSERT INTO tb_Arma VALUES(tp_Arma('123','Machadoo','10'));
INSERT INTO tb_Arma VALUES(tp_Arma('1234','Facão','10'));
INSERT INTO tb_Arma VALUES(tp_Arma('1123','fACA','1'));
--SELECT * FROM tb_Arma;

DECLARE
variavel INTEGER := 2;
Resultado INTEGER;
Resultado2 INTEGER;
BEGIN

--SELECT Qtd_Poder into Resultado FROM tb_Arma WHERE Nome='Machadoo' AND IDD='123' AND tb_Arma.Soma(10)=12;--Algum erro
--select tb_Arma.Soma(10) FROM tb_Arma;
--dbms_output.put_line('Qtd_poder de Machadoo : '||Resultado);
--

--SELECT tb_Bermuda.RetornoID FROM tb_Bermuda; -- MAP



 
END;
/




--11.
ALTER TYPE tp_Símbolo
ADD ATTRIBUTE (Nome_Criador VARCHAR2(200)) CASCADE;

--12.
 ALTER TYPE tp_Símbolo
 MODIFY ATTRIBUTE Nome_Criador VARCHAR2(255)) CASCADE;

--13.
 ALTER TYPE tp_Símbolo
DROP ATTRIBUTE Nome_Criador CASCADE;

--14.
ALTER TYPE tp_Personagem
ADD ATTRIBUTE(Quantidade_De_Vitórias NUMBER(10)) CASCADE;

--15.
ALTER TYPE tp_Personagem
MODIFY ATTRIBUTE(Quantidade_De_Vitórias NUMBER(20)) INVALIDATE;

--20
SELECT DEREF(t.ref_poder).nome FROM tb_Heroi t;
--21
SELECT VALUE(t).codinome FROM tb_Heroi t;
-- 22, 26
SELECT * FROM TABLE(SELECT e.area_de_atuacao FROM tb_equipe e);

--16, 17

CREATE OR REPLACE TYPE tp_temPoder AS OBJECT(
	ref_poder REF tp_poder;
	ref_personagem REF tp_personagem;
);

CREATE TABLE tb_temPoder OF tp_temPoder(
	ref_poder WITH ROWID REFERENCES tb_poder;
	ref_personagem WITH ROWID REFERENCES tb_personagem;
);


-- 27
SELECT p.codinome from tb_personagem p
WHERE EXISTS(select * from tb_local l where p.ref_lugar = ref(l));


--9
ALTER TYPE tp_personagem ADD MEMBER FUNCTION getCodinome RETURN VARCHAR2 CASCADE;

CREATE OR REPLACE TYPE BODY tp_personagem AS
	MEMBER FUNCTION getCodinome RETURN VARCHAR2 IS
	BEGIN
		RETURN SELF.codinome
	END;
END;


DECLARE
aux tp_heroi;
BEGIN
	SELECT VALUE(t) INTO aux
	FROM tb_heroi t 
	WHERE t.codinome = 'Midoriya';
	DBMS_OUTPUT.PUT_LINE('Meu codinome é ' || aux.getCodinome());
END;



