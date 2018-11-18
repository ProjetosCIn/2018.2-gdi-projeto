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
    REF_equipe REF tp_Equipe
    
    
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
CREATE OR REPLACE TYPE Area_De_Atuação AS TABLE OF tp_Area; 
/



CREATE OR REPLACE TYPE tp_Qg AS OBJECT(
    Cep NUMBER,
    Numero_De_Aposentos NUMBER(10),
    Numero_De_Qg NUMBER(10),
    REF_equipe REF tp_Equipe

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
