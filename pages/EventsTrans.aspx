<%@ Page Title="Planned Shuttles" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="EventsTrans.aspx.cs" Inherits="pages_TourPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .loader {
            border: 6px solid #f3f3f3;
            border-radius: 50%;
            border-top: 6px solid #3498db;
            width: 40px;
            height: 40px;
            -webkit-animation: spin 2s linear infinite;
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        .btn-print {
            color: #2cb63e;
            background-color: #f0e94e;
            border-color: #f0e94e;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-list-alt fa-fw"></i>Arrival/Departure Lists</h1>
        </div>
    </div>



    <table class="table table-striped table-bordered table-hover" id="tbl">
        <thead>
            <tr>
                <th></th>
                <th>ID</th>
                <th>Date         </th>
                <th>Time       </th>
                <th>Route       </th>
                <th>P      </th>

                <th>Accompanied      </th>
                <th>Driver's Details       </th>
                <th>Update Date      </th>
            </tr>
            <tr id="trLoading" style="display: inline-grid">
                <td colspan="9" style="text-align: center;">
                    <%--<div class="loader"></div>--%>
                    Loading...</td>

            </tr>
        </thead>
        <tbody data-bind="foreach: events">


            <tr>

                <td>

                    <button data-bind="click: $parent.edit_mode, text: editBtnText, css: editBtnClass"></button>
                    <button class="btn btn-danger btn-circle" title="Delete Plan" data-bind="click: $parent.CancelEvent">Del</button>
                    <a class="btn btn-print btn-circle" title="Print" target="_blank" data-bind="visible: people() > 0 && time, attr: { href: print_url }">Print</a>

                </td>
                <td data-bind="text: ID"></td>

                <td data-bind="text: date"></td>
                <td>
                    <!-- ko if: !time -->
        <span data-bind="text: time "></span>
                    <!-- /ko -->
                    <!-- ko if: time -->
                    <span data-bind="text: time, visible: !(editable()) "></span>
                    <input class="form-control" type="time" data-bind="value: time, visible: editable" style="width: 120px" />
                       <!-- /ko -->
                </td>
                <td>
                    <span data-bind="text: activity_name"></span>
                    <a class="btn btn-warning btn-circle" title="Plan Route" href="PlanRoute.aspx"  data-bind=" visible: direction() == 'OUT'">Plan</a>

                </td>
                <td data-bind="text: people"></td>


                <td>
                    <span data-bind="text: guide_name, visible: !(editable())"></span>


                    <div data-bind="visible: editable()">
                        <select class="form-control margin-bottom-14" data-bind="
    options: $root.guides,
    optionsText: 'name',
    optionsValue: 'ID',
    value: $data.guide_fk,
    optionsCaption: 'Select Guide',
    valueAllowUnset: true

">
                        </select>

                    </div>

                </td>

                <td>

                    <span data-bind="text: comments, visible: !(editable())"></span>
                    <textarea class="form-control" data-bind=" value: comments, visible: editable"></textarea>
                </td>
                <td data-bind="text: date_update"></td>

            </tr>
        </tbody>
    </table>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="Server">

    <script>
        var CATEGORY = 'transport';

    </script>
    <script src="../views_client/view_events.js"></script>
    <script>
        var my = { viewModel: new AppEventModel() };
        ko.applyBindings(my.viewModel);

        $(document).ready(function () {
            $(".date").datepicker({ dateFormat: 'yy-mm-dd', minDate: -30 });

            //my.viewModel.GetPrintReqUrl();
            //var _url = "../print/ListArrival_Print.aspx?";
            //if (isValidContainer('arrivals_wizard')) {

            //    var _details = {
            //        event_fk: item.ID(),
            //        date: item.date(),
            //        time: item.time(),
            //        activity_fk: item.activity_fk(),
            //        guide_fk: item.guide_fk(),
            //        comments: item.comments(),

            //    };

            //window.open("../print/ListArrival_Print.aspx");
        });

    </script>
</asp:Content>
