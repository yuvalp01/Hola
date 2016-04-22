<%@ Page Title="Tour Plan" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="TourPlan.aspx.cs" Inherits="pages_TourPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-calendar fa-fw"></i>Tour Plan</h1>
        </div>
    </div>

    <div class="panel-heading">
        <h2 class="panel-title">Add an event</h2>

    </div>

    <div class="panel-body">

        <div class="form-group">


            <label class="col-sm-2 control-label">Tour Name</label>
            <div class="col-sm-10">

                <select required="required" id="ddlProducts" class="form-control margin-bottom-14" data-bind="
    options: products,
    optionsText: 'name',
    optionsValue: 'ID',
    value: new_tour_fk,
    optionsCaption: 'Select Tour',
    valueAllowUnset: true
">
                </select>

            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Date</label>
            <div class="col-sm-10">
                <input required="required" type="text" class="form-control date" data-bind="value: new_date" placeholder="Tour Date" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Time</label>
            <div class="col-sm-10">
                <input required="required" type="time" class="form-control" data-bind="value: new_time" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">Guide</label>
            <div class="col-sm-10">
                <select id="ddlGuides" class="form-control margin-bottom-14" data-bind="
    options: guides,
    optionsText: 'name',
    optionsValue: 'ID',
    value: new_guide_fk,
    optionsCaption: 'Select Guide',
    valueAllowUnset: true
">
                </select>
            </div>
        </div>
        <div class="form-group">


            <label class="col-sm-2 control-label">Comments</label>
            <div class="col-sm-10">
                <textarea class="form-control" data-bind="value: new_comments">

                </textarea>

            </div>


        </div>
        <div class="form-group">
            <div class="col-sm-2">
                <button type="button" data-bind="click: add_server" class="btn btn-primary">Submit</button>

            </div>
        </div>

    </div>



    <table class="table table-striped table-bordered table-hover" id="tbl">
        <thead>
            <tr>

                <th>ID        </th>
                <th>Date         </th>
                <th>Time       </th>
                <th>Tour       </th>
                <th>Guide      </th>
                <th>Comments       </th>
                <th>Update Date      </th>



            </tr>
        </thead>
        <tbody data-bind="foreach: tours">
            <tr>

                <td data-bind="text: ID "></td>
                <td data-bind="text: date "></td>
                <td data-bind="text: time "></td>
                <td data-bind="text: tour_name"></td>
                <td data-bind="text: guide_name"></td>
                <td data-bind="text: comments"></td>
                <td data-bind="text: date_update"></td>

            </tr>
        </tbody>
    </table>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FooterScripts" runat="Server">


    <%--<%: System.Web.Optimization.Scripts.Render("~/bundles/tour_plan") %>--%>
    <script src="../views_client/view_tour_plan.js"></script>
    <script>

        $(document).ready(function () {
            $('.date').datepicker();

            ////TEST:
            //$('#btn').click(function () {

            //    val = 11;
            //    var select_str = "#ddlProducts option[value='" + val + "']"
            //    var _tour_name = $(select_str).text()
            //    console.log(_tour_name);
            //});

        });

    </script>
</asp:Content>
