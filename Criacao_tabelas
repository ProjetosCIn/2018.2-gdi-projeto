CREATE TABLE local(
  --endereço   qual o tipo de dado?
  latitude FLOAT(3,8),
  longitude FLOAT (3,8),
  país VARCHAR (50),
  CONSTRAINT local_pk PRIMARY KEY(endereço)
)

CREATE TABLE personagem(
   codinome VARCHAR(50),
   frase_de_efeito  VARCHAR (255),
   --uniforme  qual o tipo de dado? boolean ?
   -- endereço_de_nascimento (mesmo tipo de endereço)
   data_de_nascimento DATE NOT NULL,
   CONSTRAINT personagem_pk PRIMARY KEY (codinome),
   CONSTRAINT personagem_fk FOREIGN KEY(data_de_nascimento) REFERENCES local(endereço)
)

CREATE TABLE heroi(
    codinome VARCHAR (20) NOT NULL,
    crh INT (10) NOT NULL,
    CONSTRAINT heroi_pk PRIMARY KEY (codinome),
    CONSTRAINT heroi_fk FOREIGN KEY personagem(codinome) REFERENCES personagem(codinome)

)

CREATE TABLE vilao(
    codinome VARCHAR(50) ,
    n_de_procurado INT (10),
    CONSTRAINT vilao_pk PRIMARY KEY (codinome),
    CONSTRAINT vilao_fk FOREIGN KEY (codinome) REFERENCES personagem(codinome)
)

CREATE TABLE mentor(
    codinomementor VARCHAR(50),
    codinomementorado VARCHAR(50),
    CONSTRAINT mentor_pk PRIMARY KEY (codinomementor,codinomementorado),
    CONSTRAINT mentor_fk FOREIGN KEY (codinomementor) REFERENCES personagem(codinome), -- vem de uma msm tabela, 
    CONSTRAINT mentor_fk2 FOREIGN KEY (codinomementorado) REFERENCES personagem(codinome) -- ficam juntos? assim como no Modelo relacional?
)

CREATE TABLE poder(
    codigo_do_poder INT(10),
    nome VARCHAR (50),
    tipo VARCHAR (30),
    legalidade boolean,
    CONSTRAINT poder_pk PRIMARY KEY (codigo_do_poder)
    )

CREATE TABLE heroi_poder(
    codinome VARCHAR(50),
    codigo_do_poder INT(10),
    CONSTRAINT heroi_poder_pk PRIMARY KEY (codinome,codigo_do_poder),
    CONSTRAINT heroi_poder_fk FOREIGN KEY (codinome) REFERENCES personagem(codinome),
    CONSTRAINT heroi_poder_fk2 FOREIGN KEY(codigo_do_poder) REFERENCES poder(codigo_do_poder)
)

CREATE TABLE luta(
    codinomeheroi VARCHAR (50),
    codinomevilao VARCHAR (50),
    --endereço_da_luta 



)

CREATE TABLE equipe(
    codigo_de_equipe INT(10),
    n_de_fãs BIGINT(19), --Tem que ser só  número positivo..
    CONSTRAINT equipe_pk PRIMARY KEY (codigo_de_equipe,n_de_fãs)
 )

CREATE TABLE area_de_atuação(
    codigo_de_equipe INT(10),
    area -- qual o tipo de dado?
    CONSTRAINT area_de_atuação_pk PRIMARY KEY (codigo_de_equipe,area),
    CONSTRAINT area_de_atuação_fk FOREIGN KEY (codigo_de_equipe) REFERENCES equipe(codigo_de_equipe)
)


CREATE TABLE qg(
    codigo_de_equipe INT(10),
    n_de_qg INT(10),
    n_de_aposentos INT(10),
    CEP NUMBER,
    CONSTRAINT qg_pk PRIMARY KEY(codigo_de_equipe,n_de_qg),
    CONSTRAINT qg_fk FOREIGN KEY(codigo_de_equipe) REFERENCES equipe(codigo_de_equipe)

)

CREATE TABLE luta_envolve_equipe(



)

CREATE TABLE personagem_filiação_equipe(



)

CREATE TABLE simbolo(



)
