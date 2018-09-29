--layout

INSERT INTO local(endereço,país,latitude,longitude) VALUES (endereço,'Brasil',1111111111,1111111111)

INSERT INTO personagem(codinome,frase_de_efeito,uniforme,endereço_de_nascimento,data_de_nascimento) VALUES ('codinome','frase',uniforme,endereço,11/11/1111)

INSERT INTO heroi(codinome,crh) VALUES ('Codinome',1234567)

INSERT INTO vilao(codinome,n_de_procurado) VALUES ('codinome','012345')

INSERT INTO mentor(codinomementor,codinomementorado) VALUES ('Codinomementor','codinomementorado')

INSERT INTO poder(codigo_do_poder,nome,tipo,legalidade) VALUES (010203,'nome poder','tipo poder',TRUE) -- true == poder legal

INSERT INTO heroi_poder(codinome,codigo_do_poder) VALUES ('codinome',77777)

INSERT INTO luta_envolve_equipe(codinomeheroi,codinomevilao,endereço_da_luta,codigo_de_equipe,data_luta) VALUES ('codinomeHeroi','CodinomeVilao',EndereçoLuta,11111,11/11/1111)

INSERT INTO personagem_filiação_equipe(codigo_de_equipe,codinome) VALUES (222222,'codinome')

INSERT INTO símbolo(imagem,codigo_de_equipe,significado,cor_predominante) VALUES (imagem,'Significado','CorPredominante')
