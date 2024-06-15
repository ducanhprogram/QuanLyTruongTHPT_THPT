<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher/TeacherMst.Master" AutoEventWireup="true" CodeBehind="ChiTietDiemThi.aspx.cs" Inherits="QuanLyTruongHoc.Teacher.ChiTietDiemThi" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


             <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap');
    html {
        font-family: "Poppins", sans-serif !important;
    }
    body {
        font-family: "Poppins", sans-serif !important;
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
        <h3 class="text-center">Thông tin điểm</h3>
        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <div class="col-md-6">
                <label style="font-size: 20px" for="ddlSubject">Mã Môn Học</label>
                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vui lòng chọn mã môn học."
                    ControlToValidate="ddlSubject" InitialValue="0" Display="Dynamic" SetFocusOnError="True" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>
            <div class="col-md-6">
                <label style="font-size: 20px" for="ddlStudent">Mã học sinh</label>
                <asp:DropDownList ID="ddlStudent" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Vui lòng chọn mã học sinh."
                    ControlToValidate="ddlStudent" InitialValue="0" Display="Dynamic" SetFocusOnError="True" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" OnClick="btnSearch_Click" Text="Tra cứu điểm" />
            </div>
        </div>
        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">
                <div class="table-container">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Không có bản ghi nào để hiển thị" AutoGenerateColumns="False" 
                        OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" PageSize="8">
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Số thứ tự">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Id" HeaderText="Mã bài thi">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="HocSinhName" HeaderText="Tên học sinh">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TenMonHoc" HeaderText="Môn học">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MaHocSinh" HeaderText="Mã học sinh">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Diem_Mon" HeaderText="Điểm môn">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DiemTb" HeaderText="Điểm trung bình">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="HocKy" HeaderText="Học kỳ">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NamHoc" HeaderText="Năm học">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White"/>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</div>


</asp:Content>
