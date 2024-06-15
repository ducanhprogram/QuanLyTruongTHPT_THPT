using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc
{
    public partial class ChiTietDiemThiUserControl : System.Web.UI.UserControl
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetSubjects();
                GetStudents();
            }
        }

        private void GetSubjects()
        {
            DataTable dt = fn.Fetch("SELECT MaMonHoc FROM MonHoc");
            ddlSubject.DataSource = dt;

            ddlSubject.DataValueField = "MaMonHoc";
            ddlSubject.DataBind();
            ddlSubject.Items.Insert(0, new ListItem("Chọn môn học", "0"));
        }

        private void GetStudents()
        {
            DataTable dt = fn.Fetch("SELECT MaHocSinh FROM HocSinh");
            ddlStudent.DataSource = dt;

            ddlStudent.DataValueField = "MaHocSinh";
            ddlStudent.DataBind();
            ddlStudent.Items.Insert(0, new ListItem("Chọn học sinh", "0"));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string subjectId = ddlSubject.SelectedValue;
                string studentId = ddlStudent.SelectedValue;
                DataTable dt = fn.Fetch($@"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No], 
                                           dt.Id, dt.MaHocSinh, hs.Ten AS HocSinhName, 
                                           dt.MaMonHoc, mh.TenMonHoc, 
                                           dt.Diem_Mon, dt.DiemTb, dt.HocKy, dt.NamHoc
                                           FROM DiemThi dt
                                           INNER JOIN HocSinh hs ON hs.MaHocSinh = dt.MaHocSinh
                                           INNER JOIN MonHoc mh ON mh.MaMonHoc = dt.MaMonHoc
                                           WHERE dt.MaMonHoc = '{subjectId}' AND dt.MaHocSinh = '{studentId}'");
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Đã có lỗi xảy ra: " + ex.Message;
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e); // Reload the data on page index change
        }
    }
}
