<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListTrans_IN_Print.aspx.cs" Inherits="ListArrival_Print" %>

<!DOCTYPE html>





<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">


    <title>Arrival List for <%=DateStart %></title>
</head>
<body>
        <div style="text-align: center;">

        <img src="../images/holaShalom.png" />
    </div>
        <div style="text-align: left; position:absolute; top:0; left:0 ">
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



    <table class="table table-striped table-bordered table-hover order-column compact" id="tblClients">
        <thead>
            <tr>
                <th>Hotel</th>
                <th>PNR</th>
                <th>Names</th>
                <th>PAX</th>
                <th>Phone</th>
                <!-- ko foreach: activities-->
                <td data-bind="text: $data"></td>
                <!-- /ko-->
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
                <td data-bind="text: hotel_name"></td>
                <td data-bind="text: PNR"></td>
                <td data-bind="text: names"></td>
                <td data-bind="text: PAX"></td>
                <td data-bind="text: phone"></td>
                <!-- ko foreach: activities-->
                <td data-bind="text: sum"></td>
                <!-- /ko-->
            </tr>
        </tbody>
    </table>

    <h3>Tour plan for this week</h3>

    <table class="table table-striped table-bordered table-hover order-column compact">
        <thead>
            <tr>
                <th>Name</th>
                <th>Date</th>
                <th>Time</th>
                <th>Comments</th>
            </tr>
            <tr id="trLoading_plan" style="display: inline-grid">
                <td colspan="7" style="text-align: center;">Loading...</td>
            </tr>
        </thead>

        <tbody data-bind="foreach: { data: tour_plan }">
            <tr>

                <td data-bind="text: activity_name"></td>
                <td data-bind="text: date"></td>
                <td data-bind="text: time"></td>
                <td data-bind="text: comments"></td>
            </tr>
        </tbody>
    </table>



    <div style="margin-left: 6%; margin-right: 8%">


        <div style="text-align: center">

            <table id="g_arrival"></table>
            <br />



        </div>
    </div>
    <table id="g_tour_plan"></table>


    <%--    <table class="table table-striped table-bordered table-hover" id="tblArrivals">
        <thead>
            <tr>
                <td>PNR    </td>
                <td>names   </td>
                <td>hotel            </td>
                <td>phone            </td>
                <td>PAX              </td>
                <td>MKF   </td>
                <td>VDN   </td>
                <td>FIG   </td>
                <td>MON   </td>



            </tr>
        </thead>
    </table>--%>
</body>
</html>
<style type="text/css">
    .test {
        font-weight: bold !important;
        color: blue;
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
<script>
        var api_url = '<%=ConfigurationManager.AppSettings["api_url"] %>'
</script>

<script src="../views_client/common.js"></script>

<script type="text/javascript">

    var date_start = '<%=DateStart%>';
    var date_end = '<%=DateEnd%>';
    var url_list = '<%=UrlList%>';
    var url_tour_plan = '<%=UrlPlan%>';
    // var url_tour_plan = '<%=UrlPlan%>';



</script>
<script>


    function ArrivalRow(data) {
        this.hotel_name = ko.observable(data.hotel_name);
        this.PNR = ko.observable(data.PNR);
        this.names = ko.observable(data.names);
        this.phone =  ko.observable(data.phone); 
        this.PAX =  ko.observable(data.PAX); 
        this.activities =  ko.observableArray([]);

        var mappedData = $.map(data.activities, function (item) {
            return new ActivityPair(item);
        });

        this.activities(mappedData);

        // this.activities =  ko.observableArray(data.activities); 
        //this.activities = ko.observableArray([data.activities]);
        //var mappedData = $.map(data.activities, function (item) {
        //    return new Activity(item);
        //});
        //this.activities(mappedData)
        //debugger;
    }

    function ActivityPair(data) {
        this.activity_fk =  ko.observable(data.activity_fk); 
        this.sum =  ko.observable(data.sum); 
    }

    function Event(data) {

        var d = new Date(data.date);
        this.date = ko.observable(d.yyyymmdd());

        var _t;
        if (data.time) {
            _t = data.time.HHmm();
        }
        this.time = ko.observable(_t);

        this.activity_name = ko.observable(data.activity_name);
        this.guide_name = ko.observable(data.guide_name);
        this.comments = ko.observable(data.comments);

    }



    function AppViewModel(data) {
        var self = this;
        self.passengers = ko.observableArray([]);
        self.activities = ko.observableArray([]);
        self.tour_plan = ko.observableArray([]);

        self.date = ko.observable();
        self.time = ko.observable();
        self.route = ko.observable();
        self.comments = ko.observable();
        self.guide_name = ko.observable();


        var Passengers = <%=Passengers %>;
        var ActivitiesNames = <%=ActivitiesNames %>;
        var TourPlan = <%=TourPlan %>;
        var DATA = <%=DATA %>;
  
        self.route(DATA.activity_name)
        var d = new Date(DATA.date);
        self.date(d.yyyymmdd());

        self.time(DATA.pickup_time.HHmm());
        self.comments(DATA.comments_trans);
        self.guide_name(DATA.guide_name);


        self.activities(ActivitiesNames);
        
        var mappedData = $.map(Passengers, function (item) {
            return new ArrivalRow(item);
        });
        $('#trLoading').hide();
        self.passengers(mappedData);

        var mappedData = $.map(TourPlan, function (item) {
            return new Event(item);
        });
        $('#trLoading_plan').hide();
        self.tour_plan(mappedData);



        //self.activities(self.passengers().activities)

    }
    // Activates knockout.js
    ko.applyBindings(new AppViewModel());

</script>

<%--<script>



    var zeroFormatter = function (cellvalue, options, rowObject) {
        if (cellvalue === 0) {
            cellvalue = '';
        }

        return cellvalue;
    }


    var timeFormatter = function (cellvalue, options, rowObject) {
        var timeArray = cellvalue.split(':');
        var hours = timeArray[0];
        var minutes = timeArray[1];

        var _time = ('0' + hours).slice(-2) + ':' + ('0' + minutes).slice(-2);

        return _time;
    }


    jQuery("#g_arrival").jqGrid({
        url: url_list,
        datatype: "json",
        mtype: "GET",
        autowidth: false,

        colModel: [
        { label: 'Hotel', name: 'hotel_name', index: 'hotel', width: 200 },
        { label: 'PNR', name: 'PNR', index: 'PNR', width: 60, stype: 'text', key: true, sortable: false },
        { label: 'Names', name: 'names', index: 'names', width: 350 },
        { label: 'Phone', name: 'phone', index: 'phone', width: 80 },
        { label: 'PAX', name: 'PAX', index: 'PAX', width: 30, align: "center", },
        //{ label: 'MKF', name: 'MKF', index: 'MKF', width: 30, align: "center", formatter: zeroFormatter },
        //{ label: 'VDN', name: 'VDN', index: 'VDN', width: 30, align: "center", formatter: zeroFormatter },
        //{ label: 'FIG', name: 'FIG', index: 'FIG', width: 30, align: "center", formatter: zeroFormatter },
        //{ label: 'MON', name: 'MON', index: 'MON', width: 30, align: "center", formatter: zeroFormatter },


        { label: 'Hotel', name: 'hotel', index: 'hotel', width: 100, sortable: false }
        ],
        rowNum: 20,
        height: 'auto',
        sortname: 'hotel',
        loadonce: false,
        viewrecords: true,
        sortorder: "desc",
        grouping: true,
        groupingView: {
            groupField: ['hotel'],
            groupColumnShow: [false],
            //groupText : ['<b>{0} - {1} Item(s)</b>']
            groupText: ['<b style="color:green">{0}</b>']
        },

        caption: "Arrival List for " + "<%=DateStart%>",
    });


    $("#g_tour_plan").jqGrid({
        // url: url_tour_plan,
        data: "[{'comments':'sdfsdf'}]",
        datatype: 'json',
        colModel: [
            {
                label: 'Date', name: 'date', width: 50,
                align: "center",
                formatter: 'date',
                formatoptions: { srcformat: "ISO8601Long", newformat: "Y-m-d" },
            },

            { label: 'Time', name: 'time', align: "center", width: 40, formatter: timeFormatter },
            { label: 'Tour', name: 'activity_name', align: "center", width: 60 },
            { label: 'Comments', name: 'comments', align: "center", width: 90 },


        ],
        loadonce: false,
        width: 780,
        height: 'auto',
        shrinkToFit: true,
        altRows: true,
        rownumbers: true,
        caption: "Tour plan for "+ "<%=DateStart%>"+ " to " + "<%=DateEnd%>",
    });







</script>--%>
