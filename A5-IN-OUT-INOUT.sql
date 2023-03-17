-- USE BD CINEMA
use cinema;

-- Exemplo com IN
DELIMITER &&
CREATE PROCEDURE filmeGenero (varGenero VARCHAR(60))
BEGIN
	Select F.titulo, G.descricao, S.dataHora from sessao S 
	inner join filme F
	on S.filme_idFilme = F.idFilme 
	inner join genero G 
	on F.genero_idgenero = G.idgenero
    where G.descricao=varGenero;
END;
&&
DELIMITER ;

-- Invocar procedure
CALL filmeGenero('Ação');


-- Exemplo com OUT e count:
-- OUT variavel de saida
-- por padrão as variaveis não declaradas são de entrada IN
-- resultado de COUNT será armazenado dentro (into) variavel qtdeAtores
delimiter //
CREATE PROCEDURE ObtemAtores (OUT qtdeAtores INT)
BEGIN
SELECT COUNT(*)
   INTO qtdeAtores
   FROM cinema.ator;
END
//

CALL ObtemAtores(@qtdeAtores);

SELECT @qtdeAtores;

-- inicio teste ----------------------------------------
-- SET - Atribuir valor a uma variavel
SET @qtdeAtores = 100;
-- verifique novamente o valor
SELECT @qtdeAtores;
-- chame a procedure e verifique o valor
CALL ObtemAtores(@qtdeAtores);
SELECT @qtdeAtores;
-- final teste ----------------------------------------


-- Exemplo com IN ---------------------------------------
SET @qtdeAtores4 = 2;

delimiter //
CREATE PROCEDURE ObtemAtoresIN (IN qtdeAtores4 INT)
BEGIN
SELECT COUNT(*)
   INTO qtdeAtores4
   FROM cinema.ator;
END
//

CALL ObtemAtoresIN(@qtdeAtores4);

SELECT @qtdeAtores4;


-- inicio teste ----------------------------------------
-- SET - Atribuir valor a uma variavel
SET @qtdeAtores4 = 220;
-- verifique novamente o valor
SELECT @qtdeAtores4;
-- chame a procedure e verifique o valor
CALL ObtemAtoresIN(@qtdeAtores4);
SELECT @qtdeAtores4;
-- final teste ----------------------------------------



-- Exemplo INOUT
-- o valor da variavel que for passada ao
-- parametro "valor" será refletida na propria variavel
-- externa, a qual terá seu valor alterado tambem

delimiter //
CREATE PROCEDURE aumento (INOUT valor DECIMAL(10,2), taxa DECIMAL(10,2))
BEGIN
	SET valor = valor +  valor * taxa /100;
END
//

-- criamos variavel valorinicial e usamos para pasar o parametro valor
-- aumento de 15%

set @variavelinicial = 20.00;
select @variavelinicial;

call aumento(@variavelinicial, 15.00);

-- verifique novamente o valor da variavel
select @variavelinicial;

