-- 1. Criação de tipo e subtipo
-- 5. Criação e chamada de um método construtor (diferente do padrão)
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
		data_de_nascimento DATE) RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY PersonagemType AS
	CONSTRUCTOR FUNCTION PersonagemType(
		prefixo VARCHAR(50), 
		codinome VARCHAR(50), frase_de_efeito  VARCHAR (255),
		uniforme  VARCHAR(255),
		endereço_de_nascimento VARCHAR(100),
		data_de_nascimento DATE) 
		RETURN SELF AS RESULT 
	AS 
	BEGIN
		SELF.codinome := codinome;
		SELF.frase_de_efeito := frase_de_efeito;
		SELF.uniforme := uniforme;
		SELF.endereco_de_nascimento := endereco_de_nascimento;
		SELF.data_de_nascimento := data_de_nascimento;
		RETURN;
	END;
END;

-- Chamada 
DECLARE
    personagem PersonagemType;
BEGIN
    personagem := PersonagemType('Sr. ', 'Homem de Lata', 'Eu sou o homem de lata', 'Capa de Lata','Rua de Lata', to_date('12/10/1968', 'dd/mm/yyyy'));
    dbms_output.put_line(personagem.codinome);
END;


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



