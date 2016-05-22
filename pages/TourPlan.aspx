<%@ Page Title="Tour Plan" Language="C#" MasterPageFile="~/MasterHola.master" AutoEventWireup="true" CodeFile="TourPlan.aspx.cs" Inherits="pages_TourPlan" %>

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
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
    </style>
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

                <th></th>
                <th>Date         </th>
                <th>Time       </th>
                <th>Tour       </th>
                <th>Guide      </th>
                <th>Comments       </th>
                <th>Update Date      </th>



            </tr>
            <tr id="trLoading" style="display:inline-grid">
                <td colspan="7" style="text-align:center;">
                        <%--<div class="loader"></div>--%>
                    Loading...</td>

            </tr>
        </thead>
        <tbody data-bind="foreach: tours">


            <tr>

                <td>
                    <button data-bind="click: $parent.edit_mode, text: editBtnText, css: editBtnClass"></button>
                    <button class="btn btn-danger btn-circle" title="Delete Plan" data-bind="click: $parent.CancelPlan">Del</button>
                </td>
                <td data-bind="text: date"></td>
                <td>

                    <span data-bind="text: time, visible: !(editable())"></span>
                    <input class="form-control" type="time" data-bind="value: time, visible: editable" style="width: 120px" />

                </td>
                <td data-bind="text: tour_name"></td>


                <td>
                    <span data-bind="text: guide_name, visible: !(editable())"></span>


                    <div data-bind="visible: editable()">
                        <select class="form-control margin-bottom-14" data-bind="
    options: $root.guides,
    optionsText: 'name',
    optionsValue: 'ID',
    value: $data.guide_fk,
    optionsCaption: 'Select Guide',
    //valueAllowUnset: true

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


    <%--<%: System.Web.Optimization.Scripts.Render("~/bundles/tour_plan") %>--%>
    <script src="../views_client/view_tour_plan.js"></script>
    <script>

        $(document).ready(function () {
            $('.date').datepicker();

        });


        //var vm = {
        //    omnivoreTables: [
        //      {
        //          name: 'One',
        //          id: '1'
        //      },
        //      {
        //          name: 'Two',
        //          id: '2'
        //      }
        //    ],
        //    selectedOmnivoreTableId: ko.observable(1),
        //    tables: ko.observableArray([
        //      { name: 'First' },
        //      { name: 'Second' },
        //      { name: 'Third' }
        //    ])
        //};

        //ko.applyBindings(vm);




    </script>

    <%--<table class="table table-bordered">
  <thead>
    <tr>
      <th>Nextable Name</th>
      <th>POS Name</th>
    </tr>
  </thead>
  <tbody data-bind="foreach: tables">
    <tr>
      <td data-bind="text: name"></td>
      <td>
        <select class="span8 dropdown" data-placeholder="Select Pos Table" data-bind="options: $parent.omnivoreTables, optionsText: 'name', optionsValue:'id', value: $parent.selectedOmnivoreTableId"></select>
      </td>
    </tr>
  </tbody>
</table>--%>
</asp:Content>
