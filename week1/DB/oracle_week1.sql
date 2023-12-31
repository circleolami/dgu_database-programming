DROP TABLE INVOICE_ITEM CASCADE CONSTRAINTS PURGE;
DROP TABLE INVOICE CASCADE CONSTRAINTS PURGE;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS PURGE;

spool C:\Users\circl\Documents\2023-2\database_programming\week1\oracle_week1.txt;

CREATE TABLE CUSTOMER(
	CustomerID INT PRIMARY KEY NOT NULL,
	FirstName CHAR(25) NOT NULL,
	LastName CHAR(25) NOT NULL,
	Phone CHAR(12),
	Email VARCHAR2(100)
);

INSERT INTO CUSTOMER VALUES(1, 'Nikki', 'Kaccaton','723-543-1233', 'Nikki.Kaccaton@somewhere.com');
INSERT INTO CUSTOMER VALUES(2, 'Brenda', 'Catnazaro','723-543-2344', 'Brenda.Catnazaro@somewhere.com');
INSERT INTO CUSTOMER VALUES(3, 'Bruce', 'LeCat', '723-543-3455', 'Bruce.LeCat@somewhere.com');
INSERT INTO CUSTOMER VALUES(4, 'Betsy', 'Miller', '725-654-3211', 'Betsy.Miller@somewhere.com');
INSERT INTO CUSTOMER VALUES(5, 'George', 'Miller', '725-654-4322', 'George.Miller@somewhere.com');
INSERT INTO CUSTOMER VALUES(6, 'Kathy', 'Miller', '723-514-9877', 'Kathy.Miller@somewhere.com');
INSERT INTO CUSTOMER VALUES(7, 'Betsy', 'Miller', '723-514-8766', 'Betsy.Miller@elsewhere.com');

CREATE TABLE INVOICE(
	InvoiceNumber INT PRIMARY KEY NOT NULL,
	CustomerNumber INT NOT NULL REFERENCES CUSTOMER(CustomerID),
	DateIn Date NOT NULL,
	DateOut Date,
	TotalAmount NUMBER(8,2)
);

INSERT INTO INVOICE VALUES(2015001, 1, TO_DATE('20041015','YYYYMMDD'), TO_DATE('20061015','YYYYMMDD'), 158.50);
INSERT INTO INVOICE VALUES(2015002, 2, TO_DATE('20041015','YYYYMMDD'), TO_DATE('20061015','YYYYMMDD'), 25.00);
INSERT INTO INVOICE VALUES(2015003, 1, TO_DATE('20061015','YYYYMMDD'), TO_DATE('20081015','YYYYMMDD'), 49.00);
INSERT INTO INVOICE VALUES(2015004, 4, TO_DATE('20061015','YYYYMMDD'), TO_DATE('20081015','YYYYMMDD'), 17.50);
INSERT INTO INVOICE VALUES(2015005, 6, TO_DATE('20071015','YYYYMMDD'), TO_DATE('20111015','YYYYMMDD'), 12.00);
INSERT INTO INVOICE VALUES(2015006, 3, TO_DATE('20111015','YYYYMMDD'), TO_DATE('20131015','YYYYMMDD'), 152.50);
INSERT INTO INVOICE VALUES(2015007, 3, TO_DATE('20111015','YYYYMMDD'), TO_DATE('20131015','YYYYMMDD'), 7.00);
INSERT INTO INVOICE VALUES(2015008, 7, TO_DATE('20121015','YYYYMMDD'), TO_DATE('20141015','YYYYMMDD'), 140.50);
INSERT INTO INVOICE VALUES(2015009, 5, TO_DATE('20121015','YYYYMMDD'), TO_DATE('20141015','YYYYMMDD'), 27.00);

CREATE TABLE INVOICE_ITEM(
	InvoiceNumber INT REFERENCES INVOICE(InvoiceNumber) NOT NULL,
	ItemNumber INT NOT NULL,
	Item CHAR(50) NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice NUMBER(8,2) NOT NULL,
	CONSTRAINT Invoice_item_PK PRIMARY KEY(InvoiceNumber, ItemNumber)
);

INSERT INTO INVOICE_ITEM VALUES(2015001, 1, 'Blouse', 2, 3.50);
INSERT INTO INVOICE_ITEM VALUES(2015001, 2, 'Dress Shirt', 5, 2.50);
INSERT INTO INVOICE_ITEM VALUES(2015001, 3, 'Formal Gown', 2, 10.00);
INSERT INTO INVOICE_ITEM VALUES(2015001, 4, 'Slacks-Mens', 10, 5.00);
INSERT INTO INVOICE_ITEM VALUES(2015001, 5, 'Slacks-Womens', 10, 6.00);
INSERT INTO INVOICE_ITEM VALUES(2015001, 6, 'Suit-Mens', 1, 9.00);
INSERT INTO INVOICE_ITEM VALUES(2015002, 1, 'Dress Shirt', 10, 2.50);
INSERT INTO INVOICE_ITEM VALUES(2015003, 1, 'Slacks-Mens', 5, 5.00);
INSERT INTO INVOICE_ITEM VALUES(2015003, 2, 'Slacks-Womens', 4, 6.00);
INSERT INTO INVOICE_ITEM VALUES(2015004, 1, 'Dress Shirt', 7, 2.50);
INSERT INTO INVOICE_ITEM VALUES(2015005, 1, 'Blouse', 2, 3.50);
INSERT INTO INVOICE_ITEM VALUES(2015005, 2, 'Dress Shirt', 2, 2.50);
INSERT INTO INVOICE_ITEM VALUES(2015006, 1, 'Blouse', 5, 3.50);
INSERT INTO INVOICE_ITEM VALUES(2015006, 2, 'Dress Shirt', 10, 2.50);
INSERT INTO INVOICE_ITEM VALUES(2015006, 3, 'Slacks-Mens', 10, 5.00);
INSERT INTO INVOICE_ITEM VALUES(2015006, 4, 'Slacks-Womens', 10, 6.00);
INSERT INTO INVOICE_ITEM VALUES(2015007, 1, 'Blouse', 2, 3.50);
INSERT INTO INVOICE_ITEM VALUES(2015008, 1, 'Blouse', 3, 3.50);
INSERT INTO INVOICE_ITEM VALUES(2015008, 2, 'Dress Shirt', 12, 2.50);
INSERT INTO INVOICE_ITEM VALUES(2015008, 3, 'Slacks-Mens', 8, 5.00);
INSERT INTO INVOICE_ITEM VALUES(2015008, 4, 'Slacks-Womens', 10, 6.00);
INSERT INTO INVOICE_ITEM VALUES(2015009, 1, 'Suit-Mens', 3, 9.00);
COMMIT;

SELECT * FROM TAB;
DESC CUSTOMER;
SELECT * FROM CUSTOMER;
DESC INVOICE;
SELECT * FROM INVOICE;
DESC INVOICE_ITEM;
SELECT * FROM INVOICE_ITEM;

-- Q1. 
SELECT INVOICE.DateIn, INVOICE.DateOut, CUSTOMER.Phone
FROM INVOICE JOIN CUSTOMER ON INVOICE.CustomerNumber = CUSTOMER.CustomerID
WHERE INVOICE.TotalAmount >= 100.00;

-- Q2. 
SELECT FirstName, Phone
FROM CUSTOMER
WHERE FirstName LIKE 'B%';

-- Q3. 
SELECT MAX(TotalAmount), MIN(TotalAmount), AVG(TotalAmount) FROM INVOICE;

-- Q4. 
SELECT FirstName, LastName, Phone
FROM CUSTOMER
WHERE CustomerID IN (
	SELECT INVOICE.CustomerNumber
	FROM INVOICE
	WHERE INVOICE.TotalAmount >= 100.00
)
ORDER BY LastName ASC, FirstName DESC;

-- Q5. 
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
FROM CUSTOMER
INNER JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerNumber
WHERE INVOICE.TotalAmount >= 100.00
ORDER BY CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

-- Q6. 
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
FROM CUSTOMER JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerNumber
WHERE INVOICE.TotalAmount >= 100.00
ORDERBY CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

-- Q7. 
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
FROM CUSTOMER
WHERE CUSTOMER.CustomerID IN (
	SELECT DISTINCT INVOICE.CustomerNumber
	FROM INVOICE_ITEM
	INNER JOIN INVOICE ON INVOICE_ITEM.InvoiceNumber = INVOICE.InvoiceNumber
	WHERE INVOICE_ITEM.Item = 'Dress Shirt'
)
ORDER BY CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

-- Q8. 
SELECT DISTINCT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerNumber
JOIN INVOICE_ITEM ON INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber
WHERE INVOICE_ITEM.Item = 'Dress Shirt'
ORDER BY CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

-- Q9. 
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerNumber
JOIN INVOICE_ITEM ON INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber AND INVOICE_ITEM.Item = 'Dress Shirt'
ORDER BY CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

-- Q10. 
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
FROM CUSTOMER
JOIN (
    SELECT DISTINCT INVOICE.CustomerNumber
    FROM INVOICE
    JOIN INVOICE_ITEM ON INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber
    WHERE INVOICE_ITEM.Item = 'Dress Shirt'
) Subquery
ON CUSTOMER.CustomerID = Subquery.CustomerNumber
ORDER BY CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

-- Q11. 
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone, SUM(INVOICE.TotalAmount) AS TotalAmount
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerNumber
JOIN INVOICE_ITEM ON INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber
WHERE INVOICE_ITEM.Item = 'Dress Shirt'
GROUP BY CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.Phone
ORDER BY TotalAmount ASC, CUSTOMER.LastName ASC, CUSTOMER.FirstName DESC;

spool off;
