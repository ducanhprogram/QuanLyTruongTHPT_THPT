using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc.Admin
{
    public partial class DiemThi : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["admin"] == null)
                {
                    Response.Redirect("../Login.aspx");
                }

                LoadDropDownLists();
                GetDiemThi();
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
        }

        private void GetDiemThi()
        {
            DataTable dt = fn.Fetch(@"SELECT Id, MaHocSinh, MaMonHoc, Diem_Mon, DiemTb, HocKy, NamHoc FROM DiemThi");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maHocSinh = ddlMaHocSinh.SelectedValue;
                string maMonHoc = ddlMaMonHoc.SelectedValue;
                string diemMon = txtDiemMon.Text;
                string diemTb =txtDiemTb.Text;
                string hocKy = ddlHocKy.SelectedValue;
                string namHoc = txtNamHoc.Text;

                string query = @"INSERT INTO DiemThi (MaHocSinh, MaMonHoc, Diem_Mon, DiemTb, HocKy, NamHoc) 
                                 VALUES ('" + maHocSinh + "','" + maMonHoc + "'," + diemMon + "," + diemTb + ",'" + hocKy + "','" + namHoc + "')";
                fn.Query(query);
                lblMsg.Text = "Thêm thành công!";
                lblMsg.CssClass = "alert alert-success";
                GetDiemThi();
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
            GetDiemThi();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string query = @"DELETE FROM DiemThi WHERE Id = '" + id + "'";
            fn.Query(query);
            lblMsg.Text = "Xóa thành công!";
            lblMsg.CssClass = "alert alert-success";
            GetDiemThi();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetDiemThi();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            TextBox txtDiemMonEdit = GridView1.Rows[e.RowIndex].FindControl("txtDiemMonEdit") as TextBox;
            TextBox txtDiemTbEdit = GridView1.Rows[e.RowIndex].FindControl("txtDiemTbEdit") as TextBox;
            DropDownList ddlHocKyEdit = GridView1.Rows[e.RowIndex].FindControl("ddlHocKyEdit") as DropDownList;
            TextBox txtNamHocEdit = GridView1.Rows[e.RowIndex].FindControl("txtNamHocEdit") as TextBox;

            float diemMon = float.Parse(txtDiemMonEdit.Text);
            float diemTb = float.Parse(txtDiemTbEdit.Text);
            string hocKy = ddlHocKyEdit.SelectedValue;
            string namHoc = txtNamHocEdit.Text;

            string query = @"UPDATE DiemThi SET Diem_Mon = " + diemMon + ", DiemTb = " + diemTb + ", HocKy = '" + hocKy + "', NamHoc = '" + namHoc + "' WHERE Id = '" + id + "'";
            fn.Query(query);
            lblMsg.Text = "Cập nhật thành công!";
            lblMsg.CssClass = "alert alert-success";
            GridView1.EditIndex = -1;
            GetDiemThi();
        }

        private void ResetFields()
        {
            ddlMaHocSinh.SelectedIndex = 0;
            ddlMaMonHoc.SelectedIndex = 0;
            txtDiemMon.Text = "";
            txtDiemTb.Text = "";
            ddlHocKy.SelectedIndex = 0; 
            txtNamHoc.Text = "";
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetDiemThi();
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }
}
