INSERT INTO lugar(endereço, latitude, longitude, país) VALUES ('Rua dos testes, 321', 1111, 1111, 'Brasil');
INSERT INTO lugar(endereço, latitude, longitude, país) VALUES ('Avenida dos confrontos, 222', 2222, 2222, 'Alemanha');
INSERT INTO lugar(endereço, latitude, longitude, país) VALUES ('Avenida do desespero, 555', 3333, 3333, 'Japão');
INSERT INTO lugar(endereço, latitude, longitude, país) VALUES ('Rua das emboscadas, 231', 4444, 4444, 'Brasil');

INSERT INTO personagem(codinome, frase_de_efeito, uniforme, endereço_de_nascimento, data_de_nascimento) VALUES ('Ronaldinho', 'O dibre não compensa.', 'Formato dibróide', 'Rua dos testes, 321', to_date('1984-12-12', 'yyyy-mm-dd'));
INSERT INTO personagem(codinome, frase_de_efeito, uniforme, endereço_de_nascimento, data_de_nascimento) VALUES ('Jackson', 'Errar eu? So se for fazendo GDI.', 'Emana desespero', 'Rua dos testes, 321', to_date('1990-12-12','yyyy-mm-dd'));
INSERT INTO personagem(codinome, frase_de_efeito, uniforme, endereço_de_nascimento, data_de_nascimento) VALUES ('Deku', 'Eu vou me tornar o número um!', 'Verde com capuz', 'Rua dos testes, 321', to_date('1999-07-17', 'yyyy-mm-dd'));
INSERT INTO personagem(codinome, frase_de_efeito, uniforme, endereço_de_nascimento, data_de_nascimento) VALUES ('All Might', 'Está tudo bem, pois eu estou aqui!', 'Collant com capa', 'Rua dos testes, 321', to_date('1999-10-04','yyyy-mm-dd'));

INSERT INTO heroi(codinome, crh) VALUES ('Ronaldinho', 10);
INSERT INTO heroi(codinome, crh) VALUES ('Deku', 11);
INSERT INTO heroi(codinome, crh) VALUES ('All Might', 12);
INSERT INTO vilao(codinome, n_de_procurado) VALUES ('Jackson', 00);

INSERT INTO mentor(codinomementor, codinomementorado) VALUES ('Ronaldinho', 'Jackson');
INSERT INTO mentor(codinomementor, codinomementorado) VALUES ('All Might', 'Deku');

INSERT INTO poder(codigo_do_poder, nome, tipo, legalidade) VALUES (123, 'Dibre', 'Aumento de capacidade', 'LEGAL');
INSERT INTO poder(codigo_do_poder, nome, tipo, legalidade) VALUES (1234, 'Brasileiro', 'Psíquico', 'ILEGAL');
INSERT INTO poder(codigo_do_poder, nome, tipo, legalidade) VALUES (12345, 'One for all', 'Acúmulo de super força', 'LEGAL');

INSERT INTO heroi_poder(codinome, codigo_do_poder) VALUES ('Ronaldinho', 123);
INSERT INTO heroi_poder(codinome, codigo_do_poder) VALUES ('Deku', 12345);
INSERT INTO heroi_poder(codinome, codigo_do_poder) VALUES ('All Might', 12345);

INSERT INTO luta(codinomeheroi, codinomevilao, endereço_da_luta, data_luta) VALUES ('Ronaldinho', 'Jackson', 'Rua dos testes, 321',to_date('2018-04-10', 'yyyy-mm-dd'));
INSERT INTO luta(codinomeheroi, codinomevilao, endereço_da_luta, data_luta) VALUES ('Ronaldinho', 'Jackson', 'Avenida do desespero, 555',to_date('2018-04-11', 'yyyy-mm-dd'));
INSERT INTO luta(codinomeheroi, codinomevilao, endereço_da_luta, data_luta) VALUES ('Deku', 'Jackson', 'Avenida do desespero, 555',to_date('2018-04-20', 'yyyy-mm-dd'));
INSERT INTO luta(codinomeheroi, codinomevilao, endereço_da_luta, data_luta) VALUES ('Deku', 'Jackson', 'Rua dos testes, 321',to_date('2018-04-10', 'yyyy-mm-dd'));
INSERT INTO luta(codinomeheroi, codinomevilao, endereço_da_luta, data_luta) VALUES ('All Might', 'Jackson', 'Rua dos testes, 321',to_date('2018-05-10', 'yyyy-mm-dd'));

INSERT INTO equipe(codigo_de_equipe, n_de_fãs) VALUES (555, 209384);
INSERT INTO equipe(codigo_de_equipe, n_de_fãs) VALUES (10, 1000000);
INSERT INTO equipe(codigo_de_equipe, n_de_fãs) VALUES (11, 1000000);

INSERT INTO area_de_atuação(codigo_de_equipe, area) VALUES (555, 'Crimes urbanos');
INSERT INTO area_de_atuação(codigo_de_equipe, area) VALUES (11, 'Assalto a Banco');
INSERT INTO area_de_atuação(codigo_de_equipe, area) VALUES (10, 'Combate de grande escala');

INSERT INTO qg(codigo_de_equipe, n_de_qg, n_de_aposentos, CEP) VALUES (555, 111111, 5, 303020200);
INSERT INTO qg(codigo_de_equipe, n_de_qg, n_de_aposentos, CEP) VALUES (10, 101010, 2, 202030300);

INSERT INTO luta_envolve_equipe(codinomeheroi, codinomevilao, endereço_da_luta, codigo_de_equipe, data_luta) VALUES ('Ronaldinho', 'Jackson', 'Rua dos testes, 321', 555, to_date('2018-04-10', 'yyyy-mm-dd'));
INSERT INTO luta_envolve_equipe(codinomeheroi, codinomevilao, endereço_da_luta, codigo_de_equipe, data_luta) VALUES ('Deku', 'Jackson', 'Rua dos testes, 321', 10, to_date('2018-04-10', 'yyyy-mm-dd'));

INSERT INTO personagem_filiação_equipe(codigo_de_equipe, codinome) VALUES (555, 'Ronaldinho');
INSERT INTO personagem_filiação_equipe(codigo_de_equipe, codinome) VALUES (10, 'Deku');
INSERT INTO personagem_filiação_equipe(codigo_de_equipe, codinome) VALUES (11, 'Jackson');
INSERT INTO personagem_filiação_equipe(codigo_de_equipe, codinome) VALUES (555, 'All Might');

INSERT INTO símbolo(codigo_de_equipe, significado, cor_predominante, id_imagem) VALUES (555, 'Significa a abilidade de sempre dibrar', 'Verde', 321123);
INSERT INTO símbolo(codigo_de_equipe, significado, cor_predominante, id_imagem) VALUES (10, 'Vontade de seguir em frente', 'Vermelho', 123321);
