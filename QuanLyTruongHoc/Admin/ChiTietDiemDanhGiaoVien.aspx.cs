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
    public partial class ChiTietDiemDanhGiaoVien : System.Web.UI.Page
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
            DataTable dt = fn.Fetch("Select * from GiaoVien");
            ddlTeacher.DataSource = dt;
            ddlTeacher.DataTextField = "Ten";
            ddlTeacher.DataValueField = "MaGiaoVien";
            ddlTeacher.DataBind();
            ddlTeacher.Items.Insert(0, "Chọn giáo viên");
        }

        protected void btnCheckAttendance_Click(object sender, EventArgs e)
        {
            DateTime date = Convert.ToDateTime(txtMonth.Text);
            DataTable dt = fn.Fetch($@"
                SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No], 
                       t.Ten, 
                       ta.TrangThai, 
                       ta.Ngay 
                FROM DiemDanh_GiaoVien ta
                INNER JOIN GiaoVien t ON t.MaGiaoVien = ta.MaGiaoVien 
                WHERE DATEPART(yy, Ngay) = {date.Year} 
                  AND DATEPART(M, Ngay) = {date.Month}  
                  AND ta.MaGiaoVien = '{ddlTeacher.SelectedValue}'
            ");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }

    }
}