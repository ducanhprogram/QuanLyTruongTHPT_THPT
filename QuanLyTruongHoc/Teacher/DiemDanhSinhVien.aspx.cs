using QuanLyTruongHoc.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc.Teacher
{
    public partial class DiemDanhSinhVien : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["staff"] == null)
                {
                    Response.Redirect("../Login.aspx");
                }

                LoadDropDownLists();
                GetAttendanceRecords();
            }
        }

        private void LoadDropDownLists()
        {
            DataTable dtHocSinh = fn.Fetch("SELECT * FROM HocSinh");
            ddlMaHocSinh.DataSource = dtHocSinh;
            ddlMaHocSinh.DataTextField = "MaHocSinh";
            ddlMaHocSinh.DataValueField = "MaHocSinh";
            ddlMaHocSinh.DataBind();

            DataTable dtLop = fn.Fetch("SELECT * FROM LopHoc");
            ddlMaLop.DataSource = dtLop;
            ddlMaLop.DataTextField = "MaLop";
            ddlMaLop.DataValueField = "MaLop";
            ddlMaLop.DataBind();

            DataTable dtMonHoc = fn.Fetch("SELECT * FROM MonHoc");
            ddlMaMonHoc.DataSource = dtMonHoc;
            ddlMaMonHoc.DataTextField = "MaMonHoc";
            ddlMaMonHoc.DataValueField = "MaMonHoc";
            ddlMaMonHoc.DataBind();
        }

        private void LoadEditDropDownLists(DropDownList ddl, string query, string textField, string valueField, string selectedValue)
        {
            DataTable dt = fn.Fetch(query);
            ddl.DataSource = dt;
            ddl.DataTextField = textField;
            ddl.DataValueField = valueField;
            ddl.DataBind();

            if (!string.IsNullOrEmpty(selectedValue) && ddl.Items.FindByValue(selectedValue) != null)
            {
                ddl.SelectedValue = selectedValue;
            }
        }

        private void GetAttendanceRecords()
        {
            DataTable dt = fn.Fetch(@"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No], Id, MaHocSinh, MaLop, MaMonHoc, TrangThai, CONVERT(varchar, Ngay, 120) AS Ngay FROM DiemDanh_SinhVien");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maHocSinh = ddlMaHocSinh.SelectedValue;
                string maLop = ddlMaLop.SelectedValue;
                string maMonHoc = ddlMaMonHoc.SelectedValue;
                bool trangThai = radCoMat.Checked;
                if (radVangMat.Checked)
                {
                    trangThai = false;
                }
                string ngay = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");

                string query = "INSERT INTO DiemDanh_SinhVien (MaHocSinh, MaLop, MaMonHoc, TrangThai, Ngay) " +
                               "VALUES (N'" + maHocSinh + "', N'" + maLop + "', N'" + maMonHoc + "', '" + trangThai + "', '" + ngay + "')";
                fn.Query(query);
                lblMsg.Text = "Thêm Điểm Danh Thành Công!!!";
                lblMsg.CssClass = "alert alert-success";
                GetAttendanceRecords();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Đã xảy ra lỗi: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetAttendanceRecords();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetAttendanceRecords();

            GridViewRow row = GridView1.Rows[e.NewEditIndex];

            DropDownList ddlEditMaHocSinh = row.FindControl("ddlEditMaHocSinh") as DropDownList;
            DropDownList ddlEditMaLop = row.FindControl("ddlEditMaLop") as DropDownList;
            DropDownList ddlEditMaMonHoc = row.FindControl("ddlEditMaMonHoc") as DropDownList;

            if (ddlEditMaHocSinh != null && ddlEditMaLop != null && ddlEditMaMonHoc != null)
            {
                string currentMaHocSinh = (row.FindControl("lblMaHocSinh") as Label)?.Text;
                string currentMaLop = (row.FindControl("lblMaLop") as Label)?.Text;
                string currentMaMonHoc = (row.FindControl("lblMaMonHoc") as Label)?.Text;

                LoadEditDropDownLists(ddlEditMaHocSinh, "SELECT MaHocSinh FROM HocSinh", "MaHocSinh", "MaHocSinh", currentMaHocSinh);
                LoadEditDropDownLists(ddlEditMaLop, "SELECT MaLop FROM LopHoc", "MaLop", "MaLop", currentMaLop);
                LoadEditDropDownLists(ddlEditMaMonHoc, "SELECT MaMonHoc FROM MonHoc", "MaMonHoc", "MaMonHoc", currentMaMonHoc);
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                DropDownList ddlEditMaHocSinh = GridView1.Rows[e.RowIndex].FindControl("ddlEditMaHocSinh") as DropDownList;
                DropDownList ddlEditMaLop = GridView1.Rows[e.RowIndex].FindControl("ddlEditMaLop") as DropDownList;
                DropDownList ddlEditMaMonHoc = GridView1.Rows[e.RowIndex].FindControl("ddlEditMaMonHoc") as DropDownList;
                DropDownList ddlEditTrangThai = GridView1.Rows[e.RowIndex].FindControl("ddlEditTrangThai") as DropDownList;

                if (ddlEditMaHocSinh != null && ddlEditMaLop != null && ddlEditMaMonHoc != null && ddlEditTrangThai != null)
                {
                    string maHocSinh = ddlEditMaHocSinh.SelectedValue;
                    string maLop = ddlEditMaLop.SelectedValue;
                    string maMonHoc = ddlEditMaMonHoc.SelectedValue;
                    bool trangThai = Convert.ToBoolean(ddlEditTrangThai.SelectedValue);

                    string query = "UPDATE DiemDanh_SinhVien SET MaHocSinh=N'" + maHocSinh + "', MaLop=N'" + maLop + "', MaMonHoc=N'" + maMonHoc + "', TrangThai='" + trangThai + "' WHERE Id=" + id;
                    fn.Query(query);
                    GridView1.EditIndex = -1;
                    GetAttendanceRecords();
                    lblMsg.Text = "Cập nhật điểm danh thành công!";
                    lblMsg.CssClass = "alert alert-success";
                }
                else
                {
                    lblMsg.Text = "Không thể tìm thấy điều khiển để cập nhật!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Đã xảy ra lỗi: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetAttendanceRecords();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
                string query = "DELETE FROM DiemDanh_SinhVien WHERE Id=" + id;
                fn.Query(query);
                GetAttendanceRecords();
                lblMsg.Text = "Xóa điểm danh thành công!";
                lblMsg.CssClass = "alert alert-success";
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Đã xảy ra lỗi: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}



