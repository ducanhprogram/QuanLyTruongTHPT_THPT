﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static QuanLyTruongHoc.Models.CommonFn;

namespace QuanLyTruongHoc
{
    public partial class Login : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = inputEmail.Value.Trim();
            string password = inputPassword.Value.Trim();
            DataTable dt = fn.Fetch("Select * from GiaoVien where Email = '" + email + "' and Password = '" + password + "' ");
            if (email == "Admin" && password == "12345")
            {
                Session["admin"] = email;
                Response.Redirect("Admin/AdminHome.aspx");
            }
            else if (dt.Rows.Count > 0)
            {
                Session["staff"] = email;
                Response.Redirect("Teacher/TeacherHome.aspx");
            }
            else
            {
                lblMsg.Text = "Đăng nhập không thành công!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }

        }
    }
}