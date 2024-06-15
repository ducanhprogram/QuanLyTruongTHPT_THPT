<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="HocSinh.aspx.cs" Inherits="QuanLyTruongHoc.Admin.HocSinh" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <style>
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
<div style="width:100%; height:720px; background-repeat:no-repeat; background-size:cover; background-attachment:fixed">
    <div class="container p-md-4 p-sm-4">
        <div>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>
        <h3 class="text-center">Thêm học sinh</h3>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtMaHocSinh">Mã học sinh</label>
                <asp:TextBox ID="txtMaHocSinh" runat="server" CssClass="form-control" placeholder="Nhập mã học sinh..." required></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtTen">Tên học sinh</label>
                <asp:TextBox ID="txtTen" runat="server" CssClass="form-control" placeholder="Nhập tên học sinh..." required></asp:TextBox>
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtNgaySinh">Ngày sinh</label>
                <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="form-control" TextMode="Date" required></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label style="font-size: 20px" for="ddlGioiTinh">Giới tính</label>
                <asp:DropDownList ID="ddlGioiTinh" runat="server" CssClass="form-control" required>
                    <asp:ListItem Text="Nam" Value="Nam"></asp:ListItem>
                    <asp:ListItem Text="Nữ" Value="Nữ"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtSoDienThoai">Số điện thoại</label>
                <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại..." required></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtDiaChi">Địa chỉ</label>
                <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ..." required></asp:TextBox>
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="ddlMaLop">Mã lớp</label>
                <asp:DropDownList ID="ddlMaLop" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="MaLop" DataValueField="MaLop" AppendDataBoundItems="true">
                    <asp:ListItem Text="-- Chọn mã lớp --" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolCS %>" SelectCommand="SELECT MaLop FROM LopHoc"></asp:SqlDataSource>
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Thêm học sinh" OnClick="btnAdd_Click" />
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">
                <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" DataKeyNames="Id"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" AutoGenerateColumns="False"
                    EmptyDataText="No Record to display!" AllowPaging="true" PageSize="4" OnRowDeleting="GridView1_RowDeleting" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <asp:BoundField DataField="Sr.No" HeaderText="Số thứ tự" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MaHocSinh" HeaderText="Mã Học Sinh" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Tên Học Sinh">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTenEdit" runat="server" Text='<%# Bind("Ten") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTen" runat="server" Text='<%# Eval("Ten") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ngày Sinh">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNgaySinhEdit" runat="server" Text='<%# Bind("NgaySinh") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblNgaySinh" runat="server" Text='<%# Eval("NgaySinh", "{0:MM/dd/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giới Tính">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlGioiTinhEdit" runat="server" CssClass="form-control" SelectedValue='<%# Bind("GioiTinh") %>'>
                                    <asp:ListItem Text="Nam" Value="Nam"></asp:ListItem>
                                    <asp:ListItem Text="Nữ" Value="Nữ"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblGioiTinh" runat="server" Text='<%# Eval("GioiTinh") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số Điện Thoại">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSoDienThoaiEdit" runat="server" Text='<%# Bind("SoDienThoai") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSoDienThoai" runat="server" Text='<%# Eval("SoDienThoai") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Địa Chỉ">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDiaChiEdit" runat="server" Text='<%# Bind("DiaChi") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDiaChi" runat="server" Text='<%# Eval("DiaChi") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã Lớp">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMaLopEdit" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="MaLop" DataValueField="MaLop" SelectedValue='<%# Bind("MaLop") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolCS %>" SelectCommand="SELECT MaLop FROM LopHoc"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblMaLop" runat="server" Text='<%# Eval("MaLop") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:CommandField CausesValidation="False" ShowEditButton="True" ShowDeleteButton="True" HeaderText="Operation">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CommandField>
                    </Columns>
                    <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
