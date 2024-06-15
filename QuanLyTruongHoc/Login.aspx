<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuanLyTruongHoc.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Trường THPT Chu Văn An</title>
    <link rel="stylesheet" href="./login_css/assets/font/fontawesome/fontawesome-free-6.4.0-web/css/all.min.css">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="login_css/login.css" rel="stylesheet" />

    <style>
        .body {
            background: linear-gradient(to right, #48b48b, #459dc9);
        }
        .bg {
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 50px rgba(0, 0, 0, 0.1);
        }
        h3 {
            font-size: 30px;
            color: #fff;
            text-align: center;
        }
        .form-group {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
             color: #fff;
        }
    </style>

    <script>
        function togglePassword() {
            var passwordField = document.getElementById("inputPassword");
            var passwordFieldType = passwordField.type === "password" ? "text" : "password";
            passwordField.type = passwordFieldType;

            var toggleIcon = document.getElementById("togglePasswordIcon");
            toggleIcon.classList.toggle("fa-eye");
            toggleIcon.classList.toggle("fa-eye-slash");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="bg-image d-none d-md-flex"></div>
            <div class="bg">
                <div class="login">
                    <h3 class="display-4 pb-3" style="font-size: 30px; font-weight: 500;">Đăng nhập</h3>
                    <p class="text-muted mb-4">Đăng nhập cho Admin và giáo viên.</p>
                    <div class="form-group md-3">
                        <input id="inputEmail" type="text" required="" runat="server" autofocus="" />
                        <label>Email</label>
                    </div>
                    <div class="form-group mb-3 mb-2">
                        <input id="inputPassword" type="password" required="" runat="server" />
                        <label>Mật khẩu</label>
                        <i id="togglePasswordIcon" class="fa fa-eye toggle-password" onclick="togglePassword()"></i>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn btn-primary btn-block text-uppercase" OnClick="btnLogin_Click" />
                    <div class="text-center d-flex justify-content-between mt-4">
                        <asp:Label ID="lblMsg" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div class="social-icons">
            <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
            <a href="#"><i class="fa-brands fa-google"></i></a>
            <a href="#"><i class="fa-brands fa-twitter"></i></a>
        </div>
    </form>
</body>
</html>
