<?php
#Author: Cristian malaver
#Date: 2/02/2021
#Description : Is BO Provider
include "../dto/dto_provision.php";
include "../dao/dao_provision.php";
header("Content-type: application/json; charset=utf-8");
class BoProvision
{
  private $objProvision;
  private $objDao;
  private $intValidate;

  public function __construct()
  {
    $this->objProvision = new DtoProvision();
    $this->objDao = new DaoProvision();
  }

  #Description: Function for create a new pay obligation
  /*public function newProvision(
    $pay_obligation_id,
    $obligation_cod, 
    $actual_cuote,
  //  $pay_date,
    $pay_dtf,
    $pay_ibr,
    $pay_FixedRate,
    $pay_value,
    $pay_capital_value,
    $pay_residue,
  //  $Stat_id,
    $pay_interesting_value,
    $pay_observation,
    $pay_date
  ) {
    try {
      $this->objProvision->__setProvision(
        $pay_obligation_id,
        $obligation_cod,
        $actual_cuote,
    //    $pay_date,
        $pay_dtf,
        $pay_ibr,
        $pay_FixedRate,
        $pay_value,
        $pay_capital_value,
        $pay_residue,
    //    $Stat_id,
        $pay_interesting_value,
        $pay_observation,
        $pay_date
      );
      $intValidate = $this->objDao->newProvision($this->objProvision);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }*/
  #Description: Function get pay to pay_obligation and read for provision
  public function getPayProvision()
  {
    try {
      $intValidate = $this->objDao->getPayProvision();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
  #Description: Function get provision 
  public function get_provision()
  {
    try {
      $intValidate = $this->objDao->get_provision();
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
   #Description: Function to get date + 1 month provision 
   public function get_date_provision($obligation_cod,$pay_date_notif)
   {
     try {
       $intValidate = $this->objDao->get_date_provision($obligation_cod,$pay_date_notif);
     } catch (Exception $e) {
       echo 'Exception captured: ', $e->getMessage(), "\n";
       $intValidate = 0;
     }
     return $intValidate;
   }
  
  #Description: Function get obligation 
  public function getObligationSearch($dataSearch)
  {
    try {
      $intValidate = $this->objDao->getObligationSearch($dataSearch);
    } catch (Exception $e) {
      echo 'Exception captured: ', $e->getMessage(), "\n";
      $intValidate = 0;
    }
    return $intValidate;
  }
 #Description: Function get obligation 
 public function selectObligation($dataCode)
 {
   try {
     $intValidate = $this->objDao->selectObligation($dataCode);
   } catch (Exception $e) {
     echo 'Exception captured: ', $e->getMessage(), "\n";
     $intValidate = 0;
   }
   return $intValidate;
 }
}


$obj = new BoProvision();
/// We get the json sent
$getData = file_get_contents('php://input');
$data = json_decode($getData);

/**********CREATE ************/
/*if (isset($data->POST)) {
  if ($data->POST == "POST") {
    echo $obj->newProvision(
      $data->pay_obligation_id,
      $data->obligation_cod,
      $data->pay_obligation_actual_cuote,
   //   $data->pay_Date,
      $data->pay_Dtf,
      $data->pay_Ibr,
      $data->pay_FixedRate,
      $data->pay_value,
      $data->pay_capital_value,
      $data->pay_residue,
   //   $data->Stat_id,
      $data->pay_interesting_value,
      $data->pay_observation,
      $data->pay_Date
    );
  }/*
  if ($data->POST == "POST_DELETE") {
    echo $obj->deleteObligation($data->obligationCod);
  }
}*/

/**********READ AND CONSULT ************/
if (isset($data->GET)) {

  if ($data->GET == "GET_PAYS_FOR_PROVISION") {

    echo $obj->getPayProvision();
  }
  
  if ($data->GET == "GET") {
    echo $obj->selectObligation($data->obligation_cod);
  }
 
  if ($data->GET == "GET_OBLIGATION_SEARCH") {

    echo $obj->getObligationSearch($data->searchObligation);
  }
  if ($data->GET == "GET_PROVISION") {

    echo $obj->get_provision();
  }
  if ($data->GET == "PAY_DATE_NOTIF") {

    echo $obj->get_date_provision($data->obligation_cod,$data->pay_date_notif);
  }
  
}
/**********************/
//echo $obj->get_provision();
//echo $obj->getPayProvision();
//echo $obj->get_date_provision('prueba_provision','2020-08-12');
//echo $obj->newPayObligation(0,'28331710-1',1,1.97,1.97,0,1887271,1501295,110361881,385976,'','2020-12-29');

