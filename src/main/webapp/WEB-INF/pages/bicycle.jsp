<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

<script type="text/javascript" src ="webjars/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.3/js/responsive.bootstrap.min.js"></script>
<script type="text/javascript">
   var bicycleStationsTable;
   $(function () {
        $("#bicycleStations").hide();
        bicycleStationsTable = $('#bicycleStationsTable').DataTable({
            "sPaginationType": "full_numbers",
            "bDestroy": true,
            'bAutoWidth': false,
            "info": false,
            "columnDefs": [
                {"orderable": false, "targets": [1, 2, 5]},
                {className: "action-btn-column", "targets": [5]},
                {width: "120px", "targets": [1, 2]},
                {width: "100px", "targets": [0]}
            ],
            "order": [
                [0, "asc"]
            ],
            responsive: true
        });

    $ ("#search-form").submit(function(event){
       // stop submit the form, we will post it manually.
        event.preventDefault();
        searchStationsByCity();
    });
});

function searchStationsByCity () {
    $("#bicycleStations").show();
    //$('#loadingModal').modal('show');
    bicycleStationsTable.clear().draw();
    var city = $("#city").val();
    $("#btn-search").prop("disabled", true);
    $.ajax({
        type: "GET",
        contentType: "application/json",
        url: "/api/search/" + city,
        dataType: 'json',
        cache: false,
        timeout: 600000,
        success: function (data) {
            $("#btn-search").prop("disabled", false);
            var stations = data;
            for (var b in stations) {
                bicycleStationsTable.row.add([
                    stations[b].name,
                    stations[b].lat,
                    stations[b].lon,
                    stations[b].capacity,
                    'get by query',
                    '<i title="title" class="action-btn material-icons text-danger" data-original-title="view" onclick="reverseBoxAsOpened()">open_with</i>'
                ]).node().id = stations[b].id;
                bicycleStationsTable.draw();
            }

            //$('#loadingModal').modal('hide');
        },
        error: function (e) {
            var json = "<h4>Ajax Response</h4><pre>"+ e.responseText + "</pre>";
            $('#error-msg').innerHTML=json;
            console.log("ERROR : ", e);
            $("#btn-search").prop("disabled", false);
        }
    });
}
</script>

    <link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />


        <!--<spring:url value="/css/main.css" var="springCss" />
        <link href="${springCss}" rel="stylesheet" />

    <c:url value="/css/main.css" var="jstlCss" />
    <link href="${jstlCss}" rel="stylesheet" />-->

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.20/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap.min.css"/>

</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Bicycle Sharing Stations</a>

        </div>
        <!--	<div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#about">About</a></li>
                </ul>
            </div> -->
    </div>
</nav>

<div class="container">
    <p>The Semantic Web project is a large and long practical exercise that consists in integrating all the pieces that have been seen during the first sessions into a consolidated Web application. To make sure you can advance sufficiently fast to cover everything, you are allowed to work by pair.</p>
    <div class="starter-template">
<!--        <h2>Message: ${message}</h2>-->
        <section id="error-msg" class="error"></section>
        <div class="card">
            <div class="card-body">
                <form class = "form-horizontal" id="search-form">
                    <div class="form-group row">
                        <label for="city" class="col-sm-3 control-label">Select a City<span
                                class="text-danger">*</span></label>
                        <div class="col-sm-7">
                            <select class="form-control" id="city" name="city">
                                <option value="SAINT-ETIENNE">SAINT-ETIENNE</option>
                                <option value="LYON">LYON</option>
                                <option value="TOULOUSE">TOULOUSE</option>
                            </select>
                        </div>

                        <div class="col-sm-2">
                            <button id="btn-search" type="submit" class="btn btn-primary float-right">Search</button>
                        </div>
                    </div>
                </form>
                <br/>
                <div class="row" id="bicycleStations">
                    <table id="bicycleStationsTable" class="table table-striped table-bordered dt-responsive nowrap">
                        <thead>
                        <tr>
                            <th>Station Name</th>
                            <th>Latitude</th>
                            <th>Longitude</th>
                            <th>Capacity</th>
                            <th>Available</th>
                            <th>More</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div
    </div>
</div>
<div class = "container">
    <footer class="page-footer font-small blue fixed-bottom">
        <div class="footer-copyright text-center py-3">© 2020 Copyright: Semantic Web
        </div>
    </footer>
</div>

<div class="modal fade" id="loadingModal" tabindex="-1" role="dialog" data-backdrop="static" area-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="loader"></div>
            </div>
        </div>
    </div>
</div>

</body>

</html>
