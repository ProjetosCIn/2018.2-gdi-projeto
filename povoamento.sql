INSERT INTO lugar(endereço, latitude, longitude, país) VALUES ('Rua dos testes, 321', 12345678901, 09876543210, 'Brasil');
INSERT INTO lugar(endereço, latitude, longitude, país) VALUES ('Avenida dos confrontos, 222', 12345228901, 09872243210, 'Brasil');

INSERT INTO personagem(codinome, frase_de_efeito, uniforme, endereço_de_nascimento, data_de_nascimento) VALUES ('Ronaldinho', 'Terminar um trabalho é glorioso', 'Formato dibróide', 'Rua dos testes, 321', to_date('1984-12-12', 'yyyy-mm-dd'));
INSERT INTO personagem(codinome, frase_de_efeito, uniforme, endereço_de_nascimento, data_de_nascimento) VALUES ('Jackson', 'Errar eu? So se for fazendo GDI', 'Emana desespero', 'Rua dos testes, 321', to_date('1990-12-12','yyyy-mm-dd'));

INSERT INTO heroi(codinome, crh) VALUES ('Ronaldinho', 1010101010);
INSERT INTO vilao(codinome, n_de_procurado) VALUES ('Jackson', 0000000000);

INSERT INTO mentor(codinomementor, codinomementorado) VALUES ('Ronaldinho', 'Jackson');

INSERT INTO poder(codigo_do_poder, nome, tipo, legalidade) VALUES (123, 'Dibre', 'Aumento de capacidade', 'LEGAL');
INSERT INTO poder(codigo_do_poder, nome, tipo, legalidade) VALUES (321, 'Brasileiro', 'Psíquico', 'ILEGAL');

INSERT INTO heroi_poder(codinome, codigo_do_poder) VALUES ('Ronaldinho', 123);

INSERT INTO luta(codinomeheroi, codinomevilao, endereço_da_luta, data_luta) VALUES ('Ronaldinho', 'Jackson', 'Rua dos testes, 321',to_date('2018-04-10', 'yyyy-mm-dd'));

INSERT INTO equipe(codigo_de_equipe, n_de_fãs) VALUES (555, 209384);

INSERT INTO area_de_atuação(codigo_de_equipe, area) VALUES (555, 'Crimes urbanos');

INSERT INTO qg(codigo_de_equipe, n_de_qg, n_de_aposentos, CEP) VALUES (555, 92837465, 5, 74833920);

INSERT INTO luta_envolve_equipe(codinomeheroi, codinomevilao, endereço_da_luta, codigo_de_equipe, data_luta) VALUES ('Ronaldinho', 'Jackson', 'Rua dos testes, 321', 555, to_date('2018-04-10', 'yyyy-mm-dd'));

INSERT INTO personagem_filiação_equipe(codigo_de_equipe, codinome) VALUES (555, 'Ronaldinho');

INSERT INTO símbolo(codigo_de_equipe, significado, cor_predominante, id_imagem) VALUES (555, 'Significa a abilidade de sempre dibrar', 'Verde', 20394855);
