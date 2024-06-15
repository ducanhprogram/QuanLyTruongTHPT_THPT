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
    public partial class AdminHome : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                StudentCount();
                TeacherCount();
                ClassCount();
                SubjectCount();
            }
            if (!IsPostBack)
            {
                Timer1_Tick(null, null); // Cập nhật thời gian khi trang tải lần đầu
            }
        }


        void StudentCount()
        {
            DataTable dt = fn.Fetch("Select Count(*) from HocSinh");
            Session["HocSinh"] = dt.Rows[0][0];
        }

        void TeacherCount()
        {
            DataTable dt = fn.Fetch("Select Count(*) from GiaoVien");
            Session["GiaoVien"] = dt.Rows[0][0];
        }

        void ClassCount()
        {
            DataTable dt = fn.Fetch("Select Count(*) from LopHoc");
            Session["LopHoc"] = dt.Rows[0][0];
        }

        void SubjectCount()
        {
            DataTable dt = fn.Fetch("Select Count(*) from MonHoc");
            Session["MonHoc"] = dt.Rows[0][0];
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }
}