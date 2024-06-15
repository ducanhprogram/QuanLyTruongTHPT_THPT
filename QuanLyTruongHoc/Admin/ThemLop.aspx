<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="ThemLop.aspx.cs" Inherits="QuanLyTruongHoc.Admin.ThemLop" %>
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
        <h3 class="text-center">Thêm lớp học</h3>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtMaLop">Mã lớp</label>
                <asp:TextBox ID="txtMaLop" runat="server" CssClass="form-control" placeholder="Nhập mã lớp..." required></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtTenLop">Tên lớp</label>
                <asp:TextBox ID="txtTenLop" runat="server" CssClass="form-control" placeholder="Nhập tên lớp..." required></asp:TextBox>
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtSoLuong">Số lượng</label>
                <asp:TextBox ID="txtSoLuong" runat="server" CssClass="form-control" placeholder="Nhập số lượng..." required></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label style="font-size: 20px" for="ddlMaGiaoVien">Mã giáo viên</label>
                <asp:DropDownList ID="ddlMaGiaoVien" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataValueField="MaGiaoVien" AppendDataBoundItems="true">
                    <asp:ListItem Text="-- Chọn mã giáo viên --" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolCS %>" SelectCommand="SELECT MaGiaoVien, Ten FROM GiaoVien"></asp:SqlDataSource>
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Add Class" OnClick="btnAdd_Click" />
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">
                <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" DataKeyNames="Id"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" AutoGenerateColumns="False"
                    EmptyDataText="No Record to display!" AllowPaging="true" PageSize="4"  OnRowDeleting="GridView1_RowDeleting" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <asp:BoundField DataField="Sr.No" HeaderText="Số thứ tự" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                     <%--   <asp:BoundField DataField="MaLop" HeaderText="Mã Lớp" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>--%>

                          <asp:TemplateField HeaderText="Mã Lớp">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMaLopEdit" runat="server" Text='<%# Bind("MaLop") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblMaLop" runat="server" Text='<%# Eval("MaLop") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên Lớp">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTenLopEdit" runat="server" Text='<%# Bind("TenLop") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTenLop" runat="server" Text='<%# Eval("TenLop") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số Lượng">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSoLuongEdit" runat="server" Text='<%# Bind("SoLuong") %>' CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSoLuong" runat="server" Text='<%# Eval("SoLuong") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mã Giáo Viên">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMaGiaoVienEdit" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataValueField="MaGiaoVien" SelectedValue='<%# Bind("MaGiaoVien") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SchoolCS %>" SelectCommand="SELECT MaGiaoVien FROM GiaoVien"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblMaGiaoVien" runat="server" Text='<%# Eval("MaGiaoVien") %>'></asp:Label>
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
