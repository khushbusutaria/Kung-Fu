﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Instructor/master.Master" AutoEventWireup="true" CodeBehind="ParentList.aspx.cs" Inherits="KungFuPanda.Instructor.ParentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- JQuery DataTable Css -->
    <link rel="stylesheet" href="assets/plugins/jquery-datatable/dataTables.bootstrap4.min.css">
    <!-- Custom Css -->
    <link rel="stylesheet" href="assets/css/jquery-ui.css">
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/color_skins.css">
    <script src="assets/js/Jquery_1.12.js"></script>

    <script>    
        $(document).ready(function () {
            getParentsdata("tbodylist");
        });
        function getParentsdata(strbodyid) {
            try {
                var param = {};
                $.ajax({
                    type: "POST",
                    async: false,
                    data: JSON.stringify(param),
                    url: "ParentList.aspx/getParentsdata",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (response) {
                        if (response.d != "") {
                            var vjson = JSON.parse(response.d);
                            try {
                                var innerHTML = "";
                                $("#" + strbodyid).html("");
                                for (var i = 0; i < vjson.length; i++) {
                                    
                                    innerHTML += "<tr>";

                                    innerHTML += "<td><a class=\"button button-small edit\" title=\"Edit\" onClick=\"EditStudent(" + vjson[i].PARENT_ID + ")\" style='cursor:pointer;'><i class=\"zmdi zmdi-edit\" title=\"Edit\" style=\"color:green;\"></i></a></td>";
                                    if (vjson[i].PARENT_STATUS) {
                                        innerHTML += "<td><span class=\"btn btn-round btn-simple btn-sm btn-success btn-filter\" onclick=\"ChangeStatus(" + vjson[i].PARENT_ID + ")\">Approved</span></td>";
                                    }
                                    else {
                                        innerHTML += "<td><span class=\"btn btn-round btn-simple btn-sm btn-danger btn-filter\"  onclick=\"ChangeStatus(" + vjson[i].PARENT_ID + ")\">Blocked</span></td>";
                                    }
                                    innerHTML += "<td>" + vjson[i].STU_NUM + "</td>";

                                    innerHTML += "<td>" + vjson[i].PARENT_FNAME + "</td>";
                                    innerHTML += "<td>" + vjson[i].PARENT_MNAME + "</td>";
                                    innerHTML += "<td>" + vjson[i].PARENT_LNAME + "</td>";
                                    if (vjson[i].PARENT_IS_STUDENT) {
                                        innerHTML += "<td><span>Yes</span></td>";
                                    }
                                    else {
                                        innerHTML += "<td><span>No</span></td>";
                                    }
                                    if (vjson[i].PARENT_GENDER) {
                                        innerHTML += "<td><span>Male</span></td>";
                                    }
                                    else {
                                        innerHTML += "<td><span>Female</span></td>";
                                    }
                                    innerHTML += "<td>" + vjson[i].PARENT_MNUM + "</td>";
                                    innerHTML += "<td>" + vjson[i].PARENT_EMAIL + "</td>";
                                    innerHTML += "</tr>";
                                }
                                $("#" + strbodyid).html(innerHTML);
                            }
                            catch (ex) {
                                console.log(" error messge from getParentsdata function : " + ex.message + " at " + ex.stack);
                            }
                        }
                        else {
                        }
                    },
                    error: function (error) {
                        console.dir("error : " + error);
                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    complete: function (response) {
                    }
                });
            }
            catch (ex) {
                console.log("error:" + ex.message)
            }
            return false
        }
        function ChangeStatus(strParentID) {
            try {
                var param = { strParentID: strParentID };
                $.ajax({
                    type: "POST",
                    async: false,
                    data: JSON.stringify(param),
                    url: "ParentList.aspx/ChangeStatus",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (response) {
                        if (response.d != "") {
                            try {
                                $("#divMessage").css("display", "block");
                                getParentsdata("tbodylist");
                            }
                            catch (ex) {
                                console.log(" error messge from ChangeStatus function : " + ex.message + " at " + ex.stack);
                            }
                        }
                        else {
                        }
                    },
                    error: function (error) {
                        console.dir("error : " + error);
                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    complete: function (response) {
                    }
                });
            }
            catch (ex) {
                console.log("error:" + ex.message)
            }
            return false;
        }
        function EditStudent(strParentID) {
            window.location.href = "Parent.aspx?ID=" + strParentID;
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="content">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2><strong>Parents List</strong> </h2>

                        </div>
                        <div class="body">
                            <div class="table-responsive">
                                <%--<div class="form-group form-float">
                                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control" placeholder="Enter From Date" ClientIDMode="Static" required></asp:TextBox>
                                </div>
                                <div class="form-group form-float">
                                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control" placeholder="Enter To Date" ClientIDMode="Static" required></asp:TextBox>
                                </div>
                                <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-raised btn-primary btn-round waves-effect" Text="Submit" ClientIDMode="Static" />--%>
                                <div class="alert alert-success" id="divMessage" style="display: none;">
                                    <strong>Parent data updated successfully.</strong>
                                </div>
                                <asp:Button runat="server" ID="btnAddParent" CssClass="btn btn-raised btn-primary btn-round waves-effect" Text="Add Parent" OnClick="btnAddParent_Click" />

                                <table class="table table-bordered table-striped table-hover js-basic-example dataTable">
                                    <thead>
                                        <tr>

                                            <th>Edit</th>
                                            <th>Status</th>
                                            <th>Student ID</th>
                                            <th>First Name</th>
                                            <th>Middle Name</th>
                                            <th>Last Name</th>
                                            <th>Is Student</th>
                                            <th>Gender</th>
                                            <th>Mobile No</th>
                                            <th>Email</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Edit</th>
                                            <th>Status</th>
                                            <th>Student ID</th>
                                            <th>First Name</th>
                                            <th>Middle Name</th>
                                            <th>Last Name</th>
                                            <th>Is Student</th>
                                            <th>Gender</th>
                                            <th>Mobile No</th>
                                            <th>Email</th>
                                        </tr>
                                    </tfoot>
                                    <tbody id="tbodylist">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
    </section>

    <!-- Jquery DataTable Plugin Js -->
    <script src="assets/bundles/datatablescripts.bundle.js"></script>
    <script src="assets/plugins/jquery-datatable/buttons/dataTables.buttons.min.js"></script>
    <script src="assets/plugins/jquery-datatable/buttons/buttons.bootstrap4.min.js"></script>
    <script src="assets/plugins/jquery-datatable/buttons/buttons.colVis.min.js"></script>
    <script src="assets/plugins/jquery-datatable/buttons/buttons.html5.min.js"></script>
    <script src="assets/plugins/jquery-datatable/buttons/buttons.print.min.js"></script>

    <%--<script src="assets/bundles/mainscripts.bundle.js"></script>--%>
    <script src="assets/js/pages/tables/jquery-datatable.js"></script>
    <!-- Custom Js -->



</asp:Content>
