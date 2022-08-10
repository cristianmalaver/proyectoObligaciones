<?php
#Author: DIEGO  CASALLAS
#Date: 21/03/2019
#Description : Is connection data 
    class DtoConnection {
    private $user;
    private $password;
    private $server;
    private $database;

    function __construct(){ 
     // $this->user="root";
     // $this->password="";
     // $this->server="localhost";
     // $this->database="financeobligation";
      $this->user="u952600060_itadmin";
      $this->password="Renting2020*";
      $this->server="localhost";
      $this->database="u952600060_obligation";
          
    }
        public function getUser()
        {
            return $this->user;
        }
        public function getPassword()
        {
            return $this->password;
        }
        public function getServer()
        {
            return $this->server;
        }
        public function getDataase()
        {
            return $this->database;
        }
        public function getData(){
                
            return array($this->server,$this->user,$this->password,$this->database);
        }
    }
?> 