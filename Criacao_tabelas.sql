CREATE TABLE lugar(
    endereço VARCHAR(100),   
    latitude NUMBER(3,8),
    longitude NUMBER(3,8),
    país VARCHAR (50),
    CONSTRAINT lugar_pk PRIMARY KEY(endereço)
);

CREATE TABLE personagem(
    codinome VARCHAR(50),
    frase_de_efeito  VARCHAR (255),
    uniforme  VARCHAR(255),
    endereço_de_nascimento VARCHAR(100),
    data_de_nascimento DATE NOT NULL,
    CONSTRAINT personagem_pk PRIMARY KEY (codinome),
    CONSTRAINT personagem_fk FOREIGN KEY(endereço_de_nascimento) REFERENCES lugar(endereço)
);

CREATE TABLE heroi(
    codinome VARCHAR (20),
    crh INT(10),
    CONSTRAINT heroi_pk PRIMARY KEY (codinome),
    CONSTRAINT heroi_fk FOREIGN KEY personagem(codinome) REFERENCES personagem(codinome)

);

CREATE TABLE vilao(
    codinome VARCHAR(50),
    n_de_procurado INT (10),
    CONSTRAINT vilao_pk PRIMARY KEY (codinome),
    CONSTRAINT vilao_fk FOREIGN KEY (codinome) REFERENCES personagem(codinome)
);

CREATE TABLE mentor(
    codinomementor VARCHAR(50),
    codinomementorado VARCHAR(50),
    CONSTRAINT mentor_pk PRIMARY KEY (codinomementor,codinomementorado),
    CONSTRAINT mentor_fk FOREIGN KEY (codinomementor) REFERENCES personagem(codinome), -- vem de uma msm tabela, 
    CONSTRAINT mentor_fk2 FOREIGN KEY (codinomementorado) REFERENCES personagem(codinome) -- ficam juntos? assim como no Modelo relacional?
);

CREATE TABLE poder(
    codigo_do_poder INT(10),
    nome VARCHAR (50) NOT NULL,
    tipo VARCHAR (30) NOT NULL,
    legalidade boolean NOT NULL,
    CONSTRAINT poder_pk PRIMARY KEY (codigo_do_poder)
    );

CREATE TABLE heroi_poder(
    codinome VARCHAR(50),
    codigo_do_poder INT(10),
    CONSTRAINT heroi_poder_pk PRIMARY KEY (codinome,codigo_do_poder),
    CONSTRAINT heroi_poder_fk FOREIGN KEY (codinome) REFERENCES personagem(codinome),
    CONSTRAINT heroi_poder_fk2 FOREIGN KEY(codigo_do_poder) REFERENCES poder(codigo_do_poder)
);

CREATE TABLE luta(
    codinomeheroi VARCHAR (50) NOT NULL,
    codinomevilao VARCHAR (50) NOT NULL,
    endereço_da_luta VARCHAR(100),
    data_luta DATE NOT NULL,
    CONSTRAINT luta_pk PRIMARY KEY(codinomeheroi,codinomevilao,endereço_da_luta,data_luta),
    CONSTRAINT luta_fk FOREIGN KEY(codinomeheroi) REFERENCES heroi(codinome), 
    CONSTRAINT luta_fk2 FOREIGN KEY(codinomevilao) REFERENCES vilao(codinome),
    CONSTRAINT luta_fk3 FOREIGN KEY (endereço_da_luta) REFERENCES lugar(endereço)
);

CREATE TABLE equipe(
    codigo_de_equipe INT(10),
    n_de_fãs BIGINT(19), --Tem que ser só  número positivo..
    CONSTRAINT equipe_pk PRIMARY KEY (codigo_de_equipe,n_de_fãs)
 );

CREATE TABLE area_de_atuação(
    codigo_de_equipe INT(10),
    area VARCHAR(255),
    CONSTRAINT area_de_atuação_pk PRIMARY KEY (codigo_de_equipe,area),
    CONSTRAINT area_de_atuação_fk FOREIGN KEY (codigo_de_equipe) REFERENCES equipe(codigo_de_equipe)
);


CREATE TABLE qg(
    codigo_de_equipe INT(10),
    n_de_qg INT(10),
    n_de_aposentos INT(10),
    CEP NUMBER,
    CONSTRAINT qg_pk PRIMARY KEY(codigo_de_equipe,n_de_qg),
    CONSTRAINT qg_fk FOREIGN KEY(codigo_de_equipe) REFERENCES equipe(codigo_de_equipe)

);

CREATE TABLE luta_envolve_equipe(
    codinomeheroi VARCHAR(50), 
    codinomevilao VARCHAR(50),
    endereço_da_luta VARCHAR(100),
    codigo_de_equipe INT(10),
    data_luta DATE,  
    CONSTRAINT luta_envolve_equipe_pk PRIMARY KEY (codinomeheroi,codinomevilao,endereço_da_luta,codigo_de_equipe,data_luta)
    CONSTRAINT luta_envolve_equipe_fk FOREIGN KEY (codinomeheroi,codinomevilao,endereço_da_luta) REFERENCES luta(codinomeheroi,codinomevilao,endereço_da_luta)
    CONSTRAINT luta_envolve_equipe_fk2 FOREIGN KEY (codigo_de_equipe) REFERENCES equipe(codigo_de_equipe)
);

CREATE TABLE personagem_filiação_equipe(
    codigo_de_equipe INT(10),
    codinome VARCHAR (50),
    CONSTRAINT personagem_filiação_equipe_pk PRIMARY KEY (codigo_de_equipe,codinome),
    CONSTRAINT personagem_filiação_equipe_fk FOREIGN KEY (codigo_de_equipe) REFERENCES equipe(codigo_de_equipe),
    CONSTRAINT personagem_filiação_equipe_fk2 FOREIGN KEY (codinome) REFERENCES personagem(codinome)
);

CREATE TABLE símbolo( --Falta completar
    image imagem,
    codigo_de_equipe INT(10),
    significado VARCHAR(255),
    cor_predominante VARCHAR(30),
 
    CONSTRAINT símbolo_pk PRIMARY KEY (imagem),
    CONSTRAINT símbolo_fk FOREIGN KEY (codigo_de_equipe) REFERENCES equipe(codigo_de_equipe)
);
