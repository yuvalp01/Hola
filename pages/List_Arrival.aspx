<%@ Page Title="Arrival List" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="List_Arrival.aspx.cs" Inherits="pages_List_Arrival" %>

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
            <h1 class="page-header"><i class="fa fa-sign-in fa-fw"></i>Arrival List</h1>
        </div>
    </div>

    <div class="panel panel-default">

        <div class="panel-heading">
            <h3 class="panel-title">Follow the steps to create an arrival list</h3>

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
                                <h3>Arrival Date</h3>
                                <div class="form-group">
                                    <input id="txtDateStrat" data-bind="value: date_start" required="required" type="text" class="date form-control" style="width: 250px" placeholder="Select Arrival Date" />

                                </div>

                                <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
                            </div>
                        </div>
                    </div>
                    <div class="row setup-content" id="step-2">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3 >Select Flights</h3>
                               
<%--                                <div class="progress">
                                    <div data-bind="text:total_sum,  attr:{ 'aria-valuenow':total_sum}" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="50" style="width: 60%;">
                                        
                                    </div>
                                </div>--%>
                                <div class="form-group">
                                    <table id="tbl_flights" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>Flight#</th>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>PAX</th>
                                                <th>SELECT  <span title="Sum of PAX" class="badge" data-bind="text: total_sum"></span></th><%--, visible: total_sum()>0 --%>
                                            </tr>

                                        </thead>

                                        <tbody data-bind="foreach: { data: flights, includeDestroyed: true }">
                                            <%--  <tr data-bind="click: $parent.select ">--%>
                                            <tr data-bind="click: $root.select, css: { mark: selected }">
                                                <td style="text-align: center">
                                                    <input type="checkbox" data-bind="checked: selected" <%--data-bind="checkedValue: num, checked: $parent.selectedPeople"--%> /></td>

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

                                <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
                            </div>
                        </div>
                    </div>
                    <div class="row setup-content" id="step-3">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3>Tour Plan</h3>
                                <input id="txtDateEnd" data-bind="value: date_end" required="required" type="text" class="date form-control" style="width: 250px" placeholder="Enter Last Date for Tour Plan" />
                                <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>

                            </div>
                        </div>
                    </div>

                    <div class="row setup-content" id="step-4">
                        <div class="col-xs-12">
                            <div class="col-md-12">
                                <h3>Create List</h3>
                                <p>Arrival List for <b data-bind="text: date_start"></b>is Ready to print!</p>
                                <iframe data-bind="attr: { src: print_url }" name="frame" id="iframe_print" style="display: none"></iframe>
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
    <script src="../views_client/view_list_arrival.js"></script>

    <script>


        //ko.options.useOnlyNativeEvents = true;
        var my = { viewModel: new FlightViewModel() };

        ko.applyBindings(my.viewModel);


        $(document).ready(function () {
            $("#txtDateStrat").datepicker({ dateFormat: 'yy-mm-dd', minDate: 0 });
            $("#txtDateEnd").datepicker({ dateFormat: 'yy-mm-dd', minDate: 0 });

            $('#btnPrint').click(function () {
                frames['frame'].print();
            });

            //$('[required=required]').each(function (index) {

            //    if ($(this).val() == '0' || ($(this).val() == '')) {
            //        $(this).parent().addClass('has-error');
            //        //count++;
            //    }
            //    else {
            //        $(this).parent().removeClass('has-error');

            //    }
            //});


        });


    </script>

</asp:Content>
