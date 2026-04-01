CALL bronze.load_bronze();
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_end_time TIMESTAMP;
    v_duration INTERVAL;
BEGIN
    RAISE NOTICE '=========================';
    RAISE NOTICE '  loading bronze layer   ';
    RAISE NOTICE '=========================';

    -- CRM Tables
    RAISE NOTICE '-------------------------';
    RAISE NOTICE '  loading CRM tables   ';
    RAISE NOTICE '-------------------------';

    -- Load crm_cust_info
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> truncating table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    RAISE NOTICE '>> inserting data into: bronze.crm_cust_info';
    COPY bronze.crm_cust_info FROM '/var/lib/postgresql/datasets/source_crm/cust_info.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    v_end_time := clock_timestamp();
    v_duration := v_end_time - v_start_time;
    RAISE NOTICE '✓ bronze.crm_cust_info loaded in: %', v_duration;

    -- Load crm_prd_info
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> truncating table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    RAISE NOTICE '>> inserting data into: bronze.crm_prd_info';
    COPY bronze.crm_prd_info FROM '/var/lib/postgresql/datasets/source_crm/prd_info.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    v_end_time := clock_timestamp();
    v_duration := v_end_time - v_start_time;
    RAISE NOTICE '✓ bronze.crm_prd_info loaded in: %', v_duration;

    -- Load crm_sales_details
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> truncating table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    RAISE NOTICE '>> inserting data into: bronze.crm_sales_details';
    COPY bronze.crm_sales_details FROM '/var/lib/postgresql/datasets/source_crm/sales_details.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    v_end_time := clock_timestamp();
    v_duration := v_end_time - v_start_time;
    RAISE NOTICE '✓ bronze.crm_sales_details loaded in: %', v_duration;

    -- ERP Tables
    RAISE NOTICE '-------------------------';
    RAISE NOTICE '  loading ERP tables   ';
    RAISE NOTICE '-------------------------';

    -- Load erp_cust_az12
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> truncating table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    RAISE NOTICE '>> inserting data into: bronze.erp_cust_az12';
    COPY bronze.erp_cust_az12 FROM '/var/lib/postgresql/datasets/source_erp/CUST_AZ12.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    v_end_time := clock_timestamp();
    v_duration := v_end_time - v_start_time;
    RAISE NOTICE '✓ bronze.erp_cust_az12 loaded in: %', v_duration;

    -- Load erp_loc_a101
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> truncating table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    RAISE NOTICE '>> inserting data into: bronze.erp_loc_a101';
    COPY bronze.erp_loc_a101 FROM '/var/lib/postgresql/datasets/source_erp/LOC_A101.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    v_end_time := clock_timestamp();
    v_duration := v_end_time - v_start_time;
    RAISE NOTICE '✓ bronze.erp_loc_a101 loaded in: %', v_duration;

    -- Load erp_px_cat_g1v2
    v_start_time := clock_timestamp();
    RAISE NOTICE '>> truncating table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    RAISE NOTICE '>> inserting data into: bronze.erp_px_cat_g1v2';
    COPY bronze.erp_px_cat_g1v2 FROM '/var/lib/postgresql/datasets/source_erp/PX_CAT_G1V2.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    v_end_time := clock_timestamp();
    v_duration := v_end_time - v_start_time;
    RAISE NOTICE '✓ bronze.erp_px_cat_g1v2 loaded in: %', v_duration;

    RAISE NOTICE '=========================';
    RAISE NOTICE '  ✓ Bronze layer loaded!   ';
    RAISE NOTICE '=========================';

EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error loading bronze layer: %', SQLERRM;
END $$;
