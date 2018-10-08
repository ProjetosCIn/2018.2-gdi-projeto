
--15) Adiciona uma coluna na tabela 'poder'
ALTER TABLE poder
ADD nivel_de_forca NUMBER; 

--16) Exclui a coluna nivel_de_forca da tabela 'poder'.

ALTER TABLE poder
DROP COLUMN nivel_de_forca;






--20) Caso um valor esteja duplicado, retorna ele apenas uma vez

SELECT DISTINCT endereço_de_nascimento
FROM personagem



