create database bank;
use bank;

create table customer(
customerID int,
FirstName varchar(50),
LastName varchar(50),
Email varchar(100),
Phone varchar(15));

alter table customer add column dateofBirth date;
alter table customer modify phone varchar(20);
select * from customer;

create table accounts(
accountID int,
accountType varchar(20),
balance decimal(10,2));
select * from accounts;

create table transactions(
transactionID int,
transactionDate date,
Amount decimal(10,2),
transactionType varchar(20));
select * from transactions;

create table branches(
branchID int,
branchName varchar(100),
branchAddress varchar(200),
branchPhone varchar(15));
select * from branches;

create table loans(
loanID int primary key,
loanAmount decimal(10,2),
interestRate decimal(5,2),
startDate date,
endDate date);
select * from loans;

alter table branches add constraint primary key(branchID);
alter table transactions add constraint primary key(transactionID);
alter table accounts add constraint primary key(accountID);
alter table customer add constraint primary key(customerID);

alter table accounts add column branchID int;
alter table accounts add column customer_id int;
alter table accounts add constraint foreign key(customer_id) references customer(customerID);

alter table loans add column customer_id int;
alter table loans add constraint foreign key(customer_id) references customer(customerID);

alter table branches add column account_id int;
alter table branches add constraint foreign key(account_id) references accounts(accountID);

alter table transactions add column account_id int;
alter table transactions add constraint foreign key(account_id) references accounts(accountID);

insert into customer value(101,"Rahul","Sharma","rahul.sharma@gmail.com",9999999999,19980415);
insert into customer value(102,"Priya","Patil","priya@gmail.com",9988776655,20000920),
(103,"Amit","Patel","amit.patel@gmail.com",9876500001,19950618),
(104,"Sneha","Joshi","sneha.joshi@gmail.com",9876500002,19970912),
(105,"Rohan","Kulkarni","rohan.kulkarni@gmail.com",9876500003,19931125);

insert into loans value(301,50000.00,8.50,20250115,20300115,101),
(302,30000.00,9.25,20280210,20280210,102),(303,750000.00,8.75,20250320,20320320,103),(304,250000.00,10.00,20250405,20290405,104),(305,100000.00,7.95,20250512,20350512,105);

insert into Branches value(1, "Mumbai Branch", "Andheri Mumbai", 0221111111, default), (2, "Pune Branch", "Shivaji nagan Pune", 0202222222, default),
(3, "Nashik Branch", "College Road Nashik", 0253222222, default),
(4, "Magpur Branch", "Sitabuldi Nagpur", 0712333333, default),
(5, "Navs Mumbail Branch", "VashiNavi Mumbai", 0224444444, default);

insert into transactions value(301, 20250510,5000.00, "deposit", 201);
insert into transactions value(302, 20250511, 2500.00, "withdraw", 202),(303, 20250512,10000.00, "deposit", 203),
(304,20250513,3000.00, "withdraw", 204),(305, 20250514,7000.00, "deposit", 205);

insert into accounts value(201,"savings",25000.00,101,0),(202,"current",40000.00,102,0),(203,"savings",35000.00,103,0),
(204,"current",60000.00,104,0),(205,"savings",45000.00,105,0);

-- Q1
select a.accountID,a.accountType,a.balance,t.transactionID,transactionDate,t.transactionType,t.amount from accounts a
inner join transactions t
on a.accountID = t.account_id;

-- Q2
select a.accountID,a.accountType,a.balance,t.transactionID,transactionDate,t.transactionType,t.amount from accounts a
left join transactions t
on a.accountID = t.account_id;

-- Q3
select a.accountID,a.accountType,a.balance,t.transactionID,transactionDate,t.transactionType,t.amount from accounts a
inner join transactions t
on a.accountID = t.account_id
where t.transactionType ='deposit';

-- Q4
select a.accountID,a.accountType,a.balance,t.transactionID,transactionDate,t.transactionType,t.amount from accounts a
inner join transactions t
on a.accountID = t.account_id
where a.balance > 30000
order by a.balance desc;

-- LAB 9
select * from transactions
where amount >(select avg(amount) from transactions);

select * from accounts
where balance >(select avg(balance) from accounts)
order by balance desc;

select * from accounts
where accountID in (select accountID from transactions where transactionType ="deposit");

select * from accounts 
where balance =(select max(balance) from accounts);