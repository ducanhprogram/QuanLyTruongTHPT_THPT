<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DiemDanhChiTietSinhVienUC.ascx.cs" Inherits="QuanLyTruongHoc.DiemDanhChiTietSinhVienUC" %>


 <style>
     body {
         background-color: #fff;
         font-weight: 600;
     }

     h3 {
         color: #000;
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

 <div class="container p-md-4 p-sm-4">
     <div>
         <asp:Label ID="lblMsg" runat="server"></asp:Label>
     </div>

     <h3 class="text-center">Chi Tiết Điểm Danh Học Sinh</h3>

     <div class="row mb-3">
         <div class="col-md-4">
             <label style="font-size: 20px" for="ddlMaHocSinh">Mã học sinh</label>
             <asp:DropDownList ID="ddlMaHocSinh" runat="server" CssClass="form-control"></asp:DropDownList>
         </div>
         <div class="col-md-4">
             <label style="font-size: 20px" for="ddlThang">Tháng</label>
             <asp:DropDownList ID="ddlThang" runat="server" CssClass="form-control">
                 <asp:ListItem Text="1" Value="1"></asp:ListItem>
                 <asp:ListItem Text="2" Value="2"></asp:ListItem>
                 <asp:ListItem Text="3" Value="3"></asp:ListItem>
                 <asp:ListItem Text="4" Value="4"></asp:ListItem>
                 <asp:ListItem Text="5" Value="5"></asp:ListItem>
                 <asp:ListItem Text="6" Value="6"></asp:ListItem>
                 <asp:ListItem Text="7" Value="7"></asp:ListItem>
                 <asp:ListItem Text="8" Value="8"></asp:ListItem>
                 <asp:ListItem Text="9" Value="9"></asp:ListItem>
                 <asp:ListItem Text="10" Value="10"></asp:ListItem>
                 <asp:ListItem Text="11" Value="11"></asp:ListItem>
                 <asp:ListItem Text="12" Value="12"></asp:ListItem>
             </asp:DropDownList>
         </div>
         <div class="col-md-4">
             <label style="font-size: 20px" for="ddlNam">Năm</label>
             <asp:DropDownList ID="ddlNam" runat="server" CssClass="form-control"></asp:DropDownList>
         </div>
     </div>

     <div class="row mb-3">
         <div class="col-md-12 text-center">
             <asp:Button ID="btnXemChiTiet" runat="server" CssClass="btn btn-primary" Text="Xem Chi Tiết" OnClick="btnXemChiTiet_Click" />
         </div>
     </div>

     <div class="row mb-3">
         <div class="col-md-12">
             <div class="table-container">
                 <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="No record to display" AutoGenerateColumns="False">
                     <Columns>
                         <asp:BoundField DataField="MaHocSinh" HeaderText="Mã Học Sinh" />
                         <asp:BoundField DataField="TenLop" HeaderText="Tên Lớp" />
                         <asp:BoundField DataField="TenMonHoc" HeaderText="Tên Môn Học" />
                         <asp:BoundField DataField="Thang" HeaderText="Tháng" />
                         <asp:BoundField DataField="Nam" HeaderText="Năm" />
                         <asp:BoundField DataField="SoBuoiCoMat" HeaderText="Số buổi có mặt" />
                         <asp:BoundField DataField="SoBuoiVangMat" HeaderText="Số buổi vắng mặt" />
                     </Columns>
                 </asp:GridView>
             </div>
         </div>
     </div>
 </div>