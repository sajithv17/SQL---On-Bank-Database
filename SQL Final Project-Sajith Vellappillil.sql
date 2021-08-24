/* Project */
/* ## MS-SQL PROJECT on Bank Database Design by Sajith Vellappillil ! */

-- PHASE I of project begins 

--Q1. Create a database for a banking application called 'Bank'. 

create database Bank
use bank
go

--Create table UserLogins

Create table UserLogins
(UserLoginID smallint primary key,
UserLogin char(15) not null,
UserPassword varchar(20)not null)
go

--Create table UserSecurityQuestions

create table UserSecurityQuestions
(UserSecurityQuestionID tinyint primary key,
UserSecurityQuestion varchar(50)not null)
go

--Create table AccountType

Create table AccountType
(AccountTypeID tinyint Primary key,
AccountTypeDescription varchar(30))
go

--Create table SavingsInterestRates

create table SavingsInterestRates
(InterestSavingsRateID tinyint primary key,
InterestRateValue numeric(9,9) not null unique,
InterestRateDescription varchar(20))
go

--Create table AccountStatusType

Create table AccountStatusType
(AccountStatusTypeID tinyint Primary key,
AccountStatusDescription varchar(30))
go

--Create table Employee

Create Table Employee
(EmployeeID int primary key,
EmployeeFirstName varchar(25)not null,
EmployeeMiddleInitial char(1),
EmployeeLastName varchar(25)not null,
EmployeesManager bit)
go

--Create table TransactionType

Create table TransactionType
(TransactionTypeID tinyint Primary key,
TransactionTypeName char(10)not null,
TransactionTypeDescription varchar(50) not null,
TransactionFeeAmount smallmoney not null)
go

--Create table FailedTransactionErrorType

create table FailedTransactionErrorType
(FailedTransactionErrorTypeID tinyint Primary key,
FailedTransactionDescription varchar(50) not null)
go

--Create table LoginErrorLog

Create table LoginErrorLog
(ErrorLogID int Primary key,
ErrorTime datetime not null,
FailedTransactionXML xml not null)
go

--Create table UserSecurityAnswers

create table UserSecurityAnswers
(UserLoginID smallint Primary key foreign key references UserLogins(UserLoginID),
UserSecurityAnswer varchar(25)not null,
UserSecurityQuestionID tinyint not null foreign key references UserSecurityQuestions (UserSecurityQuestionID))
go

--Create table Account 

Create table Account
(AccountID int Primary key,
CurrentBalance int not null ,
AccountTypeID tinyint not null foreign key references AccountType(AccountTypeID),
AccountStatusTypeID tinyint not null foreign key references AccountStatusType(AccountStatusTypeID),
InterestSavingsRateID tinyint not null foreign key references SavingsInterestRates(InterestSavingsRateID))
go


alter table Account
alter column currentbalance money not null 
go

select * from account


create table "Login-Account"
(UserLoginID smallint not null foreign key references UserLogins(UserLoginID),
AccountID int not null foreign key references Account(AccountID))
go



create table OverDraftLog
(AccountID int primary key foreign key references Account(AccountID),
OverDraftDate datetime not null,
OverDraftAmount money not null,
OverDraftTransactionXML xml not null)
go

create table FailedTransactionLog
(FailedTransactionID int primary key,
FailedTransactionErrorTypeID tinyint not null foreign key references FailedTransactionErrorType(FailedTransactionErrorTypeID),
FailedTransactionErrorTime datetime not null,
FailedTransactionXML xml not null)
go

create table Customer
(CustomerID int Primary key,
AccountID int not null foreign key references Account(AccountID),
CustomerAddress1 varchar(30)not null,
CustomerAddress2 varchar(30),
CustomerFirstName Varchar(30) not null,
CustomerMiddleInitial char(1),
CustomerLastName varchar(30) not null,
City varchar(20)not null,
State Char(2) not null,
ZipCode char(10)not null,
EmailAddress varchar(40)not null,
HomePhone char(10),
CellPhone char(10) not null unique,
WorkPhone char(10),
SSN char(9)not null unique,
UserLoginID smallint not null foreign key references UserLogins(UserLoginID))
go

create table "Customer-Account"
(AccountID int not null foreign key references Account (AccountID),
CustomerID int not null unique foreign key references Customer (CustomerID))
go

create table TransactionLog
(TransactionID int primary key,
TransactionDate datetime not null,
TransactionTypeID tinyint not null foreign key references TransactionType(TransactionTypeID),
TransactionAmount money not null,
NewBalance money not null,
AccountID int not null foreign key references Account(AccountID),
CustomerID int not null foreign key references Customer(CustomerID),
EmployeeID int not null foreign key references Employee(EmployeeID),
UserLoginID smallint not null foreign key references UserLogins(UserLoginID))
go

insert into UserLogins(UserLoginID, UserLogin, UserPassword)
values (1234,'AlexA','Alex1'),
(6789,'MiaC','Mia2'),
(2345,'RubyD','Ruby3'),
(7890,'DaveH','Dave4'),
(1010,'HanaH','Hana5'),
(3128,'SamT','Sam6')
go


insert into UserSecurityQuestions(UserSecurityQuestionID,UserSecurityQuestion)
values (101,'Favourite Colour?'),
(102,'First Car?'),
(103,'Pets Name?'),
(104,'Favourite Sport?'),
(105,'Favourite Country?'),
(106,'Favourite City?')
go

select * from UserSecurityQuestions

insert into UserSecurityAnswers(UserLoginID,UserSecurityAnswer,UserSecurityQuestionID)
values (1234,'Black',101),
(6789,'Benz',102),
(2345,'Tomy',103),
(7890,'Cricket',104),
(1010,'Canada',105),
(3128,'Toronto',106)
go

select * from UserSecurityAnswers

insert into AccountType(AccountTypeID,AccountTypeDescription)
values (11,'Checking Account'),
(22,'Savings Account')
go

Select * from AccountType

insert into AccountStatusType(AccountStatusTypeID,AccountStatusDescription)
values (200,'Active'),
(201,'Inactive')
go

insert into SavingsInterestRates(InterestSavingsRateID,InterestRateValue,InterestRateDescription)
values (95,'0.7','Competitive'),
(92,'0.2','Lowest'),
(94,'0.3','Fair'),
(93,'0.5','Average'),
(96,'0.9','Highest')
go

insert into SavingsInterestRates(InterestSavingsRateID,InterestRateValue,InterestRateDescription)
values (97,'0.0','Checking Account')
go

select * from SavingsInterestRates


insert into Account(AccountID,CurrentBalance,AccountTypeID,AccountStatusTypeID,InterestSavingsRateID)
values (1001067211,5500,22,200,93),
(1001078516,0,22,200,92),
(1001042382,6120,22,200,95),
(1001031985,8000,11,200,97),
(1001074102,-250,11,201,97)
go

select * from Account
go

insert into "Login-Account"(UserLoginID,AccountID)
Values (1234,1001067211),
(6789,1001078516),
(2345,1001042382),
(7890,1001031985),
(1010,1001031985),
(3128,1001074102)
go

select * from [dbo].[Login-Account]

Insert into OverDraftLog(AccountID,OverDraftDate,OverDraftAmount,OverDraftTransactionXML)
values (1001074102,'20-Jan-2020 11:15:00.245',230,'4102-ST-20Dec18')
go

select * from OverDraftLog

Insert into [dbo].[FailedTransactionErrorType](FailedTransactionErrorTypeID,FailedTransactionDescription)
values (51,'Insufficient Balance'),
(52,'Limit Exceeded'),
(53,'Bank Fraud Rule'),
(54,'System Error'),
(55,'Do not Honour')
go

select * from FailedTransactionErrorType
go


Insert into FailedTransactionLog(FailedTransactionID,FailedTransactionErrorTypeID,FailedTransactionErrorTime,FailedTransactionXML)
values (12221,51,'15-February-2020 13:15:30.027','FTL-12221-15FEB20'),
(12222,55,'23-April-2020 18:52:29.001','FTL-12222-23APR20'),
(12223,53,'4-August-2020 3:16:01:018','FTL-12223-4AUG20'),
(12224,54,'21-October-2020 11:03:00.010','FTL-12224-21OCT20'),
(12225,51,'1-November-2020 9:00:55.013','FTL-12225-1NOV20')
go

Select * from FailedTransactionLog

Insert into LoginErrorLog(ErrorLogID,ErrorTime,FailedTransactionXML)
values (611,'01-Oct-2020 14:15:12.023','LEL-611-01OCT20'),
(612,'04-Oct-2020 07:00:00.45','LEL-612-04OCT20'),
(613,'22-Dec-2020 23:22:58.473','LEL-613-15NOV20'),
(614,'28-Nov-20 22:00:01.45','LEL-614-28NOV20'),
(615,'12-Dec-20 21:03:45.10','LEL-615-12DEC20')
go

SELECT * FROM LoginErrorLog

insert into Employee(EmployeeID,EmployeeFirstName,EmployeeMiddleInitial,EmployeeLastName,EmployeesManager)
values (14121,'Rose','B','Katz',0),
(14122,'Eve','G','Hart',0),
(14123,'Jack','I','Francis',1),
(14124,'Max','K','Fox',0),
(14125,'Ruth','L','Hale',1)
go

SELECT * FROM Employee

insert into TransactionType(TransactionTypeID,TransactionTypeName,TransactionTypeDescription,TransactionFeeAmount)
Values (80,'ATM','Deposit or Withdraw funds using an ATM',$5),
(81,'Check','Withdraw funds by writing a paper check',$10),
(82,'ODCharges', 'Statement/Overdraft/Reactivation/other services',$20),
(83,'Transfer', 'Move funds from one account to another',$2),
(84,'Deposit', 'Cash Deposit OTC',$0),
(85,'Withdrawal','Cash Withdrawal OTC',$0),
(86,'POS','Store Purchase',$2.5),
(87, 'Interest','Interest on Savings Account',$0),
(88, 'ActCharges','Account reactivation charges',$0)
go

update TransactionType
set TransactionTypeDescription='Overdraft Charges'
where TransactionTypeID=82
go

select * from TransactionType

update TransactionType
set TransactionFeeAmount=$15
where TransactionTypeName='ActCharges'
go


select * from TransactionType
go

insert into Customer(CustomerID,AccountID,CustomerAddress1,CustomerAddress2,CustomerFirstName,CustomerMiddleInitial,CustomerLastName,City,State,ZipCode,EmailAddress,HomePhone,CellPhone,WorkPhone,SSN,UserLoginID)
values (6721101,1001067211,'16 Yonge Street','Unit 1003','Alex','V','Antony','Toronto','ON','A1B 2C3','alex@fakemail.com',9846844454,1203456789,9876543870,000330876,1234),
(7851601,1001078516,'10 Tessler Crescent','Unit 12','Mia','P','Chan','Halifax','NS','D4E 5F6','mia@testmail.com',9895945642,2034567891,8978574642,003487651,6789),
(4238201,1001042382,'230 Richmond Street','House 2112','Ruby','D','Donald','Vancouver','BC','G7H 8I9','ruby@dsmail.com',7695309321,3456789120,5643768051,009876387,2345),
(3198501,1001031985,'21 Charles Street','Home 78','Dave','F','Harvis','Calgary','AB','J1K 2L3','dave@testmail.com',3530732705,4567891023,5736962407,006786439,7890),
(3198502,1001031985,'21 Charles Street','Home 78','Hana','F','Harvis','Calgary','AB','J1K 2L3','hana@testmail.com',3530732705,5678901234,1264849637,001209567,1010),
(7410201,1001074102,'730 Bay','Unit 633','Sam','K','Thomas','Toronto','ON','P7Q 8R9','sam@fakemail.com',3520964841,6789012345,8547370972,024598385,3128)
go

select * from Customer

insert into [Customer-Account](AccountID,CustomerID)
values (1001067211,6721101),
(1001078516,7851601),
(1001042382,4238201),
(1001031985,3198501),
(1001031985,3198502),
(1001074102,7410201)
go

select * from [Customer-Account]

insert into TransactionLog(TransactionID,TransactionDate,TransactionTypeID,TransactionAmount,NewBalance,AccountID,CustomerID,EmployeeID,UserLoginID)
values (200201001,'01-Jan-2020 09:10:56.047',84,$9000,$9000,1001031985,3198501,14122,7890),
(200201002,'07-Jan-2020 10:46:39.247',84,$6000,$6000,1001042382,4238201,14121,2345),
(200201003,'12-Jan-2020 12:11:20.367',84,$6000,$6000,1001067211,6721101,14121,1234),
(200201004,'16-Jan-2020 14:25:13.357',84,$5000,$5000,1001074102,7410201,14124,3128),
(200201005,'18-Jan-2020 11:47:49.277',84,$1000,$1000,1001078516,7851601,14124,6789),
(200201006,'20-Jan-2020 11:15:00.247',86,-$5230,-$230,1001074102,7410201,14122,3128),
(200201007,'20-Jan-2020 12:11:34.140',82,-$20,-$250,1001074102,7410201,14123,3128),
(200201008,'30-Jan-2020 10:10:48.207',87,$21,$6021,1001042382,4238201,14122,2345),
(200201009,'30-Jan-2020 10:15:14.120',87,$15,$6015,1001067211,6721101,14124,1234),
(200201010,'30-Jan-2020 10:38:08.220',87,$01,$1001,1001078516,7851601,14121,6789),
(200201011,'02-July-2020 23:05:00.123',84,$99,$6120,1001042382,4238201,14122,2345),
(200201012,'05-July-2020 15:37:29.010',85,-$515,$5500,1001067211,6721101,14124,1234),
(200201013,'15-Aug-2020 22:00:45.233',85,-$1000,$8000,1001031985,3198502,14121,1010),
(200201014,'20-Sep-2020 14:50:03.110',85,-$986,15,1001078516,7851601,14121,6789),
(200201015,'31-Oct-2020 09:41:25.230',88,-$15,0,1001078516,7851601,14125,6789)
go

select * from TransactionLog

-----------PHASE 2


select * from Customer
Select * from Account
Select * from AccountType
go


Create view CheckingAccount_ON
as
select CustomerID,CustomerFirstName,CustomerLastName,AccountTypeDescription,State from Customer
join Account on Customer.AccountID=Account.AccountID
Join AccountType on Account.AccountTypeID=AccountType.AccountTypeID
where AccountTypeDescription='Checking Account' and State='ON'
go

Create view View_TotalAccountBal
as
select CustomerFirstName,CustomerLastName,CurrentBalance,InterestRateValue,(CurrentBalance*InterestRateValue/100/2) 
as InterestAmount,(CurrentBalance+CurrentBalance*InterestRateValue/100/2) 
as TotalAccountBalance from Account
inner Join SavingsInterestRates on Account.InterestSavingsRateID=SavingsInterestRates.InterestSavingsRateID
inner Join Customer on Customer.AccountID=Account.AccountID
Where CurrentBalance+CurrentBalance*InterestRateValue/100/2>5000
go

Select * from Account

go

Create view View_TotalAccounts
as
select CustomerID,CustomerFirstName,CustomerLastName,AccountTypeDescription, Count(Account.AccountTypeID) as TotalAccounts
from Customer
Join  Account on Account.AccountID = Customer.AccountID
join AccountType on Account.AccountTypeID = AccountType.AccountTypeID
group by  CustomerID,CustomerFirstName,CustomerLastName,AccountTypeDescription
go

Select * from customer

Create View View_AccountID_UsrPswd
as
Select Distinct CustomerID,UserLogins.UserLoginID,UserPassword
from TransactionLog
Join UserLogins on TransactionLog.UserLoginID=UserLogins.UserLoginID
Where Transactionlog.AccountID = 1001031985
go



Create View View_Customer_OD
as
Select CustomerID,CustomerFirstName,CustomerLastName,OverDraftAmount
from Customer
Join OverDraftLog on Customer.AccountID=OverDraftLog.AccountID
go


Create proc SP_Username
as
begin
		Update UserLogins set UserLogin= 'User_'+ UserLogin

end

exec SP_Username
go

select * from UserLogins
go




create proc spFullNameFromAccountId        
            @AccountID int,                
			                               
			@Fullname nvarchar(100) output
as
begin
  if (@AccountID in (select AccountID from Customer))
    begin
	   select @Fullname=c.customerFirstName+' '+c.customerMiddleInitial+' '+c.customerLastName
	   from customer C

   end
  else
   begin
    print 'This Account Id does not exists!'
   end
end
go

--Executing for valid account id
Declare @FullName nvarchar(100)
exec spFullNameFromAccountId 1001067211, @FullName out
Print ' Full name is '+replace (@FullName,'   ',' ')
go

--Executing for invalid account id
Declare @FullName nvarchar(100)
exec spFullNameFromAccountId 2999, @FullName out
Print ' Full name is '+@FullName
go

Create proc SP_LoginErrorLog
as
begin
		if exists (select * from LoginErrorLog where errortime between getdate()-1 and getdate())
					select * from LoginErrorLog where errortime between getdate()-1 and getdate()

else

		Print 'There is no LoginErrorLog in last 24hr'
End

exec SP_LoginErrorLog
go

Create Proc Deposit_CurrentBalance
			@AcctID int,@Deposit_Amt money
as 
Begin
		If (@AcctID in (Select AccountID from Account))
		Begin
			Select CurrentBalance as [Balance Before Deposit] from Account
			where AccountID=@AcctID
			Update Account
			Set CurrentBalance = CurrentBalance+@Deposit_Amt where AccountID=@AcctID
			Select CurrentBalance [Balance After Deposit] from Account where AccountID=@AcctID
			End
		Else
		Begin
			Print
			'AccountID does not exists'
		End
End


-- Executing with a valid AccountID

Exec Deposit_CurrentBalance 1001031985,500

-- Executing with invalid AccountID

Exec Deposit_CurrentBalance 1001031333,500

go

Create Proc Withdrawal_CurrentBalance
			@AcctID int,@Withdrawal_Amt money
as 
Begin
		If (@AcctID in (Select AccountID from Account))
		Begin
			Select CurrentBalance as [Balance Before Deposit] from Account
			where AccountID=@AcctID
			Update Account
			Set CurrentBalance = CurrentBalance-@Withdrawal_Amt where AccountID=@AcctID
			Select CurrentBalance [Balance After Deposit] from Account where AccountID=@AcctID
			End
		Else
		Begin
			Print
			'AccountID does not exist'
		End
End

-- Executing with a valid AccountID

Exec Withdrawal_CurrentBalance 1001067211,100

-- Executing with invalid AccountID

Exec Withdrawal_CurrentBalance 100106278,500
go


