CREATE database if not exists MVCDB;

use MVCDB;

CREATE TABLE IF NOT EXISTS Customers (
	customerID 				INT				PRIMARY KEY 	AUTO_INCREMENT,
	customerUserName 		VARCHAR(20) 	NOT NULL,
	customerPassword 		VARCHAR(20) 	NOT NULL,
	customerFirstName 		VARCHAR(20) 	NOT NULL,
	customerLastName 		VARCHAR(20) 	NOT NULL,
	customerAddress 		VARCHAR(50) 	NOT NULL,
	customerCity 			VARCHAR(20) 	NOT NULL,
	customerPostalCode 		VARCHAR(6) 		NOT NULL
);

-- CSR: (Customer Service Representative) 
CREATE TABLE IF NOT EXISTS CSR (
	employeeID 				INT				PRIMARY KEY 	AUTO_INCREMENT,
	employeeUserName 		VARCHAR(20) 	NOT NULL,
	employeePassword 		VARCHAR(20) 	NOT NULL,
	employeeFirstName 		VARCHAR(20) 	NOT NULL,
	employeeLastName 		VARCHAR(20) 	NOT NULL,
	employeeAddress 		VARCHAR(50) 	NOT NULL,
	employeeCity 			VARCHAR(20) 	NOT NULL,
	employeePostalCode 		VARCHAR(6) 		NOT NULL
);

CREATE TABLE IF NOT EXISTS Shoes (
	itemId 			INT				PRIMARY KEY 	AUTO_INCREMENT,
	itemName 		VARCHAR(50) 	NOT NULL,
	category 		VARCHAR(20) 	NOT NULL check (category IN ('Kid', 'Women', 'Men')),
	shoeSize 		INT	   	    	NOT NULL check (shoeSize IN (1,2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)),
	price  			DECIMAL(9,2)	NOT NULL,
    quantity 		INT				NOT NULL,
    image			VARCHAR(100)	NOT NULL,
    description		VARCHAR(50)		
);

CREATE TABLE IF NOT EXISTS Orders (
	orderId 		INT				PRIMARY KEY 	AUTO_INCREMENT,
	customerId 		INT 			NOT NULL ,
	itemId 			INT 			NOT NULL ,
	orderDate 		DATE 			NOT NULL,
	quantity 		INT(50)			NOT NULL,
	status 			VARCHAR(50) 	NOT NULL check (status IN ('Order-Place', 'In-Process','Delivered' , 'Completed')),
	FOREIGN KEY (customerID) 		REFERENCES Customers(customerID),
	FOREIGN KEY (itemId) 			REFERENCES Shoes(itemId)
);



insert into Shoes (itemName, category, shoeSize, price, quantity, image, description) values
('Calvin Klein', 'Kid', 6, 52.32, 6,'images/Kid_Shoes/05-01.png', 'nice pink shoe'),
('Damani Dada', 'Men', 8, 53.32, 8, 'images/Men_Shoes/04-01.png', 'n'),
('ChenOne', 'Women', 3, 76.32,4, 'images/Women_Shoes/05-01.png', 'beautiful'),
('Atletica', 'Kid', 5, 56.32, 9, 'images/Kid_Shoes/01-01.png',  'nice pink shoe'),
('Caleres', 'Men', 7, 504.32, 7, 'images/Men_Shoes/01-01.png',  'n'),
('Caterpillar Inc.', 'Women', 10, 54.32, 7, 'images/Women_Shoes/03-01.png', 'beautiful');

Update Shoes set shoeSize = 10 where itemId = (Select itemId from Orders where orderId = 8);

insert into orders (customerId, itemId, orderDate, quantity, status) values
(2, 1, Curdate(), 1, 'Order-Place'),
(1, 2, curDate(), 3, 'Delivered' ),
(2, 3, curDate(), 3, 'In-Process' ),
(1, 1, curDate(), 3, 'Order-Place' ),
(2, 5, curDate(), 3, 'In-Process' ),
(1, 6, curDate(), 3, 'Completed' ),
(1, 4, curDate(), 3, 'Order-Place' );

update Shoes set itemName = 'edit', category = 'Men', shoeSize = 7, price = 56.7, quantity =6, image = 'images/Women_Shoes/05-01.png', description = 'edit product'
where itemId = 32;

select * from Customers;
select * from CSR;
select * from Shoes;
select * from orders;