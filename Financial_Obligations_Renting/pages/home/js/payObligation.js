//**************************//
//Author: DIEGO CASALLAS
//Date: 24/08/2019
//Description : funtions data Client
//************GET DATA FORM**************//

//**Function add Obligation **/
//Author: DIEGO CASALLAS
//Date: 18/11/2020
//Description : send data create obligation
// variables globales
var provi_interesting;
var provi_inicialDate;
var provi_lastDate;
var days;

function setDataObligation(dataSetObligation) {
    try {
        loadPageView();
        dataSetObligation = '{"POST":"POST",' + dataSetObligation + '}';
        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
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
        xhttp.send(dataSetObligation);
    } catch (error) {
        enableScroll();
        console.error(error);

    }
}
//Description : function load view page 
function loadView() {

    loadPageView();
    getLocationCode();;
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
        var arrayPayObli = new Array("Código", "Cliente", "Banco", "Valor Inicial", "# Cuotas", "Cuota actual", "Fecha para pago", "Valor a pagar", "Estado", "Acciones");
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_payObligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {

                if (xhttp.responseText != "") {
                    var jsonObj = JSON.parse(xhttp.responseText);

                    if (jsonObj.length != 0) {
                        enableScroll();
                        //console.log(jsonObj);
                        if (typeSend == 0 || typeSend == 1) {

                            tableObligation = new Table(table, arrayPayObli, jsonObj);
                            tableObligation.createTablePayObligations();

                        } else if (typeSend == 3) {
                            //console.log(jsonObj);
                            apayAmortization = new payAmortization(jsonObj);
                            jsonAmortization = apayAmortization.getPayObligation();
                            //ACA ESTA BIEN EL DATO "
                            //console.log(jsonAmortization);
                            sendDataRobot(jsonAmortization);

                        }

                        else if (typeSend == 2) {
                            //console.log(jsonObj);
                            setDataForm(jsonObj);
                            viewModal('payModal', 0);
                        }
                        else if (typeSend == 4) {

                            viewModal('payModal', 1);
                            calculateProvision(dataSetObligation);
                            loadView();
                            
                        }
                        else if (typeSend == 5) {
                            //console.log(jsonObj);
                            //loadView();
                        }
                        else if (typeSend == 6) {
                            Pay(jsonObj);
                            //loadView();
                        }
                        else if (typeSend == 7) {
                            //console.log(jsonObj);
                            apayAmortization = new payAmortization(jsonObj);
                            jsonAmortization = apayAmortization.getPayObligation();
                            CalculosInteresProxMes(jsonAmortization);
                            //return jsonAmortization;
                            //ACA ESTA BIEN EL DATO "
                            //console.log(jsonAmortization);
                            //sendDataRobot(jsonAmortization);

                        }
                        else if (typeSend == 8) {
                            //console.log(jsonObj);
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
            JsonData = '{"GET":"GET_PAY_OBLIGATION"}';
        }
        if (typeSend == 1) {
            JsonData = '{"GET":"GET_OBLIGATION_SEARCH","searchObligation":"' + dataSetObligation + '"}';
        }
        if (typeSend == 3) {
            JsonData = '{"GET":"GET","obligation_cod":"' + dataSetObligation + '"}';
        }
        if (typeSend == 2) {
            JsonData = '{"GET":"GET2","obligation_cod":"' + dataSetObligation + '"}';
        }
        if (typeSend == 4) {
            JsonData = '{"POST":"POST",' + dataSetObligation + '}';
        }
        if (typeSend == 5) {

            JsonData = '{"POST":"POST",' + dataSetObligation + '}';
        }
        if (typeSend == 6) {
            JsonData = '{"GET":"GETNOT"}';
        }
        if (typeSend == 7) {
            
            JsonData = '{"GET":"PROVISION","obligation_cod":"' + dataSetObligation + '"}';
            
        }
        if (typeSend == 8) {
            
            JsonData = '{"POST":"POST_PROVISION",' + dataSetObligation + '}';
            //console.log(JsonData);
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
    for (i = 0; i < code.length; i++) {
        getDataPayObligation("", code[i].obligation_cod, 3);
        //console.log("",code[i].obligation_cod,3);
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
        //console.log(getDataForm(idForm));
        //calculateProvision(jSon);
        getDataPayObligation("tablePayObligation",jSon,4);
    } else {
        createModalAlert("Error al realizar el registro", 4, 4000);
    }
    e.preventDefault();
}
//************GET DATA FROM BACKEND**************//
function sendDataRobot(json) {
    //console.log(json);    
    getDataPayObligation("", json, 5);

}
//funtion for provisoin
function calculateProvision(json) {
    let OBJjsonData = '{' + json + ' }';
    OBJjsonData = JSON.parse(OBJjsonData);

    //console.log(json);
    let obligation_cod = OBJjsonData.obligation_cod;
    provi_interesting = OBJjsonData.pay_interesting_value;
    let pay_Date = OBJjsonData.pay_Date;
    //console.log(obligation_cod);
    // console.log(pay_interesting_value.value);

    //logica de fechas

    provi_inicialDate = moment(pay_Date);
    provi_inicialDate.add(1, 'days');
    provi_inicialDate = provi_inicialDate.format('YYYY-MM-DD')

    provi_lastDate = moment(pay_Date);
    provi_lastDate.add(1, 'month');
    provi_lastDate = provi_lastDate.format('YYYY-MM-DD')

    let dayOfMonth = moment(pay_Date);
    days = dayOfMonth.format('D');


    if (days != 31 && days != 30 && days != 29 && days != 1) {

        //logica para enviar a buscar el mes despues en la db para calculo de provi_lastdate

        getDataPayObligation("", obligation_cod, 7);

        //console.log(jsonCalculo);


    } else {
        console.log("Valores entre 29,30,31 y 1");
    }


}
function CalculosInteresProxMes(jsonFuture) {


    let OBJjsonData = '{' + jsonFuture + ' }';
    OBJjsonData = JSON.parse(OBJjsonData);
    //console.log(OBJjsonData);

    let obligation_cod = OBJjsonData.obligation_cod;
    let provi_interestingAfter = OBJjsonData.pay_interesting_value;

    let provi_actualMonth = (provi_interesting / 30) * (days);

    let provi_afterMonth = (provi_interestingAfter / 30) * (30 - days);


    let total_provision = (provi_actualMonth + provi_afterMonth);
    let month = moment(provi_inicialDate);
    let provi_month = month.format('MMMM');

    let jsonData = '';
                jsonData += '"obligation_cod":' + '"' + obligation_cod + '",';
                jsonData += '"provi_inicialDate":' + '"' + provi_inicialDate + '",';
                jsonData += '"provi_lastDate":' + '"' + provi_lastDate + '",';
                jsonData += '"provi_interesting":' + '"' + Math.round(provi_interesting) + '",';
                jsonData += '"provi_actualMonth":' + '"' + Math.round(provi_actualMonth) + '",';
                jsonData += '"provi_afterMonth":' + '"' + Math.round(provi_afterMonth) + '",';
                jsonData += '"total_provision":' + '"' + Math.round(total_provision) + '",';
                jsonData += '"pay_Date":' + '"' + provi_month + '",';

                jsonData = jsonData.substring(0, jsonData.length - 1) + '';
        //console.log(jsonData);

      getDataPayObligation("", jsonData, 8);

    
}


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
function closeSession() {
    let obj = new StoragePage();
    obj.removeStorageUser();
    window.location.assign("../login/login.html");

}

