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
    public partial class GiaoVien : System.Web.UI.Page
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
                GetTeacher();
            }
        }

        private void GetTeacher()
        {
            DataTable dt = fn.Fetch(@"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No], Id, MaGiaoVien, Ten, NgaySinh, GioiTinh, SoDienThoai,
            Email, DiaChi, Password FROM GiaoVien ");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlGender.SelectedValue != "0")
                {
                    string email = txtEmail.Text.Trim();
                    string maGiaoVien = txtMaGiaoVien.Text.Trim();

                    DataTable dtEmail = fn.Fetch("SELECT * FROM GiaoVien WHERE Email = '" + email + "'");
                    DataTable dtMaGiaoVien = fn.Fetch("SELECT * FROM GiaoVien WHERE MaGiaoVien = '" + maGiaoVien + "'");

                    if (dtEmail.Rows.Count == 0 && dtMaGiaoVien.Rows.Count == 0)
                    {
                        string query = "INSERT INTO GiaoVien (MaGiaoVien, Ten, NgaySinh, GioiTinh, SoDienThoai, Email, DiaChi, Password) " +
                                   "VALUES (N'" + txtMaGiaoVien.Text.Trim() + "', N'" + txtName.Text.Trim() + "', '" + txtNgaySinh.Text.Trim() + "', '" + ddlGender.SelectedValue + "'," +
                                   " '" + txtMobile.Text.Trim() + "', '" + email + "', N'" + txtDiaChi.Text.Trim() + "'," +
                                   " '" + txtPassword.Text.Trim() + "')";
                        fn.Query(query);
                        lblMsg.Text = "Inserted Successfully!!!";
                        lblMsg.CssClass = "alert alert-success";
                        ddlGender.SelectedIndex = 0;
                        txtName.Text = string.Empty;
                        txtNgaySinh.Text = string.Empty;
                        txtMobile.Text = string.Empty;
                        txtEmail.Text = string.Empty;
                        txtDiaChi.Text = string.Empty;
                        txtPassword.Text = string.Empty;
                        txtMaGiaoVien.Text = string.Empty;
                        GetTeacher();
                    }
                    else
                    {
                        lblMsg.Text = "Email '" + email + "' hoặc Mã Giáo Viên '" + maGiaoVien + "' đã tồn tại!!! ";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
                else
                {
                    lblMsg.Text = "Yêu cầu chọn giới tính";
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
            GetTeacher();
        }


        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetTeacher();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int teacherId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Id"]);
                fn.Query("DELETE FROM GiaoVien WHERE Id = " + teacherId);
                lblMsg.Text = "Giáo viên được xóa thành công!!!";
                lblMsg.CssClass = "alert alert-success";
                GetTeacher();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void CustomValidatorMaGiaoVien_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string maGiaoVien = args.Value;
            DataTable dt = fn.Fetch("SELECT * FROM GiaoVien WHERE MaGiaoVien = '" + maGiaoVien + "'");
            args.IsValid = dt.Rows.Count == 0; // Trả về true nếu Mã giáo viên không tồn tại trong cơ sở dữ liệu
        }



        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetTeacher();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string maGiaoVien = (row.FindControl("txtMaGiaoVien") as TextBox).Text;
                string name = (row.FindControl("txtName") as TextBox).Text;
                string soDienThoai = (row.FindControl("txtMobile") as TextBox).Text;
   
                string diaChi = (row.FindControl("txtDiaChi") as TextBox).Text;
                string password = (row.FindControl("txtPassword") as TextBox).Text;

                fn.Query("UPDATE GiaoVien SET MaGiaoVien = N'" + maGiaoVien + "', Ten = N'" + name.Trim() + "' ," +
                   " SoDienThoai = '" + soDienThoai.Trim() + "', DiaChi = N'" + diaChi.Trim() + "', Password = '" + password.Trim() + "' WHERE Id = '" + id + "'");
                    lblMsg.Text = "Giáo viên đã được cập nhật thành công!!!";
                    lblMsg.CssClass = "alert alert-success";
                    GridView1.EditIndex = -1;
                    GetTeacher();
               
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