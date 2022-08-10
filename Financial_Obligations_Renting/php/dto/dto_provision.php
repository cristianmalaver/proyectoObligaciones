<?php 
#Author: cristian malaver
#Date: 9/02/20201
#Description : Is DTO provision

class DtoProvision
{
    private $Bank_name;
    private $user;
    private $password;

    private $obligation_cod;
    private $provi_inicialDate;
    private $provi_lastDate;
    private $provi_interesting;
    private $provi_actualMonth;
    private $provi_afterMonth;
    private $total_provision;
    private $provi_month;
 
   
    public function __setPostProvison(
    
    $obligation_cod,
    $provi_inicialDate,
    $provi_lastDate,
    $provi_interesting,
    $provi_actualMonth,
    $provi_afterMonth,
    $total_provision,
    $provi_month
    
    )
    {   
        $this->obligation_cod = $obligation_cod;
        $this->provi_inicialDate = $provi_inicialDate;
        $this->provi_lastDate = $provi_lastDate;
        $this->provi_interesting = $provi_interesting;
        $this->provi_actualMonth = $provi_actualMonth;
        $this->provi_afterMonth = $provi_afterMonth;
        $this->total_provision = $total_provision;
        $this->provi_month = $provi_month;

   
    }

    public function __getProvison()
    {
        $objProvison = new DtoProvision();
           
        $objProvison->__getPay_obligation_cod();
        $objProvison->__getProvi_inicialDate();
        $objProvison->__getProvi_lastDate();
        $objProvison->__getProvi_interesting();
        $objProvison->__getProvi_actualMonth();
        $objProvison->__getProvi_afterMonth();
        $objProvison->__getTotal_provision();
        $objProvison->__getProvi_month();      
        

        return $objProvison;
    }


    //SET provision
    
    public function __setCod($code)
    {
        $this->obligation_cod = $code;
    }
 
    public function __setName($name)
    {
        $this->Bank_name = $name;
    }
    //GET provision
    public function __getPay_payObligation_id()
    {
        return $this->id_provision;
    } 
    public function __getPay_obligation_cod()
    {
        return $this->obligation_cod;
    } 
    public function __getProvi_inicialDate()
    {
        return $this->provi_inicialDate;
    } 
    public function __getProvi_lastDate()
    {
        return $this->provi_lastDate;
    } 
    public function __getProvi_interesting()
    {
        return $this->provi_interesting;
    }
     public function __getProvi_actualMonth()
    {
        return $this->provi_actualMonth;
    } 
    public function __getProvi_afterMonth()
    {
        return $this->provi_afterMonth;
    } 
    public function __getTotal_provision()
    {
        return $this->total_provision;
    }
     public function __getProvi_month()
    {
        return $this->provi_month;
    } 
    public function __getProvi_difDays()
    {
        return $this->provi_difDays;
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

}

