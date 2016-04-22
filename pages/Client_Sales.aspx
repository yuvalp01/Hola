<%@ Page Title="Update Sales" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="Client_Sales.aspx.cs" Inherits="pages_Client_Sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .ui-dialog-titlebar, ui-widget-header {
            background-color: #d9edf7 !important;
            background-image: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-pencil  fa-fw"></i>Update Sales</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>

    <div class="row">


        <div id="div_add" style="display: none;" class="alert alert-info alert-dismissible round" role="alert">

            <form class="form-inline panel panel-default" style="padding: 5px">

                <div class="form-group ">
                    <label>Service</label>


                    <select id="ddlTours" required="required" class="form-control margin-bottom-14" style="display: inline; width: 200px" data-bind="


    options: products,
    optionsText: 'name',
    optionsValue: 'ID',
    value: product_fk,
    optionsCaption: 'Select Service',
    valueAllowUnset: true
">
                    </select>

                </div>
                <div class="form-group">

                    <label>People</label>

                    <input type="number" style="width: 60px" class="form-control" data-bind="value: persons, attr: { max: persons_max }" min="1" id="txtP" />

                </div>

                <div id="rblType" class="form-group">

                    <label class="radio-inline" data-toggle="tooltip" data-placement="bottom"  title="Business - pre-order by agency">
                        <input type="radio" data-bind="checked: sale_type" value="BIZ" />BIZ</label>
                    <label class="radio-inline" data-toggle="tooltip" data-placement="bottom"  title="Private - order by the client">
                        <input type="radio" data-bind="checked: sale_type" value="PRI" />PRI</label>

                </div>
                <div class="form-group ">

                    <input id="btnAdd" class="btn btn-primary" data-bind="click: add" type="button" value="Add" />

                </div>

                <div class="form-group has-error has-feedback">

                    <div>

                        <span id="lblFeedback" style="display: none" class="help-block">Please enter a valid email address</span>
                    </div>
                </div>
            </form>



            <table class="table table-striped table-bordered table-hover order-column compact" id="tbl_sales" style="width:100%">
                <thead>
                    <tr>
                        <th>Service</th>
                        <th>Persons</th>
                        <th>Type</th>
                    </tr>
                </thead>
            </table>
        </div>

    </div>
    <div class="row">

        <div id="div_advanced"  class="well">
            <label>Search Options:</label>
                <input id="txtSearchBox" type="text" style="display: inline; width: 200px" class="form-control margin-bottom-14" placeholder="Free text" />


            <select id="ddlAgency" class="form-control margin-bottom-14" style="display: inline; width: 180px" data-bind="


    options: agencies,
    optionsText: 'name',
    optionsValue: 'name',
    value: agency_filter_name,
    optionsCaption: 'Show All Agencies',
    valueAllowUnset: true
">
            </select>

            <input id="txtDateArr" type="text" style="display: inline; width: 200px" class="form-control margin-bottom-14" placeholder="Arrival Date" data-bind="value: date_arr_filter" />

        </div>



        <table class="table table-striped table-bordered table-hover order-column compact" id="tblSearch">
            <thead>
                <tr>
                    <th>PNR</th>
                    <th>Names</th>
                    <th>PAX</th>
                    <%--                    <th>Arrival#</th>--%>
                    <th>Arrival Date</th>
                    <%--                    <th>Departure#</th>
                    <th>Departure Date</th>
                    <th>Hotel</th>--%>
                    <th>Agency</th>
                </tr>
            </thead>
        </table>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="Server">

    <link href="../Content/DataTables/css/buttons.dataTables.css" rel="stylesheet" />

    <script src="../scripts/DataTables/dataTables.buttons.js"></script>
    <script src="../scripts/jszip.min.js"></script>
    <script src="../scripts/pdfmake.min.js"></script>
    <script src="../scripts/vfs_fonts.js"></script>
    <script src="../scripts/DataTables/buttons.html5.js"></script>
    <script src="../scripts/DataTables/buttons.print.js"></script>

    <script src="../views_client/view_update_sales.js"></script>

    <script>

        var my = { viewModel: new SaleViewModel() };
        ko.applyBindings(my.viewModel);
        var dataTable;
        var search = '<%=Search%>';
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip()
            $("#txtDateArr").datepicker({ dateFormat: 'yy-mm-dd' });



             dataTable = $('#tblSearch').DataTable({
                 "ajax": url_search,
                "pageLength": 10,
                "bLengthChange": false,
                //"sDom": '<"top"i>rt<"bottom"flp><"clear">',
                "dom": '<"toolbar">rtip',
                "sAjaxDataProp": "",
                "autoWidth": true,
                "columns": [

                            { "data": "PNR", "width": "50px" },
                            { "data": "names", "width": "180px" },
                            { "data": "PAX", "width": "70px" },
                            //{ "data": "num_arr" },
                            { "data": "date_arr" },
                            //{ "data": "num_dep" },
                            //{ "data": "date_dep" },
                            //{ "data": "hotel" },
                            { "data": "agency" }
                ],
                "columnDefs": [
                            { type: "phoneNumber", targets: 0 },
                            {
                                "render": function (data, type, row) {
                                    return new Date(data).yyyymmdd();

                                },
                                "targets": 3
                            },

                ],

            });

            if (search != '') {
                $('#txtSearchBox').val(search);
                dataTable.search(search).draw();
            }

            $('#tblSearch tbody').on('click', 'tr', function () {

                var tr = $(this).closest('tr');
                var data = dataTable.row(tr).data();

                my.viewModel.PNR(data.PNR);
                my.viewModel.names(data.names);
                my.viewModel.persons(data.PAX);
                my.viewModel.persons_max(data.PAX);
                my.viewModel.show_table();

                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                    //alert("remove");
                }
                else {
                    dataTable.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                    //alert("add");
                }

                $("#div_add").dialog({
                    width: 650,
                    title: "[" + data.PNR + "] " + data.names
                });

            });


            $("#txtSearchBox").on("keyup search input paste cut", function () {
                dataTable.search(this.value).draw();
            });

            //$("div.toolbar").append($("#ddlAgency"));
            //$("div.toolbar").append($("#txtDateArr"));
            //$("div.toolbar").append($("#txtSearchBox"));

        });




    </script>
</asp:Content>
