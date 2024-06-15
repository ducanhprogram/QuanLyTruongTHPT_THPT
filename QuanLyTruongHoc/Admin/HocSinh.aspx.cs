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
    public partial class HocSinh : System.Web.UI.Page
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
                GetStudents();
            }
        }

        private void GetStudents()
        {
            DataTable dt = fn.Fetch(@"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) as [Sr.No], Id, MaHocSinh, Ten, NgaySinh, GioiTinh, SoDienThoai, DiaChi, MaLop FROM HocSinh");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maHocSinh = txtMaHocSinh.Text.Trim();
                string maLop = ddlMaLop.SelectedValue;
                DataTable dt = fn.Fetch("SELECT * FROM HocSinh WHERE MaHocSinh = '" + maHocSinh + "'");
                if (dt.Rows.Count == 0)
                {
                    string query = "INSERT INTO HocSinh (MaHocSinh, Ten, NgaySinh, GioiTinh, SoDienThoai, DiaChi, MaLop) VALUES (N'" + maHocSinh + "', N'" + txtTen.Text.Trim() + "', '" + txtNgaySinh.Text.Trim() + "', N'" + ddlGioiTinh.SelectedValue + "', " + txtSoDienThoai.Text.Trim() + ", N'" + txtDiaChi.Text.Trim() + "', N'" + maLop + "')";
                    fn.Query(query);
                    lblMsg.Text = "Inserted Successfully!!!";
                    lblMsg.CssClass = "alert alert-success";
                    txtMaHocSinh.Text = string.Empty;
                    txtTen.Text = string.Empty;
                    txtNgaySinh.Text = string.Empty;
                    txtSoDienThoai.Text = string.Empty;
                    txtDiaChi.Text = string.Empty;
                    ddlMaLop.SelectedIndex = 0;
                    GetStudents();
                }
                else
                {
                    lblMsg.Text = "Mã học sinh <b>'" + maHocSinh + "'</b> đã tồn tại!!!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetStudents();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetStudents();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int studentId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("DELETE FROM HocSinh WHERE Id = " + studentId);
                lblMsg.Text = "Học sinh xóa thành công!!!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetStudents();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetStudents();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int studentId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string ten = (row.FindControl("txtTenEdit") as TextBox).Text;
                string ngaySinh = (row.FindControl("txtNgaySinhEdit") as TextBox).Text;
         
                string soDienThoai = (row.FindControl("txtSoDienThoaiEdit") as TextBox).Text;
                string diaChi = (row.FindControl("txtDiaChiEdit") as TextBox).Text;
                string maLop = (row.FindControl("ddlMaLopEdit") as DropDownList).SelectedValue;

                fn.Query("UPDATE HocSinh SET Ten = N'" + ten.Trim() + "', NgaySinh = '" + ngaySinh.Trim() + "', SoDienThoai = " + soDienThoai.Trim() + ", DiaChi = N'" + diaChi.Trim() + "', MaLop = N'" + maLop.Trim() + "' WHERE Id = " + studentId);
                lblMsg.Text = "Student Updated Successfully!!!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetStudents();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }
}