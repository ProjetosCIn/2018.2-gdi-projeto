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

