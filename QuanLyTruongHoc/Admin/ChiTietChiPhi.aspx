<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="ChiTietChiPhi.aspx.cs" Inherits="QuanLyTruongHoc.Admin.ChiTietChiPhi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <style>
        /* CSS styles */
        body {
            background-color: #fff;
            font-weight: 600;
        }
        h3 {
            color: #000;
        }
        div {
            color: #fff;
        }
        label {
            color: #000;
        }
        .table-container {
            width: 100%;
            overflow-x: auto;
        }
        .table {
            width: 100%;
            max-width: 100%;
            background-color: #fff;
            color: #000;
        }
        .table th, .table td {
            padding: 15px;
            text-align: left;
        }
        .table th {
            background-color: #5558C9;
            color: #fff;
        }

         div #ContentPlaceHolder1_lblTime {
         display: block;
         color: #000;
         text-align: right;
         margin-right: 50px;
         font-size: 16px;
         }
    </style>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000"></asp:Timer>
        <asp:Label ID="lblTime" runat="server" Font-Bold="true"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>

    <div style="width:100%; height:720px; background-repeat:no-repeat;background-size:cover;background-attachment:fixed">
        <div class="container p-md-4 p-sm-4">
            <h3 class="text-center">Chi Tiết Chi Phí</h3>
            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-12">
                    <div class="table-container">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="No record to display" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="MaHocPhi" HeaderText="Mã Học Phí" ReadOnly="True" />
                                <asp:BoundField DataField="MaHocSinh" HeaderText="Mã Học Sinh" ReadOnly="True" />
                                <asp:BoundField DataField="MaMonHoc" HeaderText="Mã Môn Học" ReadOnly="True" />
                                <asp:BoundField DataField="MaLop" HeaderText="Mã Lớp" ReadOnly="True" />
                                <asp:BoundField DataField="NgayThanhToan" HeaderText="Ngày Thanh Toán" DataFormatString="{0:yyyy-MM-dd}" ReadOnly="True" />
                                <asp:BoundField DataField="NamHoc" HeaderText="Năm Học" ReadOnly="True" />
                                <asp:BoundField DataField="TongTien" HeaderText="Tổng Tiền" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
