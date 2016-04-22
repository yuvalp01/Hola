<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListArrival_Print.aspx.cs" Inherits="ListArrival_Print" %>

<!DOCTYPE html>





<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">


    <title>Arrival List for <%=DateStart %></title>
</head>
<body>


    <div style="text-align:center; margin:20px">   <img src="../images/holaShalom.png" /></div>

  

    <div style="margin-left:6%; margin-right:8%">
       
        
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

<link href="../components/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<link href="../scripts/jqGrid/ui.jqgrid.css" rel="stylesheet" />

<script src="../scripts/jquery-2.2.1.min.js"></script>
<script src="../components/jquery-ui/jquery-ui.min.js"></script>
<script src="../scripts/jqGrid/grid.locale-en.js"></script>
<script src="../scripts/jqGrid/jquery.jqGrid.min.js"></script>



<script type="text/javascript">

    var date_start = '<%=DateStart%>';
    var date_end = '<%=DateEnd%>';
    var url_list = '<%=UrlList%>';
    var url_tour_plan = '<%=UrlPlan%>';


</script>


<script>



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
        { label: 'Hotel', name: 'hotel', index: 'hotel', width: 200 },
        { label: 'PNR', name: 'PNR', index: 'PNR', width: 60, stype: 'text', key: true, sortable: false },
        { label: 'Names', name: 'names', index: 'names', width: 350 },
        { label: 'Phone', name: 'phone', index: 'phone', width: 80 },
        { label: 'PAX', name: 'PAX', index: 'PAX', width: 30, align: "center", },
        { label: 'MKF', name: 'MKF', index: 'MKF', width: 30, align: "center", formatter: zeroFormatter },
        { label: 'VDN', name: 'VDN', index: 'VDN', width: 30, align: "center", formatter: zeroFormatter },
        { label: 'FIG', name: 'FIG', index: 'FIG', width: 30, align: "center", formatter: zeroFormatter },
        { label: 'MON', name: 'MON', index: 'MON', width: 30, align: "center", formatter: zeroFormatter },


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
        url: url_tour_plan,
        datatype: 'json',
        colModel: [
            {
                label: 'Date', name: 'date', width: 50,
                align: "center",
                formatter: 'date',
                formatoptions: { srcformat: "ISO8601Long", newformat: "Y-m-d" },
            },

            { label: 'Time', name: 'time', align: "center", width: 40, formatter: timeFormatter },
            { label: 'Tour', name: 'tour', align: "center", width: 60 },
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







</script>