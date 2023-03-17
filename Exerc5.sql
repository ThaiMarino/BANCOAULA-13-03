-- 5. A) Crie uma procedure para inserir um gênero novo (Ficção)

#INSERT INTO genero (idgenero,descricao)
#VALUES (1,'Ação');

#5A exemplo 1
delimiter $$
create procedure insertGen(id int, descri varchar(60))
begin
	insert into cinema.genero (idgenero, descricao)
    values (id, descri);
end$$
delimiter ; 

call insertGen(8,'Ficção');
call insertGen(9,'Infantil');
select * from genero;


#5A exemplo 2

#subconsulta
#select max(ge.idgenero)+1 from genero as ge;

delimiter $$
create procedure insertGen2(descri varchar(60))
begin
	insert into cinema.genero (idgenero, descricao)
    values ((select max(ge.idgenero)+1 from genero as ge), descri);
end$$
delimiter ; 

call insertGen2('Terror');



-- 5.B)Crie uma procedure para inserir um filme de sua preferência.
delimiter $$
create procedure insertFil(id int, nome varchar(200), dur time, gen int)
begin
	insert into cinema.filme (idFilme, titulo, duracao, genero_idgenero)
    values (id, nome, dur, gen);
end$$
delimiter ; 

call insertFil(16,'O Dilema das Redes', '2:00', 7);
call insertFil(17,'O Projeto Adam','1:46',8);
call insertFil(18,'Fragmentado','1:57',2);
call insertFil(19,'Uncharted: Fora do Mapa','1:56',5);

-- consultando filmes cadastrados
select * from filme;

-- 6A) Crie um Stored Procedure para inserir uma nova sala

DELIMITER %%
CREATE PROCEDURE InsertSala(id int, nome VARCHAR(45), qtdeAssento int)
begin
	insert into cinema.sala 
    (idsala, nome, qtdeAssento)
    values (id, nome, qtdeAssento);
end%%
DELIMITER ;

CALL InsertSala(16,'Sala 2', '55');

-- OUTRA MANEIRA DE FAZER, COLOCANDO AUTOINCREMENTO NO NÚMERO DA SALA
DELIMITER $$
CREATE PROCEDURE createRoom(nome varchar(60), qtdeAssento int)
begin
	insert into cinema.sala 
    (idsala, nome, qtdeAssento)
    values 
    ((select max(sa.idsala)+1 from sala as sa), nome, qtdeAssento);
end$$
DELIMITER ; 

call createRoom('sala 4', 60);



-- 6B) Crie um Store Procedure para inserir uma nova sala com uma condição que se o código for
-- menor que 50, insira 70 assentos, caso contrário, insira 90 assentos (estrutura condicional e uso de variável)

DELIMITER $$
CREATE PROCEDURE InsertSala2(idsala int, nome VARCHAR(45))
begin
	IF idsala <= 50 THEN
		insert into cinema.sala
        (idsala, nome, qtdeAssento)
		values (idsala, nome, '70');
	ELSE 
		insert into sala.qtdeAssento
        (idsala, nome, qtdeAssento)
        values (idsala, nome, '90');
	END IF;
end$$

DELIMITER ;

CALL InsertSala2(17, 'Premium VIP');


 -- OUTRA FORMA DE FAZER A MESMA COISA, MAS CRIANDO VARIÁVEL
 DELIMITER $$
CREATE PROCEDURE InsertSalaVar(idsala int, nome VARCHAR(45))
begin
	DECLARE varQtde int;
    
    IF idsala <= 50 THEN
		SET varQtde = 70;
	ELSE
		SET varQtde = 90;
	END IF;
    
    INSERT INTO cinema.sala
		(idsala, nome, qtdeAssento)
        VALUES
        (idsala, nome, varQtde);
end$$
DELIMITER ;

CALL insertSalaVar(40, 'Platinum');



 