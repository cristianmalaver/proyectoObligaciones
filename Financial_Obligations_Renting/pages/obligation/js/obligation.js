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
                //console.log(xhttp.responseText);
                if (xhttp.responseText != 0) {
                    enableScroll();
                    viewModal("customerModal", 1);
                    createModalAlert("Operación realizada con éxito", 1, 3000);
                    loadView();
                } else {
                    enableScroll();
                    createModalAlert("Valide la información", 3, 4000);
                   // debugger;
                }
            }
        }
        xhttp.send(dataSetObligation);
    } catch (error) {
        enableScroll();
        console.error(error);

    }
}
//**Function get Obligation **/
//Author: DIEGO CASALLAS
//Date: 18/11/2020
//Description : send data get table  obligation
function getDataObligation(table, dataSetObligation, typeSend) {
    try {
        loadPageView();
        var xhttp = new XMLHttpRequest();
        var arrayCell = new Array("Codigó", "Nit", "Nombre", "Contrato", "Banco", "Estado","Acciones");
        var JsonData;
        var tableAmortization;

        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                if (xhttp.responseText != "") {
                    var jsonObj = JSON.parse(xhttp.responseText);

                    if (jsonObj.length != 0) {
                        enableScroll();
                        if (typeSend == 2 || typeSend == 1) {
                            tableObligation = new Table(table, arrayCell, jsonObj);
                            tableObligation.createTableObligations();
                        } else if (typeSend == 0) {
                            setDataForm(jsonObj);
                            viewModal('customerModal', 0);
                        } else if (typeSend == 3) {
                            tableAmortization = new TableAmortization(table, jsonObj,0);
                            tableAmortization.getdatajson();
                            viewModal('AmortizationModal', 0);
                            //console.log(tableAmortization.getdatajson());
                        }
                        else if (typeSend == 4 ) {
                           
                            getDataObligation("tableObligation", "", 2);
                            
                           
                        }
                        else if (typeSend == 5 ) {
                           
                            getDataObligation("tableObligation", "", 2);
                            
                           
                        }
                    } else {
                        enableScroll();
                    }
                }
            }
        };
        if (typeSend == 0) {
            JsonData = '{"GET":"GET","obligation_cod":"' + dataSetObligation + '"}';
        }
        if (typeSend == 1) {
            JsonData = '{"GET":"GET_OBLIGATION_SEARCH","searchObligation":"' + dataSetObligation + '"}';
        }

        if (typeSend == 2) {
            JsonData = '{"GET":"GET_OBLIGATION"}';

        }
        if (typeSend == 3) {
            JsonData = '{"GET":"GET","obligation_cod":"' + dataSetObligation + '"}';
            //console.log(JsonData);
            
        }
        if (typeSend == 4) {
            JsonData = '{"POST":"POST_CHANGE_STATUS","obligation_cod":"' + dataSetObligation + '"}';
        }
        
        if (typeSend == 5) {
            JsonData = '{"POST":"POST_DELETE","obligation_cod":"' + dataSetObligation + '"}';
        }
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
        enableScroll();
    }
}
//**********************GED EDIT****************************//
function getDataEdit(code) {
    getListBank("Bank_id");
    getListTypeCredit("credit_type_id");
    getListTypeInteres("interesting_type_id");
    getListMethodAmortization("amortization_type_id");
    getDataObligation("", code, 0);

}
//**********************END CLIENT****************************//
//**********************GED DELETE****************************//
function getChangeStatus(code) {
let r = confirm("Desea cambiar el registro con CODIGO :  " + code + "  a Suspendido");
if (r == true) {
    getDataObligation("", code, 4);
  }   
    }

//**********************END CLIENT****************************//
//**********************GED DELETE****************************//
function getDelete(code) {
    let r = confirm("Desea borrar el registro con CODIGO :  " + code);
    if (r == true) {
        getDataObligation("", code, 5);
      }   
        }
    
    //**********************END CLIENT****************************//
    
//**********************GED EDIT****************************//
function getPay(code) {
    location.href = "../../pages/payObligation/payObligation.php?obligation_cod:" + code;
    //getDataObligation("", code, 0);

}
//**********************END CLIENT****************************//

//Description : function load view page 
function loadView() {
    getClientMaximo("client_idmax");
    loadPageView();
    getDataObligation("tableObligation", "", 2);
    getActionStorage();
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
        setDataObligation(jSon);
    } else {
        createModalAlert("Error al realizar el registro", 4, 4000);
    }
    e.preventDefault();
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
        getDataObligation("tableObligation", jsonData, 1);
    } catch (error) {
        console.error(error);
    }
    e.preventDefault();
}

function newObligation() {
    document.getElementById('obligation_id').value = "0";
    //getClientMaximo("client_idmax");
    getListBank("Bank_id");
    getListTypeCredit("credit_type_id");
    getListTypeInteres("interesting_type_id");
    getListMethodAmortization("amortization_type_id");
}
//**Function get List Bank **/
function getListBank(idSelect) {
    try {
        var xhttp = new XMLHttpRequest();
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var jsonObj = JSON.parse(xhttp.responseText);
                if (jsonObj.length != 0) {
                    selectStatus = new SelectList(idSelect, jsonObj);
                    selectStatus.createListBank();
                }
            }
        };
        JsonData = '{"GET":"GET_LIST_BANK"}';
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
    }
}
//**********************END BANK****************************//
//**Function get List Client maximo **/
function getClientMaximo(idSelect) {
    try {
        var xhttp = new XMLHttpRequest();
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var jsonObj = JSON.parse(xhttp.responseText);
                if (jsonObj.length != 0) {
                    selectStatus = new SelectList(idSelect, jsonObj);
                    selectStatus.createListMaximo();
                }

            }
        };
        JsonData = '{"GET":"GET_CLIENT_MAXIMO"}';
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
    }
}
//**Function cath value Client maximo **/
function getSelectContract(id) {
    try {
        var objSelect = document.getElementById(id);
        let idNit = objSelect.value;
        let nameClient = objSelect.options.item(objSelect.selectedIndex).text;
        document.getElementById('client_name').value = nameClient.substring(nameClient.indexOf("|") + 1, nameClient.length);
        sendClientContractMaximo("client_contract", idNit);
    } catch (error) {
        console.error(error);
    }
}
//**********************END BANK****************************//
//**Function get List Client Contract maximo **/
function sendClientContractMaximo(idSelect, idClient) {
    try {
        var xhttp = new XMLHttpRequest();
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var jsonObj = JSON.parse(xhttp.responseText);
                if (jsonObj.length != 0) {
                    selectStatus = new SelectList(idSelect, jsonObj);
                    selectStatus.createListContractMaximo();
                }

            }
        };
        JsonData = '{"GET":"GET_CLIENT_CONTRACT_MAXIMO","nit":"' + idClient + '"}';
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
    }
}
//**********************END BANK****************************// 
//**Function get List type_credit **/
function getListTypeCredit(idSelect) {
    try {
        var xhttp = new XMLHttpRequest();
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var jsonObj = JSON.parse(xhttp.responseText);
                if (jsonObj.length != 0) {
                    selectStatus = new SelectList(idSelect, jsonObj);
                    selectStatus.createListTypeCredit();
                }

            }
        };
        JsonData = '{"GET":"GET_TYPE_OBLIGATION"}';
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
    }
}
//**********************END BANK****************************//
//**Function get List type_interes **/
function getListTypeInteres(idSelect) {
    try {
        var xhttp = new XMLHttpRequest();
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var jsonObj = JSON.parse(xhttp.responseText);
                if (jsonObj.length != 0) {
                    selectStatus = new SelectList(idSelect, jsonObj);
                    selectStatus.createListTypeInteres();
                }

            }
        };
        JsonData = '{"GET":"GET_TYPE_INTERES"}';
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
    }
}
//**********************END BANK****************************//
//**Function get List amortization_method **/
function getListMethodAmortization(idSelect) {
    try {
        var xhttp = new XMLHttpRequest();
        var JsonData;
        xhttp.open("POST", "../../php/bo/bo_obligation.php", true);
        xhttp.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                var jsonObj = JSON.parse(xhttp.responseText);
                if (jsonObj.length != 0) {
                    selectStatus = new SelectList(idSelect, jsonObj);
                    selectStatus.createListMethodAmortization();
                }
            }
        };
        JsonData = '{"GET":"GET_METHOD_AMORTIZATION"}';
        xhttp.send(JsonData);
    } catch (error) {
        console.error(error);
    }
}
//**********************END BANK****************************//
//**********************Function create amortization table ****************************//
function createAmortizationTable(code) {

    getDataObligation("", code, 3);
}
//**********************END BANK****************************//