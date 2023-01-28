DROP DATABASE IF EXISTS bookshelf;

CREATE DATABASE bookshelf;

USE bookshelf;

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(128) NOT NULL,
    lang VARCHAR(3) NOT NULL DEFAULT "ENG" CHECK(LENGTH(lang) = 3),
    pages INT CHECK(pages > 0),
    author_name VARCHAR(128),
    pub_date DATE
);

INSERT INTO books (book_id, title, lang, pages, author_name, pub_date)
VALUES ('1', 'The Prophet', 'ENG', '127', 'Jihad El', '2010-01-01'),
('2', 'After the Funeral', 'ENG', '251', 'Agatha Christie', '2001-07-02'),
('3', 'Rage of Angels', 'ENG', '512', 'Sidney Sheldon', '1999-08-03'),
('4', 'Sacrament', 'ENG', '594', 'Clive Barker', '1997-05-01'),
('5', 'The Little House', 'ENG', '368', 'Philippa Gregory', '1998-02-01'),
('6', 'Scandalous Risks', 'ENG', '480', 'Susan Howatch', '2009-07-22'),
('7', 'Zelda\'s Cut', 'ENG', '432', 'Philippa Gregory', '2001-02-01'),
('8', 'Spares', 'ENG', '317', 'Michael Marshall Smith', '1998-11-02'),
('9', 'The Wise Woman', 'ENG', '640', 'Philippa Gregory', '2002-02-01'),
('10', 'Ocean Star Express', 'ENG', '32', 'Mark Haddon', '2002-07-01'),
('11', 'Image-Music-Text', 'ENG', '220', 'Roland Barthes', '1993-09-13'),
('12', 'The Annotated Hobbit', 'ENG', '411', 'Douglas A. Anderson', '2003-04-07'),
('13', 'How to Be Alone', 'ENG', '306', 'Jonathan Franzen', '2007-07-02'),
('14', 'The Opposite of Fate', 'ENG', '398', 'Amy Tan', '2004-07-01'),
('15', 'Oh Say Can You Say?', 'ENG', '36', 'Dr. Seuss', '2005-11-01'),
('16', 'Microserfs', 'ENG', '371', 'Douglas Coupland', '2008-01-01'),
('17', 'Where Rainbows End', 'ENG', '454', 'Cecelia Ahern', '2004-11-08'),
('18', 'The Known World', 'ENG', '388', 'Kevin R. Free', '2004-10-01'),
('19', 'The Mandarins', 'ENG', '752', 'Leonard M. Friedman', '2005-05-03'),
('20', 'Angela\'s Ashes', 'ENG', '224', 'Frank McCourt', '1998-12-17'),
('21', 'The Song of Rhiannon', 'ENG', '208', 'Evangeline Walton', '1992-09-01'),
('22', 'Winter Cottage', 'ENG', '178', 'Carol Ryrie Brink', '1974-06-01'),
('23', 'Seaward', 'ENG', '167', 'Susan Cooper', '1987-04-30'),
('24', 'Reason in History', 'ENG', '95', 'Georg Wilhelm Friedrich Hegel', '1995-12-24'),
('25', 'El plan infinito', 'SPA', '336', 'Isabel Allende', '2002-05-14'),
('26', 'The Museum of Dr. Moses', 'ENG', '229', 'Joyce Carol Oates', '2007-08-06'),
('27', 'Purgatorio', 'ITA', '704', 'Dante Alighieri', '2004-04-08'),
('28', 'La chute', 'FRA', '152', 'Albert Camus', '1999-01-11'),
('29', 'Ve  perro ¡Ve!', 'SPA', '24', 'Adolfo Pérez Perdomo', '2003-02-25'),
('30', 'Boltzmon!', 'ENG', '160', 'William Sleator', '1999-09-01'),
('31', 'La Milla Verde', 'SPA', '448', 'María Eugenia Ciocchini Suárez', '2002-03-26'),
('32', 'La Dernière Leçon', 'FRA', '209', 'Mitch Albom', '2001-01-01'),
('33', 'Un nuevo amanecer', 'SPA', '560', 'Delia Mateovich', '2002-01-22'),
('34', 'Por los pelos', 'SPA', '592', 'Marian Keyes', '2002-09-17'),
('35', '11 de Septiembre', 'SPA', '144', 'Noam Chomsky', '2002-09-03'),
('36', 'Le Royaume fantôme', 'FRA', '251', 'Norton Juster', '2003-01-15'),
('37', 'Ecstasy', 'FRA', '358', 'Alain Defossé', '2000-06-10'),
('38', 'Adieu  Chunky Rice', 'SPA', '128', 'Craig Thompson', '2002-06-20'),
('39', 'Tiempo De Matar', 'SPA', '20', 'John Grisham', '2003-07-01'),
('40', 'El talismán', 'SPA', '375', 'Peter Straub', '2003-07-01'),
('41', 'Il genio dei numeri', 'ITA', '442', 'Carlo Capararo', '2002-02-01'),
('42', 'Piccole donne', 'ITA', '288', 'Jame\'s Prunier', '2001-04-15'),
('43', 'L\'albero', 'ITA', '62', 'Daniela Gamba', '2000-05-01'),
('44', 'La regina dei dannati', 'ITA', '507', 'Anne Rice', '1997-02-01');