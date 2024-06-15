<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="ChiTietDiemDanhHocSinh.aspx.cs" Inherits="QuanLyTruongHoc.Admin.ChiTietDiemDanhHocSinh" %>

<%@ Register Src="~/DiemDanhChiTietSinhVienUC.ascx" TagPrefix="uc" TagName="DiemDanhChiTietSinhVien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <uc:DiemDanhChiTietSinhVien ID="ChiTietDiemDanhSinhVien1" runat="server" />

</asp:Content>
