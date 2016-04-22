<%@ Page Title="Departure List" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="List_Departure.aspx.cs" Inherits="pages_List_Departure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="../Content/wizard.css" rel="stylesheet" />
    <style>
        tr.mark {
            background-color: #08C !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-sign-out fa-fw"></i>Departure List</h1>

        </div>
    </div>

    <div class="panel panel-default">


        <div class="panel-heading">
            <h3 class="panel-title">Follow the steps to create a departure list</h3>

            <%--  <ul data-bind="foreach: { data: filteredTeams }">    <li data-bind="text: num"></li>        </ul>--%>
        </div>
        <div class="panel-body">


            <div class="container" style="width: auto">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step">
                            <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
                            <p>Step 1</p>
                        </div>
                        <div class="stepwizard-step">
                            <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
                            <p>Step 2</p>
                        </div>
                        <div class="stepwizard-step">
                            <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
                            <p>Step 3</p>
                        </div>

                        <div class="stepwizard-step">
                            <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
                            <p>Step 4</p>
                        </div>
                    </div>
                </div>
                <form role="form">
                    <div class="row setup-content" id="step-1">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3>Departure Date</h3>
                                <div class="form-group">
                                    <input id="txtDateStrat" data-bind="value: date_start" required="required" type="text" class="date form-control" style="width: 250px" placeholder="Select Departure Date" />
                                </div>
                                <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
                            </div>
                        </div>
                    </div>
                    <div class="row setup-content" id="step-2">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3>Select Flights</h3>
                                <div class="form-group">
<%--                                                             <img src="../images/bus_icon_right.png"" class="img-rounded" alt="Cinque Terre" width="100" height="50"/>--%>

                                    <table id="tbl_flights" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th></th>

                                                <th>Num</th>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>PAX</th>
                                                <th>SELECT  <span title="Sum of PAX" class="badge" data-bind="text: total_sum"></span></th><%--, visible: total_sum()>0 --%>

                                            </tr>
                                        </thead>

                                        <tbody data-bind="foreach: { data: flights }">
                                            <tr data-bind="click: $root.select, css: { mark: selected }">
                                                <td style="text-align: center">
                                                    <input type="checkbox" data-bind="checked: selected" /></td>
                                                <td data-bind="text: num"></td>
                                                <td data-bind="text: date"></td>
                                                <td data-bind="text: time"></td>
                                                <td data-bind="text: sum"></td>
                                                <td style="text-align: center">
                                                    <input type="button" value="Select" class="btn btn-info" style="background-color: #5cb85c" /></td>


                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <button id="btnStep_2" class="btn btn-primary nextBtn btn-lg pull-right"  data-bind="click: create_plan" type="button">Next</button>
                            </div>
                        </div>
                    </div>
                    <div class="row setup-content" id="step-3">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3>Plan Pickup Route</h3>
                                <p>Eariest flights depart at: <span style="display:none; font-weight:bold" class="label-warning" id="lbl_earliest_time" data-bind="text: earliest_time"></span> </p>
                                <table id="tbl_plans" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Hotel</th>
                                            <th>PAX</th>
                                            <th>Time <a href="#" id="lnk_sort" class="btn-circle" style="display: none; width: 80px" data-bind="click: get_plan">Sort By Time</a></th>

                                        </tr>
                                    </thead>

                                    <tbody data-bind="foreach: { data: plans }">
                                        <tr>
                                            <td data-bind="text: hotel"></td>
                                            <td data-bind="text: PAX"></td>
                                            <td>
                                                <span data-bind="text: time, visible: !(editable())"></span>
                                                <input required="required" type="time" data-bind="value: time, visible: editable, event: { blur: $parent.updateTime }" />

                                                <button class="btn btn-circle btn-info" data-bind="click: $parent.edit_mode, visible: !(editable())">Edit</button>

                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <button id="btnStep_3" class="btn btn-primary nextBtn btn-lg pull-right"  type="button">Next</button>
                            </div>
                        </div>
                    </div>

                    <div class="row setup-content" id="step-4">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3>Create List</h3>
                                   <p>Departure List for <b data-bind="text: date_start"></b> is Ready to print!</p>
                                <iframe  name="frame" id="iframe_print" style="display: none"></iframe>
                                <button id="btnPrint" class="btn btn-success btn-lg pull-right" type="button">Print List!</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="Server">

    <script src="../scripts/wizard.js"></script>
    <%--<script src="../scripts/knockout-3.4.0.js"></script>--%>
    <script src="../views_client/view_list_departure.js"></script>


    <script>


        //ko.options.useOnlyNativeEvents = true;
        var my = { viewModel: new FlightViewModel() };

        ko.applyBindings(my.viewModel);


        $(document).ready(function () {
            $(".date").datepicker({ dateFormat: 'yy-mm-dd', minDate: 0 });



            $('#btnStep_2').click(function () {
                $('#lbl_earliest_time').show('highlight');
                //frames['frame'].print();

            });

            $('#btnStep_3').click(function () {
                $('#iframe_print').attr('src', my.viewModel.print_url());
                //frames['frame'].print();

            });

            $('#btnPrint').click(function () {
                frames['frame'].print();

            });


        });

    </script>

</asp:Content>
