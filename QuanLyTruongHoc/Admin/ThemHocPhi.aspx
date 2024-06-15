<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="ThemHocPhi.aspx.cs" Inherits="QuanLyTruongHoc.Admin.ThemHocPhi" %><asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    </style>

    <div style="width:100%; height:720px; background-repeat:no-repeat;background-size:cover;background-attachment:fixed">
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Thêm Học Phí</h3>

        
            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                
                <div class="col-md-3">
                    <label style="font-size: 20px" for="ddlMaHocSinh">Chọn Mã Học Sinh</label>
                    <asp:DropDownList ID="ddlMaHocSinh" runat="server" CssClass="form-control" required></asp:DropDownList>
                </div>
                
                <div class="col-md-3">
                    <label style="font-size: 20px" for="ddlMaMonHoc">Chọn Mã Môn Học</label>
                    <asp:DropDownList ID="ddlMaMonHoc" runat="server" CssClass="form-control" required></asp:DropDownList>
                </div>

                <div class="col-md-3">
                    <label style="font-size: 20px" for="ddlMaLop">Chọn Mã Lớp</label>
                    <asp:DropDownList ID="ddlMaLop" runat="server" CssClass="form-control" required></asp:DropDownList>
                </div>
                
                <div class="col-md-3">
                    <label style="font-size: 20px" for="txtNgayThanhToan">Ngày Thanh Toán</label>
                    <asp:TextBox ID="txtNgayThanhToan" runat="server" CssClass="form-control" required Text='<%# Bind("NgayThanhToan", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-6">
                    <label style="font-size: 20px" for="txtNamHoc">Năm Học</label>
                    <asp:TextBox ID="txtNamHoc" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label style="font-size: 20px" for="txtTongTien">Tổng Tiền</label>
                    <asp:TextBox ID="txtTongTien" runat="server" CssClass="form-control" required></asp:TextBox>
                </div>
            </div>

      
            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Thêm Học Phí" OnClick="btnAdd_Click" />
                </div>
            </div>

        
            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <div class="table-container">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="No record to display" AutoGenerateColumns="False"
    OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" PageSize="10" OnRowCancelingEdit="GridView1_RowCancelingEdit"
    DataKeyNames="MaHocPhi" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound" >
    <Columns>
        <asp:BoundField DataField="MaHocPhi" HeaderText="Mã Học Phí" ReadOnly="True" />

        <asp:TemplateField HeaderText="Mã Học Sinh">
            <ItemTemplate>
                <asp:Label ID="lblMaHocSinh" runat="server" Text='<%# Eval("MaHocSinh") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlMaHocSinhEdit" runat="server" CssClass="form-control">
       
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Mã Môn Học">
            <ItemTemplate>
                <asp:Label ID="lblMaMonHoc" runat="server" Text='<%# Eval("MaMonHoc") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlMaMonHocEdit" runat="server" CssClass="form-control">
                
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Mã Lớp">
            <ItemTemplate>
                <asp:Label ID="lblMaLop" runat="server" Text='<%# Eval("MaLop") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlMaLopEdit" runat="server" CssClass="form-control">
             
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Ngày Thanh Toán">
            <ItemTemplate>
                <asp:Label ID="lblNgayThanhToan" runat="server" Text='<%# Bind("NgayThanhToan", "{0:yyyy-MM-dd}") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtNgayThanhToanEdit" runat="server" CssClass="form-control" Text='<%# Bind("NgayThanhToan", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Năm Học">
            <ItemTemplate>
                <asp:Label ID="lblNamHoc" runat="server" Text='<%# Eval("NamHoc") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtNamHocEdit" runat="server" CssClass="form-control" Text='<%# Bind("NamHoc") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

         <asp:TemplateField HeaderText="Tổng Tiền">
            <ItemTemplate>
                <asp:Label ID="lblTongTien" runat="server" Text='<%# Eval("FormattedTongTien") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtTongTienEdit" runat="server" CssClass="form-control" Text='<%# Bind("TongTien") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
    </Columns>
</asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
