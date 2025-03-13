<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PaymentApp.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Login - Payment App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow p-4" style="width: 350px;">
            <h3 class="text-center">Login</h3>

            <!-- ✅ Add this Form Tag -->
            <form id="form1" runat="server">
                <asp:Label ID="lblMessage" ForeColor="Red" runat="server" />
                <div class="mb-3">
                    <label>Email:</label>
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
                </div>
                <div class="mb-3">
                    <label>Password:</label>
                    <asp:TextBox ID="txtPassword" CssClass="form-control" TextMode="Password" runat="server" />
                </div>
                <div class="mb-3 form-check">
                    <asp:CheckBox ID="chkRememberMe" CssClass="form-check-input" runat="server" />
                    <label class="form-check-label">Remember Me</label>
                </div>
                <asp:Button ID="btnLogin" CssClass="btn btn-primary w-100" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </form>
            <!-- ✅ Form Ends Here -->

        </div>
    </div>
</body>
</html>
