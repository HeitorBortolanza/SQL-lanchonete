CREATE TABLE AtividadeSomativa.SANDUICHES(
	CodSanduiche INT AUTO_INCREMENT PRIMARY KEY,
	NomeSanduiche VARCHAR(45) NOT NULL UNIQUE,
	ValorSanduiche DECIMAL(6,2) NOT NULL
);

CREATE TABLE AtividadeSomativa.ENTREGADORES(
	CodEntregador SMALLINT AUTO_INCREMENT PRIMARY KEY,
	NomeEntregador VARCHAR(80) NOT NULL,
	TelefoneEntregador CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE AtividadeSomativa.CLIENTES (
	CodCliente INT AUTO_INCREMENT PRIMARY KEY,
	NomeCliente VARCHAR(80) NOT NULL
);

-- Como endereços DEFINITIVAMENTE não podem existir sem cllientes, mas clientes podem existir sem endereços,
-- (em aplicativos como Ifood, por exemplo, você cadastra o seu endereço apenas após a primeira entrega),
-- eu decidi deixar a tabela ENDERECOS dependente da tabela CLIENTES, e não o contrário,
-- caso seja extritamente necessário a adição de um endereço durante o cadastro de um cliente, é possível fazer isso a nível de aplicação,
-- (assim como impedir que o telefone contenha números, por exemplo).
CREATE TABLE AtividadeSomativa.ENDERECOS(
	CodEndereco INT AUTO_INCREMENT,
	Logradouro VARCHAR(80) NOT NULL,
	Numero INT NOT NULL,
	Bairro VARCHAR(45) NOT NULL,
	Municipio VARCHAR(60) NOT NULL,
	UF CHAR(2) NOT NULL,
    CEP CHAR(9) NOT NULL,
    Complemento VARCHAR(100),
    CodCliente INT NOT NULL,
    FOREIGN KEY (CodCliente) REFERENCES AtividadeSomativa.CLIENTES(CodCliente),
    primary key (CodEndereco, CodCliente)
);

CREATE TABLE AtividadeSomativa.TELEFONES(
	CodCliente INT NOT NULL,
	TelefoneCliente CHAR(14) UNIQUE,
	FOREIGN KEY (CodCliente) REFERENCES AtividadeSomativa.CLIENTES(CodCliente)
);

CREATE TABLE AtividadeSomativa.PEDIDOS(
	CodPedido INT AUTO_INCREMENT PRIMARY KEY,
	DataEmissao TIMESTAMP NOT NULL,
	CodEntregador SMALLINT NOT NULL,
    CodEndereco INT NOT NULL,
    StatusPedido TINYINT NOT NULL,
	FOREIGN KEY (CodEntregador) REFERENCES AtividadeSomativa.ENTREGADORES(CodEntregador),
    FOREIGN KEY (CodEndereco) REFERENCES AtividadeSomativa.ENDERECOS(CodEndereco)
);

CREATE TABLE AtividadeSomativa.ITENS(
	CodPedido INT NOT NULL,
	CodSanduiche INT NOT NULL,
	Quantidade TINYINT NOT NULL,
	FOREIGN KEY (CodPedido) REFERENCES AtividadeSomativa.PEDIDOS(CodPedido),
    FOREIGN KEY (CodSanduiche) REFERENCES AtividadeSomativa.SANDUICHES(CodSanduiche),
	primary key (CodPedido, CodSanduiche) -- Isso impede que haja duplicatas de sanduiches em um mesmo pedido
);

INSERT INTO AtividadeSomativa.SANDUICHES VALUES
	(1,"CAPRESE", 15.00),
	(2,"QUEIJO-QUENTE", 7.00),
    (3,"MISTO QUENTE", 8.00),
    (4,"X-BURGUER", 9.00),
    (5,"X-BACON", 14.00),
    (6,"X-SALADA", 12.00),
    (7,"X-TUDO", 15.00),
    (8,"SANDUICHE NATURAL", 8.00),
    (9,"PARMA", 15.00),
    (10,"BAURU", 8.50);

INSERT INTO AtividadeSomativa.ENTREGADORES VALUES
	(1,"Gabriel da Silva", "41997651321"),
	(2,"Juliana Montenegro", "41997652321"),
    (3,"Pedro Rodrigues Lopes", "41997651323"),
    (4,"Carlos Noronha Junior", "41997651421"),
    (5,"André Santos Durat", "41997651325");

INSERT INTO AtividadeSomativa.CLIENTES VALUES
	(1, "Antônio Oliveira"),
	(2, "Maria Silva"),
	(3, "João Pereira"),
	(4, "Fernanda Rodrigues"),
	(5, "Carlos Almeida"),
	(6, "Isabela Souza"),
	(7, "Lucas Cardoso"),
	(8, "Gabriela Ferreira"),
	(9, "Rafael Martins"),
	(10, "Beatriz Costa"),
	(11, "Matheus Moreira"),
	(12, "Letícia Dias"),
	(13, "Gustavo Oliveira da Costa Silva Cardoso"),
	(14, "Juliana Gomes"),
	(15, "Pedro Melo"),
	(16, "Larissa Barros"),
	(17, "Vitor Lopes"),
	(18, "Camila Nunes"),
	(19, "Eduardo Farias"),
	(20, "Mariana Oliveira da Costa Silva Cardoso");
    
INSERT INTO AtividadeSomativa.ENDERECOS VALUES
 	(1, "Rua das Flores", 100, "Centro", "Curitiba", "PR", "80000-000", null, 1),
    (2, "Avenida Batel", 456, "Batel", "Curitiba", "PR", "80420-000","Ao lado da casa verde, Ed. Castellani Apto 303", 2), -- teste: mesmo CEP que o cliente 12
    (3, "Rua Mateus Leme", 2345, "São Lourenço", "Curitiba", "PR", "80530-000", null, 3),
    (4, "Rua XV de Novembro", 789, "Alto da Glória", "Curitiba", "PR", "80045-000","Em frente à borracharia", 4),
    (5, "Avenida Sete de Setembro", 1234, "Rebouças", "Curitiba", "PR", "80230-000", "Próximo à Boca Maldita", 5),
    (6, "Rua Barão do Serro Azul", 567, "Centro Cívico", "Curitiba", "PR", "80530-000","Próximo ao Jardim Botânico de Curitiba", 6),
    (7, "Rua Carlos de Carvalho", 678, "Mercês", "Curitiba", "PR", "80440-000", null, 7),
    (8, "Avenida República Argentina", 876, "Água Verde", "Curitiba", "PR", "80620-000", null, 8),
    (9, "Rua Fernando Amaro", 432, "Alto da XV", "Curitiba", "PR", "80045-000", null, 9),
    (10, "Rua Engenheiro Rebouças", 345, "Jardim Botânico", "Curitiba", "PR", "80210-000", "Ao lado do Museu Oscar Niemeyer", 10),
    (11, "Rua Professor Brandão", 987, "Juvevê", "Curitiba", "PR", "80030-000", "Em frente ao Hospital IPO", 11),
    (12, "Avenida Batel", 456, "Batel", "Curitiba", "PR", "80420-000","Ed. Castellani Apto 505", 12), -- teste: mesmo CEP que o cliente 2
    (13, "Rua Desembargador Motta", 456, "Bigorrilho", "Curitiba", "PR", "80730-000","Casa com portão amarelo", 13), -- teste: mesmo ENDEREÇO que o cliente 20
    (14, "Rua Martim Afonso", 654, "Champagnat", "Curitiba", "PR", "80730-000","Em frente à Faculdade FAE", 15),
    (15, "Avenida Silva Jardim", 1500, "Rebouças", "Curitiba", "PR", "80230-000", null, 15),
    (16, "Rua Saldanha Marinho", 321, "São Francisco", "Curitiba", "PR", "80510-000", "Próximo à Igreja do Rosário", 16),
    (17, "Rua Padre Anchieta", 999, "Santa Felicidade", "Curitiba", "PR", "82030-000", null, 17),
    (18, "Rua Brasílio Itiberê", 543, "Parolin", "Curitiba", "PR", "80220-000", null, 18),
    (19, "Rua Voluntários da Pátria", 3456, "Centro", "Curitiba", "PR", "80020-000", null, 19),
    (20, "Rua Desembargador Motta", 456, "Bigorrilho", "Curitiba", "PR", "80730-000","Casa com portão amarelo", 20), -- teste: mesmo ENDEREÇO que o cliente 13
    (21, "Rua Pindamanhangaba", 42069, "Cristo Rei", "Curitiba", "PR", "80070-280", null, 19); -- teste: CLIENTE 19 cadastrou mais de um ENDEREÇO
    
INSERT INTO AtividadeSomativa.TELEFONES VALUES
	(1, "(41)99912-3456"),
    (3, "(41)99823-4567"),
    (3, "(41)99734-5678"),
    (3, "(41)99645-6789"),
    (3, "(41)99556-7890"), -- teste: CLIENTE 3 cadastrou 4 TELEFONES diferentes, CLIENTES 2 4 e 5 não cadastraram TELEFONES
    (6, "(41)99467-8901"),
    (7, "(41)99378-9012"),
    (8, "(41)99289-0123"),
    (9, "(41)99190-1234"),
    (10, "(41)99001-2345"),
    (11, "(41)98812-3456"),
    (12, "(41)98723-4567"),
    (13, "(41)98634-5678"),
    (14, "(41)98545-6789"),
    (15, "(41)98456-7890"),
    (16, "(41)98367-8901"),
    (17, "(41)98278-9012"),
    (18, "(41)98189-0123"),
    (19, "(41)98090-1234"),
    (20, "(41)97901-2345");
    
INSERT INTO AtividadeSomativa.PEDIDOS VALUES
	(1, '2024-08-01 09:18:31', 4, 12, 2),
	(2, '2024-08-02 09:26:12', 3, 3, 2),
    (3, '2024-08-04 09:28:15', 1, 17, 2),
	(4, '2024-08-07 10:04:10', 4, 10, 2),
	(5, '2024-08-08 10:08:59', 5, 15, 2),
    (6, '2024-08-11 16:44:35', 1, 10, 2),
    (7, '2024-08-12 10:27:36', 3, 10, 2),
    (8, '2024-08-13 11:15:43', 2, 3, 2),
	(9, '2024-08-14 11:27:20', 3, 13, 2),
	(10, '2024-08-14 11:34:16', 3, 7, 2),
	(11, '2024-08-15 11:27:06', 1, 1, 2),
    (12, '2024-08-15 11:27:32', 1, 7, 2),
	(13, '2024-08-16 12:47:35', 5, 16, 2),
    (14, '2024-08-17 13:02:04', 4, 13, 2),
	(15, '2024-08-17 13:05:59', 4, 8, 2),
	(16, '2024-08-18 09:18:53', 4, 2, 2),
    (17, '2024-08-20 09:26:42', 3, 13, 2),
	(18, '2024-08-21 09:26:21', 3, 7, 2),
    (19, '2024-08-21 22:00:40', 3, 20, 2),
	(20, '2024-09-15 09:18:14', 1, 9, 2),
    (21, '2024-09-15 09:18:22', 4, 19, 2),
    (22, '2024-09-15 09:18:49', 3, 16, 2),
    (23, '2024-09-15 10:04:38', 2, 13, 2),
    (24, '2024-09-15 10:08:53', 2, 3, 2),
    (25, '2024-09-15 11:54:15', 5, 17, 2),
    (26, '2024-09-15 12:06:03', 2, 5, 2),
    (27, '2024-09-15 12:25:19', 3, 6, 2),
    (28, '2024-09-15 12:47:25', 3, 7, 2),
    (29, '2024-09-15 13:37:37', 2, 1, 2),
    (30, '2024-09-15 20:04:07', 4, 20, 2),
    (31, '2024-09-15 20:04:07', 2, 19, 2),
    (32, '2024-09-15 20:04:29', 1, 21, 1),
    (33, '2024-09-15 20:04:38', 3, 5, 1),
    (34, '2024-09-15 20:35:10', 1, 3, 2),
    (35, '2024-09-15 20:54:39', 5, 6, 0),
    (36, '2024-09-15 21:35:39', 5, 10, 1),
    (37, '2024-09-15 21:40:55', 3, 4, 0),
    (38, '2024-09-15 21:46:36', 1, 11, 0),
    (39, '2024-09-15 21:51:19', 3, 16, 0),
    (40, '2024-09-15 22:00:19', 4, 8, 1);

INSERT INTO AtividadeSomativa.ITENS VALUES
	(1, 7, 2),
    (2, 10, 1),
    (3, 4, 1),
    (4, 6, 2),
    (4, 9, 1),
    (4, 7, 3),
    (5, 8, 1),
    (6, 1, 1),
    (7, 5, 4),
    (8, 4, 1),
    (9, 6, 1),
    (9, 7, 1),
    (10, 10, 1),
    (11, 4, 1),
    (12, 8, 2),
    (13, 3, 1),
    (14, 7, 3),
    (15, 6, 1),
    (16, 1, 1),
    (17, 1, 2),
    (18, 2, 1),
    (19, 2, 2),
    (20, 2, 1),
    (21, 7, 2),
    (22, 10, 1),
    (23, 7, 1),
    (23, 10, 1),
    (24, 6, 2),
    (24, 9, 1),
    (24, 8, 3),
    (25, 8, 1),
    (26, 1, 1),
    (27, 5, 4),
    (28, 4, 1),
    (29, 6, 1),
    (30, 10, 1),
    (30, 7, 1),
    (31, 4, 1),
    (32, 8, 2),
    (33, 3, 1),
    (34, 7, 3),
    (35, 6, 1),
    (36, 1, 1),
    (37, 1, 2),
    (38, 2, 1),
    (39, 2, 1),
    (40, 2, 1);