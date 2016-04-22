<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListDeparture_Print.aspx.cs" Inherits="ListArrival_Print" %>

<!DOCTYPE html>





<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">


    <title>Departure List for <%=DateStart %></title>
</head>
<body>

    <%=UrlList %>
    <div style="text-align: center; margin: 20px">
        <img src="../images/holaShalom.png" />
    </div>


    <div style="margin-left: 6%; margin-right: 8%">

        <div style="text-align: center">

            <table id="g_departure"></table>
            <br />

        </div>
    </div>

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
    var url_list = '<%=UrlList%>';

</script>


<script>


    var timeFormatter = function (cellvalue, options, rowObject) {
        var timeArray = cellvalue.split(':');
        var hours = timeArray[0];
        var minutes = timeArray[1];

        var _time = ('0' + hours).slice(-2) + ':' + ('0' + minutes).slice(-2);

        return _time;
    }
    //var times = [];
    //function titleFormatter(cellvalue, options, rowObject) {
    //    // do something here
    //    var xxx = options;
    //    var yyy = rowObject.time;
    //    var uuu = rowObject.time;
    //    // var uuu = rowObject('PNR');


    //    if (!options.rowId.startsWith('g_departureghead')) {
    //        times.push(rowObject.time);
    //        //return rowObject.title+ ' ' + rowObject.time + '';

    //    }
    //    else
    //    {
    //    return ''
    //    }


    //}

    jQuery("#g_departure").jqGrid({
        caption: "Departure List for " + "<%=DateStart%>",
        url: url_list,
        datatype: "json",
        mtype: "GET",
        autowidth: false,
        width: 900,
        colModel: [
        { label: 'Hotel', name: 'hotel', index: 'hotel', width: 200 },
        { label: 'time', name: 'time', index: 'time', width: 60, hidden: true },
        { label: 'meeting_point', name: 'meeting_point', index: 'meeting_point', width: 60, stype: 'text', hidden: true, },
        { label: 'PNR', name: 'PNR', index: 'PNR', width: 60, stype: 'text', key: true, hidden: true },
        { label: ' ', name: 'title', index: 'title', width: 400 },
        { label: 'Phone', name: 'phone', index: 'phone', width: 80, datafield: 'phone', },
        {
            label: 'PAX', name: 'PAX', index: 'PAX', width: 50, align: "center", summaryTpl: "Sum: {0}",
            summaryType: "sum"
        },

        //{ label: 'Hotel', name: 'hotel', index: 'hotel', width: 100, sortable: false }
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
            displayField: ['hotel'],
            groupSummary: [false],
            groupColumnShow: [false],
            //groupText : ['<b>{0} - {1} Item(s)</b>']
            //groupText: ['<b style="color:green">{0} (PAX: {PAX})</b>']
            //groupText: ['{0}']
            //groupText: ['<b style="color:green">{0}---(PAX: {PAX})-------{phone}----{2}.text</b>']
            groupText: ['<div style="color:green">{0} PAX: {PAX}</div>']
        },

    });






</script>

