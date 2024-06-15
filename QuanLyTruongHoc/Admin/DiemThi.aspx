<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="DiemThi.aspx.cs" Inherits="QuanLyTruongHoc.Admin.DiemThi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script type="text/javascript">
    function validateNumberInput(input) {
        input.value = input.value.replace(/[^0-9.]/g, '');
    }

    document.getElementById('<%= txtDiemMon.ClientID %>').addEventListener('input', function() {
        validateNumberInput(this);
    });

    document.getElementById('<%= txtDiemTb.ClientID %>').addEventListener('input', function() {
        validateNumberInput(this);
    });
    </script>


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
            <h3 class="text-center">Quản lý Điểm Thi</h3>

            <!-- Form for adding new record -->
            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                
               <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaHocSinh">Chọn Mã Học Sinh</label>
                    <asp:DropDownList ID="ddlMaHocSinh" runat="server" CssClass="form-control" required></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMaHocSinh" runat="server" ErrorMessage="Yêu cầu chọn Mã Học Sinh" ForeColor="Red" ControlToValidate="ddlMaHocSinh" InitialValue="0"></asp:RequiredFieldValidator>
                </div>
                
                   <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlMaMonHoc">Chọn Mã Môn Học</label>
                    <asp:DropDownList ID="ddlMaMonHoc" runat="server" CssClass="form-control" required></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMaMonHoc" runat="server" ErrorMessage="Yêu cầu chọn Mã Môn Học" ForeColor="Red" ControlToValidate="ddlMaMonHoc" InitialValue="0"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-4">
                    <label style="font-size: 20px" for="txtDiemMon">Điểm Môn</label>
                    <asp:TextBox ID="txtDiemMon" runat="server" CssClass="form-control" required></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDiemMon" runat="server" ErrorMessage="Yêu cầu nhập Điểm Môn" ForeColor="Red" ControlToValidate="txtDiemMon"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-4">
                    <label style="font-size: 20px" for="txtDiemTb">Điểm Trung Bình</label>
                    <asp:TextBox ID="txtDiemTb" runat="server" CssClass="form-control" required></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDiemTb" runat="server" ErrorMessage="Yêu cầu nhập Điểm Trung Bình" ForeColor="Red" ControlToValidate="txtDiemTb"></asp:RequiredFieldValidator>
                </div>

                 <div class="col-md-4">
                    <label style="font-size: 20px" for="ddlHocKy">Học Kỳ</label>
                    <asp:DropDownList ID="ddlHocKy" runat="server" CssClass="form-control" required>
                        <asp:ListItem Text="1" Value="1" />
                        <asp:ListItem Text="2" Value="2" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorHocKy" runat="server" ErrorMessage="Yêu cầu chọn Học Kỳ" ForeColor="Red" ControlToValidate="ddlHocKy"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-4">
                    <label style="font-size: 20px" for="txtNamHoc">Năm Học</label>
                    <asp:TextBox ID="txtNamHoc" runat="server" CssClass="form-control" required></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorNamHoc" runat="server" ErrorMessage="Yêu cầu nhập Năm Học" ForeColor="Red" ControlToValidate="txtNamHoc"></asp:RequiredFieldValidator>
                </div>
            </div>

            <!-- Button for adding new record -->
            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Thêm Điểm Thi" OnClick="btnAdd_Click" />
                </div>
            </div>

            <!-- Gridview for displaying records -->
            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <div class="table-container">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="No record to display" AutoGenerateColumns="False"
                            OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" PageSize="10" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                            DataKeyNames="Id" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Mã Học Sinh">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMaHocSinhEdit" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaHocSinh" runat="server" Text='<%# Eval("MaHocSinh") %>'></asp:Label>
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
                                
                                <asp:TemplateField HeaderText="Điểm Môn">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDiemMonEdit" runat="server" CssClass="form-control" DataFormatString="{0:F2}" Text='<%# Eval("Diem_Mon") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiemMon" runat="server" DataFormatString="{0:F2}" Text='<%# Eval("Diem_Mon") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Điểm Trung Bình">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDiemTbEdit" runat="server" CssClass="form-control" Text='<%# Eval("DiemTb") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiemTb" runat="server" Text='<%# Eval("DiemTb") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Học Kỳ">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlHocKyEdit" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblHocKy" runat="server" Text='<%# Eval("HocKy") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Năm Học">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNamHocEdit" runat="server" CssClass="form-control" Text='<%# Eval("NamHoc") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblNamHoc" runat="server" Text='<%# Eval("NamHoc") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                                <asp:CommandField CausesValidation="false" ShowEditButton="True" HeaderText="Operation" ShowDeleteButton="true">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <HeaderStyle BackColor="#5558C9" ForeColor="White"/>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
