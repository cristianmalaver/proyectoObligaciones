SELECT  pay_obligation_actual_cuote,pay_Date,pay_Dtf,pay_Ibr,pay_FixedRate,pay_value,pay_Dtf_points,pay_Ibr_points,pay_missing_cuotes,pay_interesting_value,pay_capital_value,

OI.obligation_id,OCOD.obligation_cod,OCOD.client_idmax,OCOD.client_name,OCOD.client_contract 
        FROM pay_obligation OI
        INNER JOIN obligation OCOD
        ON OI.obligation_id=OCOD.obligation_id
        WHERE OCOD.obligation_cod = 'fdgsdfg'
        ORDER BY pay_obligation_id ASC
