using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc.Admin
{
    public partial class GiaoVienBoMon : System.Web.UI.Page
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
                LoadDropDownLists();
                GetGiaoVienBoMon();
            }
        }

        private void LoadDropDownLists()
        {
            // Load MaLop
            DataTable dtLop = fn.Fetch("SELECT MaLop FROM LopHoc");
            ddlMaLop.DataSource = dtLop;
            ddlMaLop.DataTextField = "MaLop";
            ddlMaLop.DataValueField = "MaLop";
            ddlMaLop.DataBind();
            ddlMaLop.Items.Insert(0, new ListItem("Chọn mã lớp", "0"));

            // Load MaMonHoc
            DataTable dtMonHoc = fn.Fetch("SELECT MaMonHoc FROM MonHoc");
            ddlMaMonHoc.DataSource = dtMonHoc;
            ddlMaMonHoc.DataTextField = "MaMonHoc";
            ddlMaMonHoc.DataValueField = "MaMonHoc";
            ddlMaMonHoc.DataBind();
            ddlMaMonHoc.Items.Insert(0, new ListItem("Chọn mã môn học", "0"));

            // Load MaGiaoVien
            DataTable dtGiaoVien = fn.Fetch("SELECT MaGiaoVien FROM GiaoVien");
            ddlMaGiaoVien.DataSource = dtGiaoVien;
            ddlMaGiaoVien.DataTextField = "MaGiaoVien";
            ddlMaGiaoVien.DataValueField = "MaGiaoVien";
            ddlMaGiaoVien.DataBind();
            ddlMaGiaoVien.Items.Insert(0, new ListItem("Chọn mã giáo viên", "0"));
        }

        private void GetGiaoVienBoMon()
        {
            DataTable dt = fn.Fetch(@"SELECT Row_NUMBER() OVER (ORDER BY (SELECT 1)) AS [SrNo], Id, MaLop, MaMonHoc, MaGiaoVien FROM GiaoVien_BoMon");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string maLop = ddlMaLop.SelectedValue;
                string maMonHoc = ddlMaMonHoc.SelectedValue;
                string maGiaoVien = ddlMaGiaoVien.SelectedValue;

                string query = @"INSERT INTO GiaoVien_BoMon (MaLop, MaMonHoc, MaGiaoVien) VALUES ('" + maLop + "','" + maMonHoc + "','" + maGiaoVien + "')";
                fn.Query(query);
                lblMsg.Text = "Thêm thành công!";
                lblMsg.CssClass = "alert alert-success";
                GetGiaoVienBoMon();
                ResetFields();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Có lỗi xảy ra: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        private void ResetFields()
        {
            ddlMaLop.SelectedIndex = 0;
            ddlMaMonHoc.SelectedIndex = 0;
            ddlMaGiaoVien.SelectedIndex = 0;
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetGiaoVienBoMon();
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlMaLopEdit = (DropDownList)e.Row.FindControl("ddlMaLopEdit");
                    DropDownList ddlMaMonHocEdit = (DropDownList)e.Row.FindControl("ddlMaMonHocEdit");
                    DropDownList lblMaGiaoVien = (DropDownList)e.Row.FindControl("ddlMaGiaoVienEdit");

                    // Load MaHocSinh
                    DataTable dtMaLop = fn.Fetch("SELECT MaLop FROM LopHoc");
                    ddlMaLopEdit.DataSource = dtMaLop;
                    ddlMaLopEdit.DataTextField = "MaLop";
                    ddlMaLopEdit.DataValueField = "MaLop";
                    ddlMaLopEdit.DataBind();

                    // Load MaMonHoc
                    DataTable dtMonHoc = fn.Fetch("SELECT MaMonHoc FROM MonHoc");
                    ddlMaMonHocEdit.DataSource = dtMonHoc;
                    ddlMaMonHocEdit.DataTextField = "MaMonHoc";
                    ddlMaMonHocEdit.DataValueField = "MaMonHoc";
                    ddlMaMonHocEdit.DataBind();

                    // Load MaLop
                    DataTable dtGiaoVien = fn.Fetch("SELECT MaGiaoVien FROM GiaoVien");
                    ddlMaLopEdit.DataSource = dtGiaoVien;
                    ddlMaLopEdit.DataTextField = "MaGiaoVien";
                    ddlMaLopEdit.DataValueField = "MaGiaoVien";
                    ddlMaLopEdit.DataBind();
                }
            }
        }


        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string query = @"DELETE FROM GiaoVien_BoMon WHERE Id = '" + id + "'";
            fn.Query(query);
            lblMsg.Text = "Xóa thành công!";
            lblMsg.CssClass = "alert alert-success";
            GetGiaoVienBoMon();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetGiaoVienBoMon();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            DropDownList ddlMaLopEdit = GridView1.Rows[e.RowIndex].FindControl("ddlMaLopEdit") as DropDownList;
            DropDownList ddlMaMonHocEdit = GridView1.Rows[e.RowIndex].FindControl("ddlMaMonHocEdit") as DropDownList;
            DropDownList ddlMaGiaoVienEdit = GridView1.Rows[e.RowIndex].FindControl("ddlMaGiaoVienEdit") as DropDownList;

            string maLop = ddlMaLopEdit.SelectedValue;
            string maMonHoc = ddlMaMonHocEdit.SelectedValue;
            string maGiaoVien = ddlMaGiaoVienEdit.SelectedValue;

            string query = @"UPDATE GiaoVien_BoMon SET MaLop = '" + maLop + "', MaMonHoc = '" + maMonHoc + "', MaGiaoVien = '" + maGiaoVien + "' WHERE Id = '" + id + "'";
            fn.Query(query);
            lblMsg.Text = "Cập nhật thành công!";
            lblMsg.CssClass = "alert alert-success";
            GridView1.EditIndex = -1;
            GetGiaoVienBoMon();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetGiaoVienBoMon();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }
}


