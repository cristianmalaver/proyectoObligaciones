//**************************//
//Author: Cristian malaver
//Date: 9/02/2021
//Description : funtions data Client

function setDataObligation(dataSetProvision) {
  try {
    loadPageView();
    dataSetProvision = '{"POST":"POST",' + dataSetProvision + '}';
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "../../php/bo/bo_provision.php", true);
    xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
    xhttp.onreadystatechange = function () {
      if (this.readyState === 4 && this.status === 200) {
        if (xhttp.responseText != 0) {
          enableScroll();
          viewModal("customerModal", 1);
          createModalAlert("Operación realizada con éxito", 1, 3000);
          loadView();
        } else {
          enableScroll();
          createModalAlert("Valide la información", 3, 4000);
        }
      }
    }
    xhttp.send(dataSetProvision);
  } catch (error) {
    enableScroll();
    console.error(error);

  }
}
//Description : function load view page 
function loadView() {

  loadPageView();
  getLocationCode();
  getActionStorage();
}
//**Function get Obligation **/
//Author: DIEGO CASALLAS
//Date: 21/11/2020
//Description : get location url,and read the code of the obligation
function getLocationCode() {
  var getUrl = window.location.href;
  var getCode = getUrl.indexOf("?");
  var arrayJson = getUrl.substring(getCode + 1, getUrl.length).split(":");

  getProvison("tableProvision", '"' + arrayJson[0] + '":"' + arrayJson[1] + '"', 0);
}
//**Function get Obligation **/
//Author: DIEGO CASALLAS
//Date: 21/11/2020
//Description : send data get table  pay obligation
function getProvison(table, dataSetProvision, typeSend) {
  try {
    loadPageView();
    var xhttp = new XMLHttpRequest();
    var arrayProvi = new Array("Código", "Cliente","Banco", "Fecha Inicial intereses", "Fecha final intereses", "intereses Pagados", "Fracción mes actual", "Fracción mes despues", "Total Provisión", "Mes Provisión",);
    var JsonData;
    xhttp.open("POST", "../../php/bo/bo_provision.php", true);
    xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

    xhttp.onreadystatechange = function () {
      if (this.readyState === 4 && this.status === 200) {

        if (xhttp.responseText != "") {
          var jsonObj = JSON.parse(xhttp.responseText);

          if (jsonObj.length != 0) {
            enableScroll();
            //console.log(jsonObj);
            if (typeSend == 0 || typeSend == 1) {

              tableProvision = new Table(table, arrayProvi, jsonObj);
              tableProvision.createTableProvision();

            }
            else if (typeSend == 3) {
              Calculos(jsonObj);
              //loadView();
            }
            else if (typeSend == 4) {
              //debugger;
              return jsonObj;
              //loadView();
            }

            else {
              enableScroll();
            }
          }
        }
      };


    }
    if (typeSend == 0) {

      JsonData = '{"GET":"GET_PROVISION"}';
      //console.log(JsonData);
    }
    if (typeSend == 1) {
      JsonData = '{"GET":"GET_PROVISION_SEARCH","searchObligation":"' + dataSetProvision + '"}';
    }
    if (typeSend == 3) {
      JsonData = '{"GET":"GET_PAYS_FOR_PROVISION"}';
    }
    if (typeSend == 4) {
      JsonData = '{"GET":"PAY_DATE_NOTIF",' + dataSetProvision;

    }
    //debugger;
    xhttp.send(JsonData);
  } catch (error) {
    console.error(error);
    enableScroll();
  }
}

//**********************getpay this funtion take the data from the service(frontend with url) and send to getdataoblgation****************************//

function robotProvision() {
  getProvison("", "", 3);

}


//**********************getpay this funtion take the data from frontend and send ti getdataoblgation****************************//
function getPay(code) {

  getProvison("", code, 2);

}
//**********************getpay this funtion take the data from backtend and send to getdataoblgation****************************//

function calculateProvision(jSon) {

  //logica de fechas
console.log(jSon);
 /* let provi_inicialDate = moment(pay_date_notif);
  provi_inicialDate.add(1, 'days');
  provi_inicialDate = provi_inicialDate.format('YYYY-MM-DD')

  let provi_lastDate = moment(pay_date_notif);
  provi_lastDate.add(1, 'month');
  provi_lastDate = provi_lastDate.format('YYYY-MM-DD')

  let dayOfMonth = moment(provi_lastDate);
  let days = dayOfMonth.format('D');
  console.log("--------------------------------");

  if (days != 31 && days != 30 && days != 29 && days != 1) {

    //logica para enviar a buscar el mes despues en la db para calculo de provi_lastdate

    let jsonCalculo = CalculosInteresProxMes(obligation_cod, pay_date_notif);

    //console.log(jsonCalculo);
    /*for (i = 0; i < json.length; i++) {
      let obligation_cod = json[i].obligation_cod;
      let pay_interesting_value = json[i].pay_interesting_value;
       
      };*/

   /* let provi_actualMonth = (provi_interesting / 30) * (days);

    let provi_afterMonth = (provi_interesting / 30) * (30 - days);


    let total_provision = (provi_actualMonth + provi_afterMonth);
    let month = moment(provi_inicialDate);
    let provi_month = month.format('MMMM');

    //console.log("ID obligatio: " + pay_obligation_id);
    //console.log("Cod : " + obligation_cod);
    //console.log("fecha inicial intereses: " + provi_inicialDate);
    //console.log("Fecha final Intereses: " + provi_lastDate);
    //console.log("Intereses pagados: " + provi_interesting);
    //console.log("Fracción mes actual: " + provi_actualMonth);
    //console.log("Fracción mes después: " + provi_afterMonth);
    //console.log("TOTAL PROVISIÓN: " + total_provision);
    //console.log("Mes provisión: " + provi_month);
  } else {
    //console.log("Valores entre 29,30,31 y 1" );
  }
*/
}


function Calculos(json) {
  for (i = 0; i < json.length; i++) {
    let pay_obligation_id = json[i].pay_obligation_id;
    let obligation_cod = json[i].obligation_cod;
    let client_name = json[i].client_name;
    let pay_date_notif = json[i].pay_date_notif;
    let provi_interesting = json[i].pay_interesting_value;
    //let provi_interestingAfter = json[i].pay_interesting_value;


    //logica de fechas

    let provi_inicialDate = moment(pay_date_notif);
    provi_inicialDate.add(1, 'days');
    provi_inicialDate = provi_inicialDate.format('YYYY-MM-DD')

    let provi_lastDate = moment(pay_date_notif);
    provi_lastDate.add(1, 'month');
    provi_lastDate = provi_lastDate.format('YYYY-MM-DD')

    let dayOfMonth = moment(provi_lastDate);
    let days = dayOfMonth.format('D');
    console.log("--------------------------------");

    if (days != 31 && days != 30 && days != 29 && days != 1) {

      //logica para enviar a buscar el mes despues en la db para calculo de provi_lastdate

      let jsonCalculo = CalculosInteresProxMes(obligation_cod, pay_date_notif);

      //console.log(jsonCalculo);
      /*for (i = 0; i < json.length; i++) {
        let obligation_cod = json[i].obligation_cod;
        let pay_interesting_value = json[i].pay_interesting_value;
         
        };*/

      let provi_actualMonth = (provi_interesting / 30) * (days);

      let provi_afterMonth = (provi_interesting / 30) * (30 - days);


      let total_provision = (provi_actualMonth + provi_afterMonth);
      let month = moment(provi_inicialDate);
      let provi_month = month.format('MMMM');

      //console.log("ID obligatio: " + pay_obligation_id);
      //console.log("Cod : " + obligation_cod);
      //console.log("fecha inicial intereses: " + provi_inicialDate);
      //console.log("Fecha final Intereses: " + provi_lastDate);
      //console.log("Intereses pagados: " + provi_interesting);
      //console.log("Fracción mes actual: " + provi_actualMonth);
      //console.log("Fracción mes después: " + provi_afterMonth);
      //console.log("TOTAL PROVISIÓN: " + total_provision);
      //console.log("Mes provisión: " + provi_month);
    } else {
      //console.log("Valores entre 29,30,31 y 1" );
    }

  }
  //var aaa = moment("2021-02-25");
  //console.log(aaa.format('D'));
}
function CalculosInteresProxMes(obligation_cod, pay_date_notif) {

  //console.log(obligation_cod);
  //console.log(pay_date_notif);

  let datedb = moment(pay_date_notif);
  datedb.add(1, 'month');
  datedb = datedb.format('YYYY-MM-DD')

  let jsonData = '';
  jsonData += '"obligation_cod":' + '"' + obligation_cod + '",';
  jsonData += '"pay_date_notif":' + '"' + datedb + '"}';
  // debugger;
  console.log(getProvison("", jsonData, 4));
  //return getProvison("", jsonData, 4);


  //console.log(date_pay_notif_after);
}


//************ LOAD VIEW STORAGE ******************/
function getActionStorage() {
  let obj = new StoragePage();
  let json = JSON.parse(obj.getStorageLogin());
  0
  if (json !== null) {
    getDataUserId(json[0]["User_id"]);
  } else {
    locationLogin();
  }
}
//************GET DATA FORM**************//
function sendData(idForm, e) {
  let jSon = "";

  if (validatorForm(idForm)) {
    jSon = getDataForm(idForm);
    //console.log(getDataForm(idForm));
    getProvison("tableProvision", jSon, 4);
  } else {
    createModalAlert("Error al realizar el registro", 4, 4000);
  }
  e.preventDefault();
}
//************GET DATA FROM BACKEND**************//
function sendDataRobot(json) {
  //console.log(json);    
  getProvison("", json, 5);

}
//************ Search Obligations ******************/
//************ Search Obligations ******************/
function searchObligation(e) {
  try {

    var objForm = document.getElementById('formSearchObligation');
    let intLogForm = objForm.querySelectorAll('input').length;
    let jsonData = '';

    for (let i = 0; i < intLogForm; i++) {
      jsonData = objForm[i].value;

    }
    getProvison("tableProvision", jsonData, 1);
  } catch (error) {
    console.error(error);
  }
  e.preventDefault();
}

function newObligation() {
  document.getElementById('obligation_id').value = "0";

}
function createPayTable(code) {

  getDataObligation("", code, 3);
}
function convertToExcel() {

  window.open('https://docs.google.com/spreadsheets/d/1xotwTBoF3IlY8Fqg0Ve02UzqPa0FhjpzJx6NHsi29cQ/edit?ts=60380e3b#gid=0');
}