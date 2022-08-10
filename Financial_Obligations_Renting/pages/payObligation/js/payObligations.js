//**************************//
//Author: DIEGO CASALLAS
//Date: 24/08/2019
//Description : funtions data Client
//************GET DATA FORM**************//

//**Function add Obligation **/
//Author: DIEGO CASALLAS
//Date: 18/11/2020
//Description : send data create obligation
function setDataObligation(dataSetObligation) {
    try {
        loadPageView();
        dataSetObligation = '{"POST":"POST",' + dataSetObligation + '}';
        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
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
        xhttp.send(dataSetObligation);
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

    getDataPayObligation("tablePayObligation", '"' + arrayJson[0] + '":"' + arrayJson[1] + '"', 0);
}
//**Function get Obligation **/
//Author: DIEGO CASALLAS
//Date: 21/11/2020
//Description : send data get table  pay obligation
function getDataPayObligation(table, dataSetObligation, typeSend) {
    try {
        loadPageView();
        var xhttp = new XMLHttpRequest();
        var arrayPayObli = new Array("Código", "Cliente","Banco","Valor Pagado", "Cuotas pagadas","Fecha de notificacion","Fecha de pago", "Estado");
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_payObligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {

                if (xhttp.responseText != "") {
                    var jsonObj = JSON.parse(xhttp.responseText);

                    if (jsonObj.length != 0) {
                        enableScroll();
                        //console.log(jsonObj);
                        if (typeSend == 0 || typeSend == 1) {

                            tableObligation = new Table(table, arrayPayObli, jsonObj);
                            tableObligation.createTablePayObligations_pays();

                        } else if (typeSend == 3) {
                            //console.log(jsonObj);
                            apayAmortization = new payAmortization(jsonObj);
                            jsonAmortization = apayAmortization.getPayObligation();
                            //console.log(jsonAmortization);
                            sendDataRobot(jsonAmortization);
                            
                        }


                        else {
                            enableScroll();
                        }
                    }
                }
            };


        }
        if (typeSend == 0) {
            JsonData = '{"GET":"GET_PAY_OBLIGATION_PAYS"}';
        }
        if (typeSend == 1) {
            JsonData = '{"GET":"GET_OBLIGATION_SEARCH","searchObligation":"' + dataSetObligation + '"}';
        }
        if (typeSend == 3) {
            JsonData = '{"GET":"GET","obligation_cod":"' + dataSetObligation + '"}';
        }
        
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
        enableScroll();
    }
}
//**********************getpay this funtion take the data from frontend and send ti getdataoblgation****************************//
function getPay(code) {

    getDataPayObligation("", code, 2);

}
//**********************getpay this funtion take the data from backtend and send to getdataoblgation****************************//

function Pay(code) {
    for(i=0; i<code.length; i++){
    getDataPayObligation("",code[i].obligation_cod,3);  
    }
}
//**********************getpay this funtion take the data from the service(frontend with url) and send to getdataoblgation****************************//

function PayToSelect() {
    getDataPayObligation("", "", 6);
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
        //console.log(jSon);
        //getDataPayObligation("tablePayObligation",jSon,4);
    } else {
        createModalAlert("Error al realizar el registro", 4, 4000);
    }
    e.preventDefault();
}
//************GET DATA FROM BACKEND**************//
function sendDataRobot(json) {
    //console.log(json);    
    getDataPayObligation("",json,5);
   
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
        getDataPayObligation("tablePayObligation", jsonData, 1);
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
function convertToExcel(){
    
    window.open('https://docs.google.com/spreadsheets/d/1AC7H958_9zI2K6pR7B5WGz0AtDPqhkQLYtm6w2U-PiM/edit#gid=0');
}