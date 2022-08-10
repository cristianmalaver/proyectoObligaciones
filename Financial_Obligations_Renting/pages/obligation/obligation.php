<?php
session_start();

if (!isset($_SESSION['User'])) {
  header("../../pages/login/login.html");
} else {
  $var_session  = $_SESSION['User'];
}
?>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Crear Obligacion</title>
  <!-- css link -->
  <?php include("../../php/viewHtml/cssLink.php") ?>
  <link href="css/styleObligation.css" rel="stylesheet">
</head>

<body id="page-top">
  <div class="loadPage" id="loadPage"></div>
  <input type="hidden" id="User_id">
  <!--Alert-->
  <div id="myAlert"></div>
  <!--Alert-->
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <?php include("../../php/viewHtml/slideMenu.php") ?>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <?php include("../../php/viewHtml/navUser.php") ?>
        <!-- End of Topbar -->

        <!-- Topbar -->
        <?php include("../../php/viewHtml/topbar.php") ?>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->

        <div class="container-fluid">
          <br>
          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">Crear obligación Financiera</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">

              <ul class="nav nav-pills card-header-pills">
                <li class="nav-item">
                  <div class="ml-4">
                    <button class="btn btn-secondary" data-toggle="modal" data-target="#customerModal" onclick="clearForm('form_customers', 1);newObligation()"><i style="font-size: 2rem; padding:5px;" class="material-icons">add_box</i></button>
                  </div>
                </li>
              </ul>
              <div class="text-center">
                <h4 class="m-0 font-weight-bold text-primary">Obligaciones Creadas</h4>
              </div>
            </div>
            <div class=" mx-auto col-md-6 align-self-center">
              <form class="navbar-form" id="formSearchObligation">
                <div class="input-group ">
                  <input type="text" value="" class="form-control bg-light border-0 small" placeholder="Obligación a buscar">
                  <button type="submit" class="btn btn-primary" onclick="searchObligation(event);return false">
                    <i class="fas fa-search fa-sm"></i>
                    <div class="ripple-container"></div>
                  </button>
                </div>
              </form>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table  " data-order='[[ 1, "asc" ]]' data-page-length='25' id="tableObligation" width="100%" cellspacing="0">
                </table>
              </div>
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; <script>
                document.write(new Date().getFullYear());
              </script> | Renting automayor. </span>

          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- delete Modal-->
  <div class="modal fade" id="deleteObj" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="delete">seguro quieres eliminar esta obligaacion?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Selecciona "Borrar" para eliminar esta obligacion.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="/obligation/obligation.php">Borrar</a>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal -->
  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">¿Seguro que quieres salir?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Selecciona "Cerrar sesión" a continuación si está listo para finalizar su sesión personal.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="../../php/class/closeSession.php" onclick="closeSession()">Cerrar Sessión</a>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal -->
  <div class="modal fade fullscreen-modal" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="customerModalLabel">Obligación </h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="col-md-12">

            <form id="form_customers" class="text-left  was-validated" action="#!" onsubmit="sendData(this.id,event);return false">
              <input type="hidden" id="obligation_id">


              <div class="form-row mb-1">




                <div class="col-md-4 mb-1">
                  <!-- Obligación -->
                  <div class="bmd-label-floating">
                    <h6 class="bmd-label-floating">Código de Obligación</h6>
                    <input type="text" id="obligation_cod" class="form-control form-control-sm read" placeholder="Ingresar código " required>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione código</div>
                  </div>
                </div>


               <div class="col-md-4 mb-1">
                   <!--Obligación -->
                  <div class="bmd-label-floating">
                    <h6 for="client_idmax">Seleccionar Cliente</h6>

                    <input type="hidden" id="client_name">
                    <select id="client_idmax" class="custom-select custom-select-sm" onchange="getSelectContract(this.id)" required>

                    </select>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione un valor válido.</div>
                  </div>
                </div>

                <div class="col-md-4 mb-1">
                  <!-- contrato -->
                  <h6 for="client_contract">Seleccionar Contrato</h6>
                  <select id="client_contract" class="custom-select custom-select-sm" required>
                    <option disabled selected value> -- Seleccione una opción -- </option>
                  </select>

                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>

              </div>
              <div class="form-row mb-1">

                <div class="col-md-4 mb-1">
                  <!-- obligation antigua-->
                  <h6 for="obligation_antigua">Es obligación Antigua</h6>
                  <select id="obligation_antigua" class="custom-select custom-select-sm " onchange="viewAntiguo(this.selectedIndex)" required>
                    <option disabled selected value> -- Seleccione una opción -- </option>
                    <option value="si">SI</option>
                    <option value="no">NO</option>
                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>


                <div class="col-md-4 mb-1">
                  <!-- banco -->
                  <h6 for="Bank_id">Seleccionar Banco</h6>
                  <select id="Bank_id" class="custom-select custom-select-sm" required>
                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>

                <div class="col-md-4 mb-1">
                  <!-- tipo de credito -->
                  <h6 for="credit_type_id">Tipo de credito</h6>
                  <select id="credit_type_id" class="custom-select custom-select-sm read" required onchange="view(this.selectedIndex)">
                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>


              </div>

              <div class="form-row mb-1">


                <div class="col-md-4 mb-1">
                  <!-- Tipo de interes -->
                  <h6 for="interesting_type_id">Tipo de interes</h6>
                  <select id="interesting_type_id" class="custom-select custom-select-sm " required onchange="viewContent(this.selectedIndex)">
                  </select>

                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>

                <div class="col-md-4 mb-1">
                  <!-- Metodo de amortizacion -->
                  <h6 for="amortization_type_id">Metodo de amortizacion</h6>
                  <select id="amortization_type_id" class="custom-select custom-select-sm read" required>
                  </select>

                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>
                <div class="col-md-4 mb-1">
                  <!-- Ingresar Fecha de desembolso -->
                  <h6 class="bmd-label-floating">Fecha de desembolso</h6>
                  <input type="date" id="desembolso_date" class="form-control form-control-sm read" placeholder="Ingresar Fecha de desembolso" required onblur="payChangeDate(this.value)">
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione una fecha válida.</div>
                </div>

                <div class="col-md-4 mb-1 hideContent">
                  <!-- status obligation-->
                  <h6 for="Stat_id">Estado</h6>
                  <select id="Stat_id" class="custom-select custom-select-sm read" required>
                    <option value="3">Activo</option>
                    <option value="4">Inactivo</option>
                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>


              </div>

              <div class="form-row mb-1">

                <div class="col-md-3 mb-1">
                  <!-- Ingresar valor inicial de desembolso -->
                  <label class="bmd-label-floating">Valor desembolso</label>
                  <input type="text" id="initial_value_format" class="form-control form-control-sm read" placeholder="Ingresar valor inicial de desembolso" onkeyup="format(this),passValue('initial_value',this.value)" required>
                  <input type="hidden" id="initial_value">
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>

                <div class="col-md-3 mb-1">
                  <!-- Ingresar # de cuotas -->
                  <label class="bmd-label-floating">Ingresar # de cuotas</label>
                  <input type="text" pattern="[0-9]{0,3}" id="cuotes_number" class="form-control form-control-sm read" placeholder="Ingresar # de cuotas " required>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Valor Maximo permitido es de 999 cuotas</div>
                </div>

                <div class="col-md-3 mb-1" id="pay_datet">
                  <!-- fecha de proximo pago -->
                  <label class="bmd-label-floating">Fecha de proximo pago</label>
                  <input type="date" id="pay_date" class="form-control form-control-sm read" required readonly>
                </div>

                <div class="col-md-3 mb-1 " id="residual">
                  <!-- Ingresar valor residual -->
                  <label class="bmd-label-floating">Ingresar valor residual u Opcion de compra</label>
                  <input type="text" id="residual_number_format" class="form-control form-control-sm read" onkeyup="format(this),passValue('residual_number',this.value)" placeholder="Ingresar valor residual" required>
                  <input type="hidden" id="residual_number">
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>
              </div>
              <div class="form-row mb-1 hideContent" id="content_1">

                <!-- empieza nueva fila-->


                <div class="col-md-4 mb-1">
                  <!-- DTF efectivo  -->
                  <label class="bmd-label-floating">DTF efectivo</label>
                  <input type="number" step=any id="dtf" class="form-control form-control-sm " placeholder="DTF efectivo" required>


                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>
                <div class="col-md-4 mb-1">
                  <!-- DTF efectivo  -->
                  <label class="bmd-label-floating">puntos de DTF</label>
                  <input type="number" step=any id="dtf_points" class="form-control form-control-sm " placeholder="puntos de DTF" required>

                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>
              </div>
              <div class="form-row mb-1 hideContent" id="content_2">
                <div class="col-md-4 mb-1">
                  <!-- IBR efectivo -->
                  <label class="bmd-label-floating">Ingresar IBR efectivo</label>
                  <input type="number" step=any id="ibr" class="form-control form-control-sm " placeholder="Ingresar IBR efectivo" required>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>
                <div class="col-md-4 mb-1">
                  <!-- puntos de IBR  -->
                  <label class="bmd-label-floating">puntos de IBR</label>
                  <input type="number" step=any id="ibr_points" class="form-control form-control-sm " placeholder="puntos de IBR" required>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Seleccione una opción válido.</div>
                </div>
              </div>
              <div class="form-row mb-1 hideContent" id="content_3">
                <div class="col-md-4 mb-1">
                  <!-- Tasa Fija  -->
                  <label class="bmd-label-floating">Tasa Fija</label>
                  <input type="number" step=any id="fixed_rate" class="form-control form-control-sm read" placeholder="Tasa Fija" required>

                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Seleccione una opción válido.</div>
                </div>
              </div>


              <!-- empieza nueva fila-->
              <div class="form-row mb-1 hideContent" id="antiguo">

                <div class="col-md-4 mb-1">
                  <!-- Ingresar valor inicial de desembolso -->
                  <label class="bmd-label-floating">Valor inicial de desembolso</label>
                  <input type="text" id="initial_value_format_initial" class="form-control form-control-sm read" placeholder="Ingresar valor inicial de desembolso" onkeyup="format(this),passValue('initial_value_initial',this.value)">
                  <input type="hidden" id="initial_value_initial">
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>

                <div class="col-md-4 mb-1">
                  <!-- Ingresar Fecha de desembolso -->
                  <h6 class="bmd-label-floating">Fecha de desembolso inicial</h6>
                  <input type="date" id="desembolso_date_initial" class="form-control form-control-sm read" placeholder="Ingresar Fecha de desembolso">
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione una fecha válida.</div>
                </div>

                <div class="col-md-4 mb-1">
                  <!-- Ingresar # de cuotas -->
                  <label class="bmd-label-floating">Ingresar plazo inicial</label>
                  <input type="text" pattern="[0-9]{0,3}" id="cuotes_number_initial" class="form-control form-control-sm read" placeholder="Ingresar # de cuotas ">
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Valor Maximo permitido es de 999 cuotas</div>
                </div>
              </div>

            </form>

          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
          <button type="submit" class="btn btn-primary" value="Submit" form="form_customers">Guardar</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal Amortization-->
  <div class="modal fade fullscreen-modal" id="AmortizationModal" tabindex="-1" role="dialog" aria-labelledby="AmortizationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="AmortizationModalLabel">Tabla de Amortización </h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="col-md-12">
            <div class="form-row mb-1">
              <div class="col-md-2 mb-1">
                <!-- Mostrar valores del modal de la tabla -->
                <label class="bmd-label-floating">Fecha de desembolso</label>
                <input type="text" id="fechaD" class="form-control form-control-sm read" required>
              </div>
              <div class="col-md-2 mb-1">
                <!-- ----------------------- -->
                <label class="bmd-label-floating">Valor inicial de desembolso</label>
                <input type="text" id="ValorInicial" class="form-control form-control-sm read" required>
              </div>
              <div class="col-md-2 mb-1">
                <!-- ------------------------- -->
                <label class="bmd-label-floating">Total cuotas</label>
                <input type="text" id="TotalC" class="form-control form-control-sm read" required>
              </div>
              <div class="col-md-2 mb-1">
                <!-- --------------------------->
                <label class="bmd-label-floating">Interes</label>
                <input type="text" id="intereses" class="form-control form-control-sm read" required>
              </div>
              <div class="col-md-2 mb-1">
                <!-- ------------------------------->
                <label class="bmd-label-floating">Puntos de Interes</label>
                <input type="text" id="Pinteres" class="form-control form-control-sm read" required>
              </div>
              <div class="col-md-2 mb-1">
                <!-- ------------------------------->
                <label class="bmd-label-floating">Tipo de interes</label>
                <input type="text" id="Tipointeres" class="form-control form-control-sm read" required>
              </div>
            </div>
            <div class="table-responsive">
              <table class="table  " data-order='[[ 1, "asc" ]]' data-page-length='25' id="lista-tabla" width="100%" cellspacing="0">
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="../../vendor/jquery/jquery.min.js"></script>
  <script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../../vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../../js/sb-admin-2.min.js"></script>
  <!-- Table amortization-->


  <!-- Page functión scripts -->
  <!-- Page level plugins -->
  <script src="../../vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="../../vendor/datatables/dataTables.bootstrap4.min.js"></script>



  <!-- Page level custom scripts -->

  <script src="../../js/functionsSite.js"></script>
  <script src="../../js/Storage.js"></script>
  <script src="../../js/table-filter.js"></script>
  <script src="../../js/table.js"></script>
  <script src="../../js/tableAmortization.js"></script>
  <script src="../../js/moment.js"></script>
  <script src="../../js/selectList.js"></script>
  <script type="text/javascript" src="js/obligation.js"></script>
  <script type="text/javascript" src="js/contract.js"></script>
  <script type="text/javascript" src="../../js/formatNumber.js"></script>
  <script>
    window.onload = loadView;
  </script>



</body>

</html>