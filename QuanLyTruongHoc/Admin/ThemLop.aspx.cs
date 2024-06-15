using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc.Admin
{
    public partial class ThemLop : System.Web.UI.Page
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
                GetClasses();
            }
        }


        private void GetClasses()
        {
            DataTable dt = fn.Fetch(@"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) as [Sr.No], Id, MaLop, TenLop, SoLuong, MaGiaoVien FROM LopHoc");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maLop = txtMaLop.Text.Trim();
                string maGiaoVien = ddlMaGiaoVien.SelectedValue;
                DataTable dt = fn.Fetch("SELECT * FROM LopHoc WHERE MaLop = '" + maLop + "'");
                if (dt.Rows.Count == 0)
                {
                    string query = "INSERT INTO LopHoc (MaLop, TenLop, SoLuong, MaGiaoVien) VALUES (N'" + maLop + "', N'" + txtTenLop.Text.Trim() + "', " + txtSoLuong.Text.Trim() + ", N'" + maGiaoVien + "')";
                    fn.Query(query);
                    lblMsg.Text = "Inserted Successfully!!!";
                    lblMsg.CssClass = "alert alert-success";
                    txtMaLop.Text = string.Empty;
                    txtTenLop.Text = string.Empty;
                    txtSoLuong.Text = string.Empty;
                    ddlMaGiaoVien.SelectedIndex = 0;
                    GetClasses();
                }
                else
                {
                    lblMsg.Text = "Mã lớp <b>'" + maLop + "'</b> đã tồn tại!!!";
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
            GetClasses();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetClasses();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int classId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("DELETE FROM LopHoc WHERE Id = " + classId);
                lblMsg.Text = "Lớp học xóa thành công!!!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetClasses();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetClasses();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int classId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);

                string maLop = (row.FindControl("txtMaLopEdit") as TextBox).Text.Trim();
                string tenLop = (row.FindControl("txtTenLopEdit") as TextBox).Text.Trim();
                string soLuong = (row.FindControl("txtSoLuongEdit") as TextBox).Text.Trim();
                string maGiaoVien = (row.FindControl("ddlMaGiaoVienEdit") as DropDownList).SelectedValue.Trim();

                fn.Query("UPDATE LopHoc SET MaLop = N'" + maLop + "', TenLop = N'" + tenLop + "', SoLuong = " + soLuong + ", MaGiaoVien = N'" + maGiaoVien + "' WHERE Id = " + classId);

                lblMsg.Text = "Lớp được cập nhật thành công!!!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetClasses();
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
