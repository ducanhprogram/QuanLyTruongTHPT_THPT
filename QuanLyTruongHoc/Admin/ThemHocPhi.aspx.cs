using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc.Admin
{
    public partial class ThemHocPhi : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["admin"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadDropDownLists();
                GetHocPhi();
            }
        }

        private void LoadDropDownLists()
        {
            // Load MaHocSinh
            DataTable dtHocSinh = fn.Fetch("SELECT MaHocSinh FROM HocSinh");
            ddlMaHocSinh.DataSource = dtHocSinh;
            ddlMaHocSinh.DataTextField = "MaHocSinh";
            ddlMaHocSinh.DataValueField = "MaHocSinh";
            ddlMaHocSinh.DataBind();
            ddlMaHocSinh.Items.Insert(0, new ListItem("Chọn mã học sinh", "0"));

            // Load MaMonHoc
            DataTable dtMonHoc = fn.Fetch("SELECT MaMonHoc FROM MonHoc");
            ddlMaMonHoc.DataSource = dtMonHoc;
            ddlMaMonHoc.DataTextField = "MaMonHoc";
            ddlMaMonHoc.DataValueField = "MaMonHoc";
            ddlMaMonHoc.DataBind();
            ddlMaMonHoc.Items.Insert(0, new ListItem("Chọn mã môn học", "0"));

            // Load MaLop
            DataTable dtLop = fn.Fetch("SELECT MaLop FROM LopHoc");
            ddlMaLop.DataSource = dtLop;
            ddlMaLop.DataTextField = "MaLop";
            ddlMaLop.DataValueField = "MaLop";
            ddlMaLop.DataBind();
            ddlMaLop.Items.Insert(0, new ListItem("Chọn mã lớp", "0"));
        }

        private string FormatAmount(int amount)
        {
            // Formats the amount with commas and appends " VNĐ"
            return string.Format("{0:N0} VNĐ", amount);
        }

        private void GetHocPhi()
        {
            DataTable dt = fn.Fetch(@"SELECT MaHocPhi, MaHocSinh, MaMonHoc, MaLop, NgayThanhToan, NamHoc, TongTien FROM HocPhi");
            dt.Columns.Add("FormattedTongTien", typeof(string));

            foreach (DataRow row in dt.Rows)
            {
                int tongTien = Convert.ToInt32(row["TongTien"]);
                row["FormattedTongTien"] = FormatAmount(tongTien);
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maHocSinh = ddlMaHocSinh.SelectedValue;
                string maMonHoc = ddlMaMonHoc.SelectedValue;
                string maLop = ddlMaLop.SelectedValue;
                string ngayThanhToan = DateTime.Now.ToString("yyyy-MM-dd"); // Set current date and time
                string namHoc = txtNamHoc.Text;
                string tongTien = txtTongTien.Text;

                string query = @"INSERT INTO HocPhi (MaHocSinh, MaMonHoc, MaLop, NgayThanhToan, NamHoc, TongTien) 
                         VALUES ('" + maHocSinh + "','" + maMonHoc + "','" + maLop + "','" + ngayThanhToan + "','" + namHoc + "','" + tongTien + "')";
                fn.Query(query);
                lblMsg.Text = "Thêm học phí thành công!";
                lblMsg.CssClass = "alert alert-success";
                GetHocPhi();
                ResetFields();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Có lỗi xảy ra: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }


        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetHocPhi();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maHocPhi = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string query = @"DELETE FROM HocPhi WHERE MaHocPhi = '" + maHocPhi + "'";
            fn.Query(query);
            lblMsg.Text = "Xóa thành công!";
            lblMsg.CssClass = "alert alert-success";
            GetHocPhi();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetHocPhi();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlMaHocSinhEdit = (DropDownList)e.Row.FindControl("ddlMaHocSinhEdit");
                    DropDownList ddlMaMonHocEdit = (DropDownList)e.Row.FindControl("ddlMaMonHocEdit");
                    DropDownList ddlMaLopEdit = (DropDownList)e.Row.FindControl("ddlMaLopEdit");

                    // Load MaHocSinh
                    DataTable dtHocSinh = fn.Fetch("SELECT MaHocSinh FROM HocSinh");
                    ddlMaHocSinhEdit.DataSource = dtHocSinh;
                    ddlMaHocSinhEdit.DataTextField = "MaHocSinh";
                    ddlMaHocSinhEdit.DataValueField = "MaHocSinh";
                    ddlMaHocSinhEdit.DataBind();

                    // Load MaMonHoc
                    DataTable dtMonHoc = fn.Fetch("SELECT MaMonHoc FROM MonHoc");
                    ddlMaMonHocEdit.DataSource = dtMonHoc;
                    ddlMaMonHocEdit.DataTextField = "MaMonHoc";
                    ddlMaMonHocEdit.DataValueField = "MaMonHoc";
                    ddlMaMonHocEdit.DataBind();

                    // Load MaLop
                    DataTable dtLop = fn.Fetch("SELECT MaLop FROM LopHoc");
                    ddlMaLopEdit.DataSource = dtLop;
                    ddlMaLopEdit.DataTextField = "MaLop";
                    ddlMaLopEdit.DataValueField = "MaLop";
                    ddlMaLopEdit.DataBind();
                }
            }
        }


        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int maHocPhi = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                DropDownList ddlMaHocSinhEdit = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlMaHocSinhEdit");
                DropDownList ddlMaMonHocEdit = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlMaMonHocEdit");
                DropDownList ddlMaLopEdit = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlMaLopEdit");
                TextBox txtNgayThanhToanEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtNgayThanhToanEdit");
                TextBox txtNamHocEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtNamHocEdit");
                TextBox txtTongTienEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtTongTienEdit");

                // Get selected values from drop-down lists
                string maHocSinh = ddlMaHocSinhEdit.SelectedValue;
                string maMonHoc = ddlMaMonHocEdit.SelectedValue;
                string maLop = ddlMaLopEdit.SelectedValue;

                // Update other fields
                string ngayThanhToan = DateTime.Parse(txtNgayThanhToanEdit.Text).ToString("yyyy-MM-dd");
                string namHoc = txtNamHocEdit.Text;
                string tongTien = txtTongTienEdit.Text;

                // Perform update query
                string query = @"UPDATE HocPhi SET MaHocSinh = '" + maHocSinh + "', MaMonHoc = '" + maMonHoc + "', MaLop = '" + maLop + "', " +
                                     "NgayThanhToan = '" + ngayThanhToan + "', NamHoc = '" + namHoc + "', TongTien = '" + tongTien + "' " +
                                 "WHERE MaHocPhi = '" + maHocPhi + "'";
                fn.Query(query);

                // Update success message
                lblMsg.Text = "Cập nhật thành công!";
                lblMsg.CssClass = "alert alert-success";

                // Complete the update process
                GridView1.EditIndex = -1;
                GetHocPhi();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Có lỗi xảy ra: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }




        private void ResetFields()
        {
            ddlMaHocSinh.SelectedIndex = 0;
            ddlMaMonHoc.SelectedIndex = 0;
            ddlMaLop.SelectedIndex = 0;
            txtNgayThanhToan.Text = "";
            txtNamHoc.Text = "";
            txtTongTien.Text = "";
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetHocPhi();
        }
    }
}




