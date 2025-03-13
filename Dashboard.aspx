<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PaymentApp.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Dashboard - Payment App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Welcome, <asp:Label ID="lblUserName" runat="server" /></h2>
        <h4>Wallet Balance: <asp:Label ID="lblWalletBalance" runat="server" CssClass="text-success fw-bold" /></h4>
        <a href="Logout.aspx" class="btn btn-danger mt-3">Logout</a>
    </div>
</body>
</html>
