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
    public partial class DiemDanhChiTietSinhVienUC : System.Web.UI.UserControl
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropDownLists();
            }
        }

        private void LoadDropDownLists()
        {
            DataTable dtHocSinh = fn.Fetch("SELECT * FROM HocSinh");
            ddlMaHocSinh.DataSource = dtHocSinh;
            ddlMaHocSinh.DataTextField = "MaHocSinh";
            ddlMaHocSinh.DataValueField = "MaHocSinh";
            ddlMaHocSinh.DataBind();

            ddlNam.Items.Clear();
            for (int year = DateTime.Now.Year; year >= 2000; year--)
            {
                ddlNam.Items.Add(new ListItem(year.ToString(), year.ToString()));
            }
        }

        protected void btnXemChiTiet_Click(object sender, EventArgs e)
        {
            string maHocSinh = ddlMaHocSinh.SelectedValue;
            string thang = ddlThang.SelectedValue;
            string nam = ddlNam.SelectedValue;

            string query = $@"
                SELECT 
                    h.MaHocSinh AS [MaHocSinh],
                    l.TenLop AS [TenLop],
                    m.TenMonHoc AS [TenMonHoc],
                    MONTH(d.Ngay) AS [Thang],
                    YEAR(d.Ngay) AS [Nam],
                    SUM(CASE WHEN d.TrangThai = 1 THEN 1 ELSE 0 END) AS [SoBuoiCoMat],
                    SUM(CASE WHEN d.TrangThai = 0 THEN 1 ELSE 0 END) AS [SoBuoiVangMat]
                FROM 
                    DiemDanh_SinhVien d
                    INNER JOIN HocSinh h ON d.MaHocSinh = h.MaHocSinh
                    INNER JOIN LopHoc l ON d.MaLop = l.MaLop
                    INNER JOIN MonHoc m ON d.MaMonHoc = m.MaMonHoc
                WHERE 
                    d.MaHocSinh = '{maHocSinh}' AND MONTH(d.Ngay) = {thang} AND YEAR(d.Ngay) = {nam}
                GROUP BY 
                    h.MaHocSinh, l.TenLop, m.TenMonHoc, MONTH(d.Ngay), YEAR(d.Ngay)
                ORDER BY 
                    h.MaHocSinh, l.TenLop, m.TenMonHoc";

            DataTable dt = fn.Fetch(query);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}