using QuanLyTruongHoc.Models;
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
    public partial class MonHoc : System.Web.UI.Page
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
                GetSubjects();
            }
        }

        private void GetSubjects()
        {
            DataTable dt = fn.Fetch("SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) as [Sr.No], Id, MaMonHoc, TenMonHoc FROM MonHoc");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maMonHoc = txtMaMonHoc.Text.Trim();
                DataTable dt = fn.Fetch("SELECT * FROM MonHoc WHERE MaMonHoc = '" + maMonHoc + "'");
                if (dt.Rows.Count == 0)
                {
                    string query = "INSERT INTO MonHoc (MaMonHoc, TenMonHoc) VALUES (N'" + maMonHoc + "', N'" + txtTenMonHoc.Text.Trim() + "')";
                    fn.Query(query);
                    lblMsg.Text = "Inserted Successfully!!!";
                    lblMsg.CssClass = "alert alert-success";
                    txtMaMonHoc.Text = string.Empty;
                    txtTenMonHoc.Text = string.Empty;
                    GetSubjects();
                }
                else
                {
                    lblMsg.Text = "Mã môn học <b>'" + maMonHoc + "'</b> đã tồn tại!!!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int subjectId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("DELETE FROM MonHoc WHERE Id = " + subjectId);
                lblMsg.Text = "Môn học đã xóa thành công!!!";
                lblMsg.CssClass = "alert alert-success";
                GetSubjects();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        //Phân Trang
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetSubjects(); // Gọi lại hàm lấy dữ liệu để hiển thị ở trang mới
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetSubjects();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int subjectId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string tenMonHoc = (row.FindControl("txtTenMonHocEdit") as TextBox).Text;

                fn.Query("UPDATE MonHoc SET TenMonHoc = N'" + tenMonHoc.Trim() + "' WHERE Id = " + subjectId);
                lblMsg.Text = "Subject Updated Successfully!!!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetSubjects();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetSubjects();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }
}
