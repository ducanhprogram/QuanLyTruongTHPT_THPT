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
    public partial class ChiTietChiPhi : System.Web.UI.Page
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
                GetChiPhi();
            }
        }

        private void GetChiPhi()
        {
            DataTable dt = fn.Fetch(@"SELECT MaHocPhi, MaHocSinh, MaMonHoc, MaLop, NgayThanhToan, NamHoc, TongTien FROM HocPhi");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }
}
