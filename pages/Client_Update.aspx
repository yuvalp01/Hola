<%@ Page Title="Update Reservation" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="Client_Update.aspx.cs" Inherits="pages_Client_Update" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .ui-dialog-titlebar, ui-widget-header {
            background-color: #d9edf7 !important;
            background-image: none !important;
        }

        img.edit {
            margin-right: 6px;
            margin-left: 3px;
        }

        img.trans {
            margin-right: 10px;
        }

        #tbl_sales_wrapper {
            margin: 3px;
        }

        /*#modal_sale div.modal-content {
        
        padding:3px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-pencil  fa-fw"></i>Update Reservation</h1>
        </div>
    </div>

    <div class="row">

        <div id="modal_edit" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-admin " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-8" style="padding-left: 0px;">
                                        <div class="col-lg-12">
                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    <i class="fa fa-pencil-square-o  fa-fw"></i>
                                                    General Info
                                                </div>
                                                <!-- /.panel-heading -->
                                                <div class="panel-body form-inline">

                                                    <div class="form-group ">
                                                        <label class="control-label">Agency*</label>
                                                        <select disabled="disabled" class="form-control margin-bottom-14" required="required" data-bind="
    options: agencies,
    optionsText: 'name',
    optionsValue: 'ID',
    value: agency_fk,
    optionsCaption: 'Select Agency',
    valueAllowUnset: true
">
                                                        </select>

                                                    </div>


                                                    <div class="form-group">
                                                        <label class="control-label">Hotel*</label>
                                                        <select class="form-control margin-bottom-14" required="required" data-bind="
    options: hotels,
    optionsText: 'name',
    optionsValue: 'ID',
    value: hotel_fk,
    optionsCaption: 'Select Hotel',
    valueAllowUnset: true
">
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="personal_info" class="col-lg-7">
                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    <i class="fa fa-user fa-fw"></i>
                                                    Personal Info
                       
                                                </div>

                                                <div class="panel-body ">

                                                    <div class="form-group">
                                                        <label class="control-label">Client Names*</label>
                                                        <input data-bind="value: names" id="txtNames" required="required" class="form-control" placeholder="Client Names" />

                                                    </div>

                                                    <div class="form-group " <%-- data-bind="css: { 'has-warning': PNR() == '' } "--%>>
                                                        <label class="control-label">PNR*</label>

                                                        <input data-bind="value: PNR" id="txtPNR" readonly="readonly" required="required" class="form-control" placeholder="PNR" />
                                                    </div>

                                                    <div class="form-group ">
                                                        <label class="control-label">PAX*</label>
                                                        <input type="number" data-bind="value: PAX" style="width: 50px;" min="1" max="99" id="txtPAX" required="required" class="form-control" />

                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Phone Number</label>
                                                        <input type="tel" data-bind="value: phone" id="txtPhone" class="form-control" placeholder="Phone Number" />

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="flight_info" class="col-lg-5">
                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    <i class="fa fa-plane fa-fw"></i>
                                                    Flights Info
                       
                                                </div>
                                                <!-- /.panel-heading -->
                                                <div class="panel-body ">

                                                    <div class="form-group">
                                                        <label class="control-label">Arrival Date*</label>
                                                        <label style="font-weight: normal; margin-left: 5px">

                                                            <input data-bind="checked: oneway" id="cbIsOw" type="checkbox" />
                                                            One Way
                                                        </label>

                                                        <input id="txtDateArr" required="required" class="form-control date" data-bind="value: date_arr" placeholder="Pick Arrival Date" />
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">Arrival Flight*</label>

                                                        <select id="ddlFlightArr" required="required" class="form-control margin-bottom-14" data-bind=" click: function () { $root.arrival_validation(); },

    options: flights_filter_arr,
    optionsText: 'details',
    optionsValue: 'num',
    value: num_arr,
    optionsCaption: 'Select Arrival Date',
    valueAllowUnset: true
">
                                                        </select>

                                                    </div>
                                                    <div id="div_dep">
                                                        <div class="form-group">
                                                            <label class="control-label">Departure Date</label>
                                                            <input id="txtDateDep" required="required" class="form-control date" data-bind="value: date_dep" placeholder="Pick Departure Date" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label">Departure Flight</label>


                                                            <select id="ddlFlightDep" required="required" class="form-control margin-bottom-14" data-bind="click: function () { $root.departure_validation(); },

    options: flights_filter_dep,
    optionsText: 'details',
    optionsValue: 'num',
    value: num_dep,
    optionsCaption: 'Select Departure Date',
    valueAllowUnset: true
">
                                                            </select>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>


                                        </div>

                                        <div class="col-lg-12">

                                            <div class="form-group">
                                                <label>Comments</label>

                                                <textarea data-bind="value: comments" id="txtComments" class="form-control"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <button data-bind="click: $root.UpdateClient" id="btn_update" class="btn btn-primary" type="button">Save</button>
                                                <button data-bind="click: $root.cancel_client" class="btn btn-danger" type="button">Delete</button>
                                                <button id="btn_close" class="btn btn-default" type="button">Close</button>

                                            </div>


                                        </div>



                                    </div>




                                    <div class="col-lg-4">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                System Feedback
                       
                                            </div>
                                            <!-- /.panel-heading -->
                                            <div id="system_feedback" class="panel-body">
                                                <div id="message_info" style="display: none;" class="alert alert-info  alert-dismissable">
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                                    <%--                                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. <a href="#" class="alert-link">Alert Link</a>.--%>
                                                </div>
                                                <div id="message_success" style="display: none;" class="alert alert-success alert-dismissable">
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>

                                                </div>
                                                <div id="message_warning" style="display: none" class="alert alert-warning alert-dismissable">
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>


                                                </div>
                                                <div id="message_danger" style="display: none" class="alert alert-danger alert-dismissable">
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>


                                                </div>
                                            </div>
                                            <!-- .panel-body -->
                                        </div>
                                        <!-- /.panel -->
                                    </div>

                                    <!-- /.col-lg-6 (nested) -->
                                </div>
                                <!-- /.row (nested) -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <%--                        <input id="btnUpdate" class="btn btn-primary" data-bind="click: update" type="button" value="Update" />--%>
                    </div>
                </div>
            </div>
        </div>



        <div id="modal_trans" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-inline panel panel-default" style="padding: 5px">

                            <div class="row">

                                <div class="col-lg-6" data-bind="foreach: { data: products_trans }">
                                    <div class="input-group col-lg-12">
                                        <span class="input-group-addon">
                                            <input type="radio" data-bind="attr: { id: 'rb_' + ID(), value: ID, 'data-rate': rate }, checked: $root.trans_product_fk" name="trans_type" />

                                        </span>
                                        <input data-bind="value: name() + ' (Rate:' + rate() + ')'" readonly="readonly" class="form-control" />
                                    </div>
                                </div>


                                <div class="col-lg-6">

                                    <div class="form-group">
                                        <label class="control-label">Current Price</label>
                                        <input class="form-control" type="number" style="width: 70px" data-bind="value: trans_price" min="0" step="1" />
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Comments</label>
                                        <br />
                                        <textarea cols="30" class="form-control" data-bind="value: trans_comments"></textarea>
                                    </div>
                                 
                                        <div>
                                            <span id="lblFeedback_trans" data-bind="text: feedback_trans" style="display: block; color: red" class="has-warning"></span>
                                        </div>
                                    
                                </div>
                            </div>

                        </form>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <input class="btn btn-primary" data-bind="click: update_transport" type="button" value="Update" />
                    </div>
                </div>
            </div>
        </div>



        <div id="modal_sale" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-inline panel panel-default" style="padding: 5px">
                            <div class="form-group">
                                <label class="control-label">Service:</label>
                                <select id="ddlTours" required="required" class="form-control margin-bottom-14" style="display: inline; width: 200px" data-bind="
    options: products_tour,
    optionsText: 'name',
    optionsValue: 'ID',
    value: product_fk,
    optionsCaption: 'Select Service',
    valueAllowUnset: true
">
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="control-label">People</label>
                                <input type="number" style="width: 60px" class="form-control" data-bind="value: persons, attr: { max: persons_max }" min="1" id="txtP" />
                            </div>
                            <div id="rblType" class="form-group">

                                <label class="radio-inline" data-toggle="tooltip" data-placement="bottom" title="Business - pre-order by agency">
                                    <input type="radio" data-bind="checked: sale_type" value="BIZ" />BIZ</label>
                                <label class="radio-inline" data-toggle="tooltip" data-placement="bottom" title="Private - order by the client">
                                    <input type="radio" data-bind="checked: sale_type" value="PRI" />PRI</label>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Price per Person</label>
                                <input type="number" step="any" required="required" style="width: 70px" class="form-control" data-bind="value: price" />
                            </div>
                            <div class="form-group">

                                <textarea placeholder="Comments" style="width: 555px; margin-top: 5px; margin-bottom: -5px" data-bind="textInput: sale_comments" class="form-control"></textarea>



                            </div>

                            <div class="form-group has-error has-feedback">
                                <div>
                                    <span id="lblFeedback" data-bind="text: feedback_sale" style="display: block; color: red" class="has-warning"></span>
                                </div>
                            </div>
                        </form>
                    </div>

                    <table id="tbl_sales" class="table table-striped table-bordered table-hover order-column compact" style="width: 98%; margin-left: 5px;">
                        <thead>
                            <tr>
                                <th>Service</th>
                                <th>Persons</th>
                                <th>Type</th>
                                <th title="Price per Person">Price</th>
                                <th style="width: 240px">Comments</th>
                                <th style="width: 100px"></th>

                            </tr>
                        </thead>

                        <tbody data-bind="foreach: { data: sales }">
                            <tr>
                                <td data-bind="text: product_name"></td>
                                <td>
                                    <span data-bind="text: persons, visible: !(editable())"></span>
                                    <input class="form-control" type="number" step="any" min="1" max="" data-bind="attr: {'max': $parent.PAX}, value: persons, visible: editable" style="width: 50px" />

                                </td>
                                <td data-bind="text: sale_type"></td>
                                <td>
                                    <%--                                    visible: !(editable()),--%>
                                    <%--                                    <button data-bind="click: $parent.edit_mode, text: editBtnText, css: editBtnClass"></button>--%>
                                    <span data-bind="text: price, visible: !(editable())"></span>
                                    <%--, event: { blur: $parent.updatePrice }--%>
                                    <input class="form-control" type="number" step="any" min="0" data-bind="value: price, visible: editable" style="width: 70px" />

                                </td>
                                <td>

                                    <%--                                    <button data-bind="click: $parent.edit_mode, text: editBtnText, css: editBtnClass"></button>--%>
                                    <span data-bind="text: comments, visible: !(editable())"></span>
                                    <textarea class="form-control" data-bind=" value: comments, visible: editable"></textarea>



                                </td>
                                <td>
                                    <button data-bind="click: $parent.edit_mode, text: editBtnText, css: editBtnClass"></button>
                                    <%--                                    <button class="btn btn-info btn-circle" title="Cancel Action" data-bind="click: $parent.edit_mode"></button>--%>
                                    <button class="btn btn-danger btn-circle" title="Delete Sale" data-bind="click: $parent.cancel">Del</button>
                                </td>


                            </tr>
                        </tbody>
                    </table>




                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <input id="btnAdd" class="btn btn-primary" data-bind="click: add" type="button" value="Add" />
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="row">


        <div id="div_advanced" style="display: block" class="well">
            <label>Search Options:</label>

            <label>
                <input id="txtSearchBox" data-bind="textInput: search_term_filter" type="search" class="form-control  margin-bottom-14" placeholder="Search" />
            </label>
            <select id="ddlAgency" class="form-control margin-bottom-14" style="display: inline; width: 180px" data-bind="


    options: agencies,
    optionsText: 'name',
    optionsValue: 'ID',
    value: agency_fk_filter,
    optionsCaption: 'Show All Agencies',
    valueAllowUnset: true
">
            </select>

            <input placeholder="Arrival Date" data-bind="value: date_arr_filter" type="text" style="display: inline; width: 200px" class="date form-control margin-bottom-14" />
            <input placeholder="Departure Date" data-bind="value: date_dep_filter" type="text" style="display: none; width: 200px" class="date form-control margin-bottom-14" />


        </div>


        <table class="table table-striped table-bordered table-hover order-column compact" id="tblClients">
            <thead>
                <tr>
                    <th>Action</th>
                    <th>PNR</th>
                    <th>Names</th>
                    <th>PAX</th>
                    <th>Arrival Date</th>
                    <th>Agency</th>
                </tr>
                <tr id="trLoading" style="display: inline-grid">
                    <td colspan="7" style="text-align: center;">Loading...</td>

                </tr>
            </thead>

            <tbody data-bind="foreach: { data: clients_filter }">
                <tr>
                    <td>
                        <img class="edit" title="Edit Client" src="../icons/fa-pencil.png" />
                        <img class="trans" title="Change Transportation" src="../icons/fa-train.png" />
                        <img class="sale" title="Add Service" src="../icons/fa-plus-square.png" />

                    </td>
                    <td data-bind="text: PNR"></td>
                    <td data-bind="text: names"></td>
                    <td data-bind="text: PAX"></td>
                    <td data-bind="text: date_arr"></td>
                    <td data-bind="text: agency_name"></td>

                </tr>
            </tbody>



        </table>

        <%--        <table class="table table-striped table-bordered table-hover order-column compact" id="tblSearch">
            <thead>
                <tr>
                    <th>Action</th>
                    <th>PNR</th>
                    <th>Names</th>
                    <th>PAX</th>
                    <th>Arrival Date</th>
                    <th>Agency</th>
                </tr>
            </thead>
        </table>--%>
    </div>
    <%--                                <div class="col-lg-6">
                                    <div class="input-group col-lg-12">
                                        <span class="input-group-addon">
                                            <input type="radio" value="1" data-bind="checked: trans_fk" name="trans_type" />
                                        </span>
                                        <input data-bind="hover: $parent.get_price" value="Bus Transfer" readonly="readonly" class="form-control" />
                                    </div>
                                    <div class="input-group col-lg-12">
                                        <span class="input-group-addon">
                                            <input type="radio" value="2" data-bind="checked: trans_fk" name="trans_type" />
                                        </span>

                                        <input value="Bus one way" readonly="readonly" class="form-control" />
                                    </div>
                                    <div class="input-group col-lg-12">
                                        <span class="input-group-addon">
                                            <input type="radio" value="3" data-bind="checked: trans_fk" name="trans_type" />
                                        </span>

                                        <input value="Taxi" readonly="readonly" class="form-control" />
                                    </div>
                                    <div class="input-group col-lg-12">
                                        <span class="input-group-addon">
                                            <input type="radio" value="10" data-bind="checked: trans_fk" name="trans_type" />
                                        </span>

                                        <input value="Other" readonly="readonly" class="form-control" />
                                    </div>
                                 
                                    <!-- /input-group -->
                                </div>--%>
    <%--   <input type="number" step="1" min="0" class="form-control" style="width:40px" />--%>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="Server">

    <link href="../Content/DataTables/css/buttons.dataTables.css" rel="stylesheet" />

    <script src="../scripts/DataTables/dataTables.buttons.js"></script>
    <script src="../scripts/jszip.min.js"></script>
    <script src="../scripts/pdfmake.min.js"></script>
    <script src="../scripts/vfs_fonts.js"></script>
    <script src="../scripts/DataTables/buttons.html5.js"></script>
    <script src="../scripts/DataTables/buttons.print.js"></script>

    <script src="../views_client/view_client_update.js"></script>

    <script>

        var my = { viewModel: new SaleViewModel() };
        ko.applyBindings(my.viewModel);
        var dataTable;
        var search = '<%=Search%>';
        $(document).ready(function () {
            my.viewModel.search_term_filter(search);

            $('[data-toggle="tooltip"]').tooltip()
            // $(".date").datepicker({ dateFormat: 'yy-mm-dd', minDate: 0 });
            $(".date").datepicker({ dateFormat: 'yy-mm-dd' });



            $('#cbIsOw').change(function () {
                if (this.checked) {
                    $('#div_dep').slideUp();
                    $('#txtDateDep').removeAttr('required', 'required');
                    $('#ddlFlightDep').removeAttr('required', 'required');

                }
                else {
                    $('#div_dep').slideDown();
                    $('#txtDateDep').attr('required', 'required');
                    $('#ddlFlightDep').attr('required', 'required');
                }
            });



            $('#btn_close').click(function () {

                $('#modal_edit').modal('hide');
            });


            //$('#tblSearch tbody').on('click', 'tr', function () {
            $('#tblClients tbody').on('click', '.sale', function () {
                $('#modal_sale').modal('show');

                var client = ko.dataFor(this);
                my.viewModel.PNR(client.PNR());
                my.viewModel.agency_fk(client.agency_fk());
                my.viewModel.persons(client.PAX());
                my.viewModel.persons_max(client.PAX());

                my.viewModel.load_sales();
                $('.modal-title').text("[" + client.PNR() + "] " + client.names())
            });

            $('#tblClients tbody').on('click', '.trans', function () {
                $('#modal_trans').modal('show');

                var client = ko.dataFor(this);
                my.viewModel.PNR(client.PNR());
                my.viewModel.agency_fk(client.agency_fk());

                my.viewModel.load_trans();
                $('.modal-title').text("[" + client.PNR() + "] " + client.names())
            });



            //$('#tblSearch tbody').on('click', 'tr', function () {
            $('#tblClients tbody').on('click', '.edit', function () {

                $('#modal_edit').modal('show');
                //var tr = $(this).closest('tr');
                var client = ko.dataFor(this);
                my.viewModel.load_client(client);

                if (client.oneway()) {
                    $('#div_dep').slideUp();
                    $('#txtDateDep').removeAttr('required', 'required');
                    $('#ddlFlightDep').removeAttr('required', 'required');
                }
                $('.modal-title').text("[" + client.PNR() + "] " + client.names())
            });


            //$("#txtSearchBox").on("keyup search input paste cut", function () {
            //    dataTable.search(this.value).draw();
            //});



            //$('#exampleModal').on('show.bs.modal', function (event) {
            //    var button = $(event.relatedTarget) // Button that triggered the modal
            //    var recipient = button.data('whatever') // Extract info from data-* attributes
            //    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            //    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            //    var modal = $(this)
            //    modal.find('.modal-title').text('New message to ' + recipient)
            //    modal.find('.modal-body input').val(recipient)
            //})


        });




        //dataTable = $('#tblSearch').DataTable({
        //    "ajax": url_search,
        //    "pageLength": 10,
        //    "bLengthChange": false,
        //    "dom": '<"toolbar">rtip',
        //    "sAjaxDataProp": "",
        //    "autoWidth": true,
        //    "columns": [


        //                { "data": "PNR", "width": "60px" },
        //                { "data": "PNR", "width": "50px" },
        //                { "data": "names", "width": "180px" },
        //                { "data": "PAX", "width": "70px" },
        //                //{ "data": "num_arr" },
        //                { "data": "date_arr" },
        //                //{ "data": "num_dep" },
        //                //{ "data": "date_dep" },
        //                //{ "data": "hotel" },
        //                { "data": "agency" },
        //                { "data": "agency_fk" }
        //    ],
        //    "columnDefs": [
        //                {
        //                    "render": function () {
        //                        return '<img class="edit"  title="Edit Client" src="../icons/fa-pencil.png"/> <img title="Change Transportation" class="trans" src="../icons/fa-train.png" />  <img title="Add Service" class="sale" src="../icons/fa-plus-square.png" />';
        //                        //<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">Open modal for @getbootstrap</button>

        //                    },
        //                    "targets": 0
        //                },
        //                { type: "phoneNumber", targets: 0 },
        //                {
        //                    "render": function (data, type, row) {
        //                        return new Date(data).yyyymmdd();

        //                    },
        //                    "targets": 4
        //                },
        //                {

        //                }

        //    ],

        //});

        //if (search != '') {
        //    $('#txtSearchBox').val(search);
        //    dataTable.search(search).draw();
        //}
    </script>
</asp:Content>
