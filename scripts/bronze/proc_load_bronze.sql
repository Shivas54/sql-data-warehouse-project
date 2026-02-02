/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create or alter procedure bronze.load_bronze as
BEGIN
	declare @start_time DATETIME , @end_time DATETIME;
	BEGIN TRY 
	print '==============================================';
	print 'load bronze layer';
	print '==============================================';

	print '-----------------------------------------------';
	print'loading CRM tables ';
	print '-----------------------------------------------';

	set @start_time=GETDATE();	
	print '>> Truncating Table: bronze.crm_cust_info';
	truncate table bronze.crm_cust.info;

	print '>> Inserting Table into : bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time=GETDATE();

	print'>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + 'secounds';
	print'>> --------------';

	print '>> Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;
	
	SET @start_time=GETDATE();
	print '>> Inserting Table: bronze.prd_cust_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time=GETDATE();
	print'>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + 'secounds';
	print'>> --------------';
	print '>> Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE datawarehouse.bronze.crm_sales_details;
	SET @start_time=GETDATE();

	print '>> Inserting Table: bronze.crm_sales_details';
	BULK INSERT datawarehouse.bronze.crm_sales_details
	FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time=GETDATE();
	print'>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + 'secounds';
	print'>> --------------';

	print '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE datawarehouse.bronze.erp_loc_a101;
	
	print '-----------------------------------------------';
	print'loading ERP tables ';
	print '-----------------------------------------------';

	SET @start_TIME=GETDATE();
	print '>> Inserting Table: bronze.erp_loc_a101';
	BULK INSERT datawarehouse.bronze.erp_loc_a101

	FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\datasets\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time=GETDATE();
	print'>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + 'secounds';
	print'>> --------------';
	
	print '>> Truncating Table: bronze.erp_cust_az12';

	TRUNCATE TABLE bronze.erp_cust_az12;
	SET @start_time=GETDATE();

	print '>> Truncating Table: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\datasets\source_erp\cust_az12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time=GETDATE();
	print'>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + 'secounds';
	print'>> --------------';	
	print '>> Truncating Table: bronze.erp_px_cat_g1v2'
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	SET @start_time=GETDATE();
	print '>> Inserting Table: bronze.erp_px_cat_g1v2'
	
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	set @end_time=GETDATE();
	print'>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + 'secounds';
	print'>> --------------';
	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE '+ ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE '+ CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT 'ERROR MESSAGE '+ CAST(ERROR_STATE() AS VARCHAR);
		PRINT '========================================='
	END CATCH
END
