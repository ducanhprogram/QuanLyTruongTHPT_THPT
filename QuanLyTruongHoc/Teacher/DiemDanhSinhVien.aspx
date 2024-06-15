<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher/TeacherMst.Master" AutoEventWireup="true" CodeBehind="DiemDanhSinhVien.aspx.cs" Inherits="QuanLyTruongHoc.Teacher.DiemDanhSinhVien" %>
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

        div span {
            color: #000;
        }
    </style>

    <div width="100%" height="720px" background-repeat="no-repeat" background-size="cover" background-attachment="fixed">
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            
            <div class="ml-auto text-right">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000"></asp:Timer>
                        <asp:Label ID="lblTime" runat="server" Font-Bold="true"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <h3 class="text-center"> Điểm Danh Học Sinh</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaHocSinh">Mã Học Sinh</label>
                    <asp:DropDownList ID="ddlMaHocSinh" runat="server" CssClass="form-control" required>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaLop">Mã Lớp</label>
                    <asp:DropDownList ID="ddlMaLop" runat="server" CssClass="form-control" required>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaMonHoc">Mã Môn Học</label>
                    <asp:DropDownList ID="ddlMaMonHoc" runat="server" CssClass="form-control" required>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-12">
                    <label style="font-size: 20px">Trạng Thái</label>
                    <div class="form-check form-check-inline">
                        <asp:RadioButton ID="radCoMat" runat="server" Text="Có mặt" Checked="true" GroupName="TrangThai" CssClass="form-check-input" />
                    </div>
                    <div class="form-check form-check-inline">
                        <asp:RadioButton ID="radVangMat" runat="server" Text="Vắng mặt" GroupName="TrangThai" CssClass="form-check-input" />
                    </div>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label style="font-size: 20px" for="txtNgay">Ngày</label>
                    <asp:TextBox ID="txtNgay" runat="server" CssClass="form-control" TextMode="Date" required />
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Thêm Điểm Danh" OnClick="btnAdd_Click" />
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <div class="table-container">
                       <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="No record to display" AutoGenerateColumns="False"
                        OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" PageSize="4" DataKeyNames="Id" OnRowEditing="GridView1_RowEditing"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Số thứ tự" ReadOnly="True">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Mã Học Sinh">
                                <ItemTemplate>
                                    <%# Eval("MaHocSinh") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditMaHocSinh" runat="server" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã Lớp">
                                <ItemTemplate>
                                    <%# Eval("MaLop") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditMaLop" runat="server" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mã Môn Học">
                                <ItemTemplate>
                                    <%# Eval("MaMonHoc") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditMaMonHoc" runat="server" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trạng Thái">
                                <ItemTemplate>
                                    <div class="status-container">
                                        <asp:Label ID="lblTrangThai" runat="server" Text='<%# Convert.ToBoolean(Eval("TrangThai")) ? "Có mặt" : "Vắng mặt" %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditTrangThai" runat="server">
                                        <asp:ListItem Text="Có mặt" Value="true"></asp:ListItem>
                                        <asp:ListItem Text="Vắng mặt" Value="false"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Ngay" HeaderText="Ngày" DataFormatString="{0:yyyy/MM/dd HH:mm:ss}" />
                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                    </asp:GridView>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
 
