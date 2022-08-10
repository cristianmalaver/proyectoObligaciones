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

    <title>Renting Automayor</title>
    <!-- css link -->
    <?php include("../../php/viewHtml/cssLink.php") ?>
</head>

<body id="page-top">
    <div class="loadPage" id="loadPage"></div>
    <input type="hidden" id="User_id">


    <!-- Bootstrap core JavaScript-->
    <script src="../../vendor/jquery/jquery.min.js"></script>
    <script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../../vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../../js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <!-- <script src="../../vendor/chart.js/Chart.min.js"></script> -->

    <!-- Page level custom scripts -->
    <!-- <script src="../../js/demo/chart-area-demo.js"></script>
  <script src="../../js/demo/chart-pie-demo.js"></script> -->
    <script src="../../vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="../../vendor/datatables/dataTables.bootstrap4.min.js"></script>



    <!-- Page level custom scripts -->

    <script type="text/javascript" src="../../js/functionsSite.js"></script>
    <script type="text/javascript" src="../../js/Storage.js"></script>
    <script type="text/javascript" src="../../js/table-filter.js"></script>
    <script type="text/javascript" src="../../js/table.js"></script>
    <script type="text/javascript" src="../../js/tableAmortization.js"></script>
    <script type="text/javascript" src="../../js/moment.js"></script>
    <script type="text/javascript" src="../../js/selectList.js"></script>
    <script type="text/javascript" src="js/payObligation.js"></script>
    <!--<script type="text/javascript" src="js/home.js"></script>-->
    <script type="text/javascript" src="../../js/formatNumber.js"></script>
    <script>
        window.onload = function() {
            PayToSelect();
            //Pay('prueba5');

        };
    </script>

</body>

</html>