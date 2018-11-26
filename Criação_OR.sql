DROP TYPE tp_Coordenada;
DROP TYPE tp_Lugar;
DROP TYPE tp_Equipe;
DROP TYPE tp_Personagem;
DROP TYPE tp_Poder;
DROP TYPE tp_Heroi;
DROP TYPE tp_Vilão;
DROP TYPE tp_Area;
DROP TYPE tp_Area_De_Atuação;
DROP TYPE tp_Qg;
DROP TYPE tp_Símbolo;
DROP TYPE tp_Luta;







CREATE OR REPLACE TYPE tp_Coordenada AS OBJECT(
Latitude NUMBER(11),
Longitude NUMBER(11)
);
/

CREATE OR REPLACE TYPE tp_Lugar AS OBJECT(
    Endereço VARCHAR2(100),
    Coordenada tp_Coordenada,
    País VARCHAR2(50)
);
/

CREATE OR REPLACE TYPE tp_Equipe AS OBJECT(
    Cod_De_Equipe NUMBER(10),
    Numero_De_Fãs NUMBER(19)
);
/

CREATE OR REPLACE TYPE tp_Personagem AS OBJECT(
    Codinome VARCHAR2(50),
    Frase_De_Efeito VARCHAR2(255),
    Uniforme VARCHAR2(255),
    Endereço_De_Nascimento tp_Lugar,
    Data_de_Nascimento DATE,
    REF_equipe REF tp_Equipe,
    Mentor REF tp_Personagem,
    Mentorando REF tp_Personagem    
)NOT FINAL NOT INSTANTIABLE; -- abstrato
/

CREATE OR REPLACE TYPE tp_Poder AS OBJECT(
    Cod_Poder NUMBER(10),
    Nome VARCHAR2(50),
    Tipo VARCHAR2(30),
    Legalidade VARCHAR2(6) -- LEGAL OU ILEGAL
);
/

CREATE OR REPLACE TYPE tp_Heroi UNDER tp_Personagem(
    Crh NUMBER(10), 
    REF_poder REF tp_Poder
)FINAL;
/

CREATE OR REPLACE TYPE tp_Vilão UNDER tp_Personagem(
    Numero_De_Procurado NUMBER(10),
    REF_poder REF tp_Poder
)FINAL;
/

CREATE OR REPLACE TYPE tp_Area AS OBJECT(
    Area VARCHAR2(255),
    REF_Equipe REF tp_Equipe
);
/

CREATE OR REPLACE TYPE tp_Area_De_Atuação AS TABLE OF tp_Area; 
/


CREATE OR REPLACE TYPE tp_Qg AS OBJECT(
    Cep NUMBER,
    Numero_De_Aposentos NUMBER(10),
    Numero_De_Qg NUMBER(10),
    REF_equipe REF tp_Equipe,
    Cod_De_Equipe NUMBER(10)

);
/

CREATE OR REPLACE TYPE tp_Símbolo AS OBJECT(
    
    Cor_Predominante VARCHAR2(30),
    Significado VARCHAR2(255),
    Id_Imagem NUMBER,
    REF_equipe REF tp_Equipe
);
/

CREATE OR REPLACE TYPE tp_Luta AS OBJECT(
    Data DATE,
    Endereço tp_Lugar,
    REF_Heroi REF tp_Heroi,
    REF_Vilão REF tp_Vilão,
    REF_Equipe REF tp_Equipe
);
/


--Criação das tabelas
DROP TABLE tb_Lugar;
DROP TABLE tb_Equipe;
DROP TABLE tb_Personagem;
DROP TABLE tb_Poder;
DROP TABLE tb_Heroi;
DROP TABLE tb_Vilão;
DROP TABLE tb_Qg;
DROP TABLE tb_Símbolo;
DROP TABLE tb_Luta;


CREATE TABLE tb_Lugar OF tp_Lugar (
    PRIMARY KEY (Endereço)
);

CREATE TABLE tb_Equipe OF tp_Equipe(
    PRIMARY KEY (Cod_De_Equipe)
);

CREATE TABLE tb_Personagem OF tp_Personagem(
    PRIMARY KEY (Codinome)
);

CREATE TABLE tb_Poder OF tp_Poder(
    PRIMARY KEY (Cod_Poder)
);

CREATE TABLE tb_Heroi OF tp_Heroi( -- dando erro ( invalid indentifier)
    PRIMARY KEY (Codinome),
   -- FOREIGN KEY(REF_Poder) REFERENCES (tp_Poder)
   -- REF_Poder SCOPE IS tp_Poder
);

CREATE TABLE tb_Vilão OF tp_Vilão( 
    PRIMARY KEY (Numero_De_Procurado)
);

CREATE TABLE tb_Qg OF tp_Qg( 
    PRIMARY KEY (Numero_De_Qg,Cod_De_Equipe),
    FOREIGN KEY(REF_Equipe) REFERENCES tb_Equipe    
);

CREATE TABLE tb_Símbolo OF tp_Símbolo(
    PRIMARY KEY (Id_Imagem)
);

--CREATE TABLE tb_Luta OF tp_Luta(--???
 --   PRIMARY KEY () -- CodinomeHeroi, CodinomeVilao,Endereço_luta,Data_luta

--);
