<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListTrans_OUT_Print.aspx.cs" Inherits="ListArrival_Print" %>

<!DOCTYPE html>





<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">

    <style>
        tr.group,
        tr.group:hover {
            background-color: #ddd !important;
            font-weight:bold;
        }
    </style>
    <title>Departure List for <%=DateStart %></title>
</head>
<body>
    <div style="text-align: center;">

        <img src="../images/holaShalom.png" class="auto-style1" />
    </div>
    <div style="text-align: left; position: absolute; top: 0; left: 0">
        <img title="Transportation" src="../icons/fa-train.png" /><span style="margin-left: 5px; margin-right: 5px" class="label label-default" data-bind="text: route"></span>
        <img title="Pickup Date" src="../icons/fa-calendar.png" /><span style="margin-left: 5px; margin-right: 5px" class="label label-default" data-bind="text: date"></span>

    </div>


    <%--    
        <div data-bind="foreach: { data: activities }">
            TODO: put those as title:
              <span data-bind="text:$data"></span>!
        </div>

    <div data-bind="foreach: { data: passengers }">
        <div data-bind="foreach: { data: activities } ">
            <span data-bind="text:activity_fk"></span>:
            <span data-bind="text: sum()"></span>
        </div>
    </div>--%>

    <hr />
    <div class="well">

        <h4>Pickup Time: <span class="label label-default" data-bind="text:time"></span>
            By:  <span class="label label-default" data-bind="text:guide_name"></span>
            Driver's Details:  <span class="label label-default" data-bind="text:comments"></span>

        </h4>




    </div>



    <table id="tblDepart" style="width: 100%" class="table table-striped table-bordered table-hover order-column compact">
        <thead style="display: none">
            <tr>
                <th>Hotel</th>
                <th>PNR</th>
                <th>Names</th>
                <th>PAX</th>
                <th>Phone</th>

            </tr>
            <tr id="trLoading" style="display: inline-grid">
                <td colspan="7" style="text-align: center;">Loading...</td>
            </tr>
        </thead>

        <tbody data-bind="foreach: { data: passengers }">
            <tr>
                <%--                <td>
                    <img class="edit" title="Edit Reservation" src="../icons/fa-pencil.png" />
                    <img class="trans" title="Transportation" src="../icons/fa-train.png" />
                    <img class="sale" title="Tours" src="../icons/tourguide.png" />

                </td>--%>
                <td data-bind="text: title"></td>
                <%--                <td data-bind="text: hotel_name"></td>
                <td data-bind="text: time"></td>--%>
                <td data-bind="text: PNR"></td>
                <td data-bind="text: names"></td>
                <td data-bind="text: PAX"></td>
                <td data-bind="text: phone"></td>

            </tr>
        </tbody>
    </table>

    <br />
    <br />
    <br />
    <br />





    <%--      <table id="tblDepart" class="table table-striped table-bordered table-hover order-column compact" >
        <thead>
            <tr>
                <th>Hotel</th>
                <th>PNR</th>
                <th>Names</th>
                <th>PAX</th>
                <th>Phone</th>

            </tr>
            <tr id="trLoading" style="display: inline-grid">
                <td colspan="7" style="text-align: center;">Loading...</td>
            </tr>
        </thead>

        <tbody data-bind="foreach: { data: passengers }">
            <tr>
                <td data-bind="text: hotel_name"></td>
                <td data-bind="text: PNR"></td>
                <td data-bind="text: names"></td>
                <td data-bind="text: PAX"></td>
                <td data-bind="text: phone"></td>

            </tr>
        </tbody>
    </table>--%>
</body>
</html>
<style type="text/css">
    .test {
        font-weight: bold !important;
        color: blue;
    }

    .auto-style1 {
        width: 241px;
        height: 60px;
    }
</style>


<!-- Bootstrap Core CSS -->
<link href="../Content/bootstrap.min.css" rel="stylesheet" />
<!-- Bootstrap datatables CSS -->
<link href="../Content/DataTables/css/dataTables.bootstrap.min.css" rel="stylesheet" />
<%--<link href="Content/DataTables/css/jquery.dataTables.css" rel="stylesheet" />--%>
<!-- jq UI -->
<link href="../components/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<!-- MetisMenu CSS -->
<link href="../components/metisMenu/dist/metisMenu.min.css" rel="stylesheet" />
<!-- Custom CSS -->
<link href="../Content/sb-admin-2.css" rel="stylesheet" />
<!-- Custom Fonts -->
<link href="../fonts/font-awesome-4.5.0/css/font-awesome.min.css" rel="stylesheet" />

<!-- jQuery -->
<script src="../scripts/jquery-2.2.1.min.js"></script>
<!-- jQuery datatables -->
<script src="../scripts/DataTables/jquery.dataTables.min.js"></script>
<script src="../scripts/DataTables/dataTables.bootstrap.min.js"></script>
<!-- jQuery UI -->
<script src="../components/jquery-ui/jquery-ui.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="../scripts/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="../components/metisMenu/dist/metisMenu.min.js"></script>




<!-- Custom Theme JavaScript -->
<script src="../scripts/sb-admin-2.js"></script>

<script src="../scripts/knockout-3.4.0.js"></script>

<link href="../Content/DataTables/css/buttons.dataTables.css" rel="stylesheet" />
<script src="../scripts/DataTables/dataTables.buttons.js"></script>
<script src="../scripts/jszip.min.js"></script>
<script src="../scripts/pdfmake.min.js"></script>
<script src="../scripts/vfs_fonts.js"></script>
<script src="../scripts/DataTables/buttons.html5.js"></script>
<script src="../scripts/DataTables/buttons.print.js"></script>
<script>
    var api_url = '<%=ConfigurationManager.AppSettings["api_url"] %>'
</script>

<script src="../views_client/common.js"></script>

<script type="text/javascript">

    var date_start = '<%=DateStart%>';
    var date_end = '<%=DateEnd%>';
    var url_list = '<%=UrlList%>';

</script>
<script>


    function ArrivalRow(data) {
        this.hotel_name = ko.observable(data.hotel_name);
        this.PNR = ko.observable(data.PNR);
        this.names = ko.observable(data.names);
        this.phone =  ko.observable(data.phone); 
        this.PAX =  ko.observable(data.PAX); 

        var t = data.time.HHmm();
        this.time =  ko.observable(t); 
        this.title =  ko.observable( t + ": "+data.hotel_name ); 
        this.activities =  ko.observableArray([]);

        var mappedData = $.map(data.activities, function (item) {
            return new ActivityPair(item);
        });

        this.activities(mappedData);
    }

    function ActivityPair(data) {
        this.activity_fk =  ko.observable(data.activity_fk); 
        this.sum =  ko.observable(data.sum); 
    }

    function Event(data) {

        var d = new Date(data.date);
        this.date = ko.observable(d.yyyymmdd());
        var t = data.time;
        this.time = ko.observable(t.HHmm());
        this.activity_name = ko.observable(data.activity_name);
        this.guide_name = ko.observable(data.guide_name);
        this.comments = ko.observable(data.comments);

    }



    function AppViewModel(data) {
        var self = this;
        self.passengers = ko.observableArray([]);
        self.activities = ko.observableArray([]);
        self.events = ko.observableArray([]);


        self.date = ko.observable();
        self.time = ko.observable();
        self.route = ko.observable();
        self.comments = ko.observable();
        self.guide_name = ko.observable();


        var Passengers = <%=Passengers %>;
        var DATA = <%=DATA %>;
  
        self.route(DATA.activity_name)
        var d = new Date(DATA.date);
        self.date(d.yyyymmdd());

        self.time(DATA.pickup_time.HHmm());
        self.comments(DATA.comments_trans);
        self.guide_name(DATA.guide_name);

        //$.getJSON('',data, function () {
    
        //});


        var mappedData = $.map(Passengers, function (item) {
            return new ArrivalRow(item);
        });
        $('#trLoading').hide();
        self.passengers(mappedData);



    }
    // Activates knockout.js
    ko.applyBindings(new AppViewModel());

</script>

<script>

    $(document).ready(function() {
        $('#tblDepart').DataTable( {

            "columnDefs": [
                { "visible": false, "targets": 0}
            ],

            "drawCallback": function ( settings ) {
                var api = this.api();
                var rows = api.rows( {page:'current'} ).nodes();
                var last=null;
 
                api.column(0, {page:'current'} ).data().each( function ( group, i ) {
                    if ( last !== group ) {
                        $(rows).eq( i ).before(
                            '<tr class="group"><td colspan="4">'+group+'</td></tr>'
                        );
 
                        last = group;
                    }
                } );

            },
            "paging":   false,
            "sorting": false,
            "searching": false,
            "info": false,
            //dom: 'Bfrtip',
            //buttons: [
            //    'excel','copy', 'csv', 'pdf',  'print'
            //]
        } );
    } );


</script>

