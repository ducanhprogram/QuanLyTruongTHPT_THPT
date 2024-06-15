<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="GiaoVienBoMon.aspx.cs" Inherits="QuanLyTruongHoc.Admin.GiaoVienBoMon" %>
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

    <div style="width:100%; height:720px; background-repeat:no-repeat;background-size:cover;background-attachment:fixed">
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Thêm Giáo Viên Bộ Môn</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaLop">Mã Lớp</label>
                    <asp:DropDownList ID="ddlMaLop" runat="server" CssClass="form-control" required></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMaLop" runat="server" ErrorMessage="Yêu cầu chọn Mã Lớp" ForeColor="Red" ControlToValidate="ddlMaLop" InitialValue="0"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaMonHoc">Mã Môn Học</label>
                    <asp:DropDownList ID="ddlMaMonHoc" runat="server" CssClass="form-control" required></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMaMonHoc" runat="server" ErrorMessage="Yêu cầu chọn Mã Môn Học" ForeColor="Red" ControlToValidate="ddlMaMonHoc" InitialValue="0"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaGiaoVien">Mã Giáo Viên</label>
                    <asp:DropDownList ID="ddlMaGiaoVien" runat="server" CssClass="form-control" required></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMaGiaoVien" runat="server" ErrorMessage="Yêu cầu chọn Mã Giáo Viên" ForeColor="Red" ControlToValidate="ddlMaGiaoVien" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Thêm giáo viên môn" OnClick="btnAdd_Click" />
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <div class="table-container">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="No record to display" AutoGenerateColumns="False"
                            OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" PageSize="4" OnRowCancelingEdit="GridView1_RowCancelingEdit" DataKeyNames="Id"
                            OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="SrNo" HeaderText="Số thứ tự" ReadOnly="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                
                                <asp:TemplateField HeaderText="Mã Lớp">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMaLopEdit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaLop" runat="server" Text='<%# Eval("MaLop") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Mã Môn Học">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMaMonHocEdit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaMonHoc" runat="server" Text='<%# Eval("MaMonHoc") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Mã Giáo Viên">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMaGiaoVienEdit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaGiaoVien" runat="server" Text='<%# Eval("MaGiaoVien") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:CommandField CausesValidation="false" ShowEditButton="True" HeaderText="Operation" ShowDeleteButton="true">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <HeaderStyle BackColor="#5558C9"  ForeColor="White"/>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
