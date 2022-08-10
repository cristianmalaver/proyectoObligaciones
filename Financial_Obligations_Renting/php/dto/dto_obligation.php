<?php 
#Author: cristian malaver
#Date: 30/10/2020
#Description : Is DTO obligation

class DtoObligation
{
    private $Bank_name;
    private $user;
    private $password;

    private $obligation_id;
    private $client_idmax;
    private $client_name;
    private $client_contract;
    private $Bank_id;
    private $credit_type_id;
    private $interesting_type_id;
    private $amortization_type_id;
    private $desembolso_date;
    private $initial_value;
    private $cuotes_number;
    private $residual_number;
    private $initial_value_initial;
    private $desembolso_date_initial;
    private $cuotes_number_initial;
    private $dtf;
    private $dtf_points;
    private $ibr;
    private $ibr_points;
    private $tasafija;
    private $Stat_id;
    private $obligation_cod;
    private $pay_date;
    private $obligation_antigua;

    public function __construct()
    {
        $this->user = "MAXADMIN";
        $this->password = "Renting123*";
    }
    
    public function __setObligation(
    $id,
    $code,
    $name,
    $desembolso_date,
    $initial_value,
    $cuotes_number,
    $residual_number,
    $initial_value_initial,
    $desembolso_date_initial,
    $cuotes_number_initial,
    $dtf,
    $dtf_points,
    $ibr,
    $ibr_points,
    $fixed_rate,
    $client_idmax,
    $client_contract,
    $Bank_id,
    $credit_type_id,
    $interesting_type_id,
    $amortization_method,
    $Stat_id,
    $pay_date,
    $obligation_antigua
    )
    {
        $this->obligation_id = $id;
        $this->client_idmax = $client_idmax;
        $this->client_name = $name;
        $this->client_contract = $client_contract;
        $this->Bank_id = $Bank_id;
        $this->credit_type_id = $credit_type_id;
        $this->interesting_type_id = $interesting_type_id;
        $this->amortization_type_id = $amortization_method;
        $this->desembolso_date = $desembolso_date;
        $this->initial_value = $initial_value;
        $this->cuotes_number = $cuotes_number;
        $this->residual_number = $residual_number;
        $this->initial_value_initial = $initial_value_initial;
        $this->desembolso_date_initial =$desembolso_date_initial;
        $this->cuotes_number_initial = $cuotes_number_initial;
        $this->dtf = $dtf;
        $this->dtf_points = $dtf_points;
        $this->ibr = $ibr;
        $this->ibr_points = $ibr_points;
        $this->tasafija = $fixed_rate;
        $this->Stat_id = $Stat_id;
        $this->obligation_cod = $code;
        $this->pay_date = $pay_date;
        $this->obligation_antigua = $obligation_antigua;
        
    }

    public function __getObligation()
    {
        $objObligation = new DtoObligation();
        $objObligation->__getPassword();
        $objObligation->__getObligation_id();
        $objObligation->__getClient_idmax();
        $objObligation->__getClient_name();
        $objObligation->__getClient_contract();
        $objObligation->__getBank_id();
        $objObligation->__getCredit_type_id();
        $objObligation->__getInteresting_type_id();
        $objObligation->__getAmortization_type_id();
        $objObligation->__getDesembolso_date();
        $objObligation->__getInitial_value();
        $objObligation->__getCuotes_number();
        $objObligation->__getResidual_number();        
        $objObligation->__initial_value_initial();
        $objObligation->__desembolso_date_initial();
        $objObligation->__cuotes_number_initial();
        $objObligation->__getDtf();
        $objObligation->__getDtf_points();
        $objObligation->__getIbr();
        $objObligation->__getIbr_points();
        $objObligation->__getTasafija();
        $objObligation->__getStat_id();
        $objObligation->__getObligation_cod();
        $objObligation->__getPay_date();
        $objObligation->__getObligation_antigua();
        

        return $objObligation;
    }


    //SET OBLIGATION
    
    public function __setCod($code)
    {
        $this->obligation_cod = $code;
    }
 
    public function __setName($name)
    {
        $this->Bank_name = $name;
    }
    //GET OBLIGATION
    public function __getPay_date()
    {
        return $this->pay_date;
    } 
    public function __getUser()
    {
        return $this->user;
    }
    public function __getBankName()
    {
        return $this->Bank_name;
    }
    public function __getPassword()
    {
        return $this->password;
    }
    public function __getObligation_id()
    {
        return $this->obligation_id;
    }
    public function __getClient_idmax()
    {
        return $this->client_idmax;
    }
    public function __getClient_name()
    {
        return $this->client_name;
    }
    public function __getClient_contract()
    {
        return $this->client_contract;
    }

    public function __getBank_id()
    {
        return $this->Bank_id;
    }
    public function __getCredit_type_id()
    {
        return $this->credit_type_id;
    }
    public function __getInteresting_type_id()
    {
        return $this->interesting_type_id;
    }
    public function __getAmortization_type_id()
    {
        return $this->amortization_type_id;
    }
    public function __getDesembolso_date()
    {
        return $this->desembolso_date;
    }
    public function __getInitial_value()
    {
        return $this->initial_value;
    }
    public function __getCuotes_number()
    {
        return $this->cuotes_number;
    }
    public function __getResidual_number()
    {
        return $this->residual_number;
    }
    public function __getDtf()
    {
        return $this->dtf;
    }
    public function __getDtf_points()
    {
        return $this->dtf_points;
    }
    public function __getIbr()
    {
        return $this->ibr;
    }
    public function __getIbr_points()
    {
        return $this->ibr_points;
    }
    public function __getTasafija()
    {
        return $this->tasafija;
    }
    public function __getStat_id()
    {
        return $this->Stat_id;
    }
    public function __getObligation_cod()
    {
        return $this->obligation_cod;
    }
    public function __initial_value_initial()
    {
        return $this->initial_value_initial;
    }
    public function __desembolso_date_initial()
    {
        return $this->desembolso_date_initial;
    }
    public function __cuotes_number_initial()
    {
        return $this->cuotes_number_initial;
    }
    public function __getObligation_antigua()
    {
        return $this->obligation_antigua;
    }

    
}

