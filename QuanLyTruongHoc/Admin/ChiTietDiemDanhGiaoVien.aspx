<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="ChiTietDiemDanhGiaoVien.aspx.cs" Inherits="QuanLyTruongHoc.Admin.ChiTietDiemDanhGiaoVien" %>
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
             width: 100%; /* Đặt chiều rộng của container bảng là 100% */
            overflow-x: auto; /* Cho phép cuộn ngang nếu bảng quá lớn */
          }

        .table {
            width: 100%; /* Đặt chiều rộng của bảng là 100% */
            max-width: 100%; /* Đảm bảo bảng không vượt quá kích thước container */
            background-color: #fff; /* Màu nền của bảng */
            color: #000; /* Màu chữ của bảng */
        }

        .table th, .table td {
            padding: 15px; /* Tăng khoảng cách trong các ô bảng */
            text-align: left; /* Căn chỉnh văn bản trong các ô bảng */
        }

        .table th {
            background-color: #5558C9; /* Màu nền cho tiêu đề bảng */
            color: #fff; /* Màu chữ cho tiêu đề bảng */
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
        <div width:100%; height:720px; background-repeat:no-repeat;background-size:cover;background-attachment:fixed">
    <div class="container p-md-4 p-sm-4">
        <div>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>
        <h3 class="text-center">Chi tiết điểm danh giáo viên</h3>

      <%--margin-bottom--%>
        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
            <%-- Giáo viên - Teachers --%>
             <div class="col-md-6">
                <label style="font-size: 20px" for="ddlTeacher">Giáo viên</label>
                 <asp:DropDownList ID="ddlTeacher" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Vui lòng chọn lớp học"
                     ControlToValidate="ddlTeacher" InitialValue="Select Class" Display="Dynamic" SetFocusOnError="True" ForeColor="Red">
                 </asp:RequiredFieldValidator>
           </div>

            <%-- Month - Tháng --%>
            <div class="col-md-6">
                <label style="font-size: 20px" for="txtSubject">Tháng</label>
                <asp:TextBox ID="txtMonth" runat="server" CssClass="form-control" TextMode="Month" requỉed></asp:TextBox>
            </div>

        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnCheckAttendance" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Thông tin điểm danh" OnClick="btnCheckAttendance_Click"/>
            </div>
        </div>


         <div class="row mb-3 mr-lg-5 ml-lg-5">
           <div class="col-md-12">
                   <%--"--%>
                  <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Không có dữ liệu để hiển thị" AutoGenerateColumns="False"  >    <%-- Sr.No - Số thứ tự --%>

                    <Columns>
                        <asp:BoundField DataField="Sr.No" HeaderText="Số thứ tự">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="Ten" HeaderText="Tên">
                          <ItemStyle HorizontalAlign="Center" />
                         </asp:BoundField>
                    

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="label1" Text='<%# Boolean.Parse( Eval("TrangThai").ToString()) ? "Có mặt" : "Vắng mặt" %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Ngay" HeaderText="Ngày" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}">
                         <ItemStyle HorizontalAlign="Center" />
                         </asp:BoundField>
     
                
                    </Columns>
                  <HeaderStyle BackColor="#5558C9"  ForeColor="White"/>
                </asp:GridView>

               </div>
           </div>
        </div>

    </div>
</asp:Content>
