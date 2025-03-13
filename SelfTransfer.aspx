<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelfTransfer.aspx.cs" Inherits="PaymentApp.SelfTransfer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Self Bank Transfer</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-lg p-4">
            <h2 class="text-center text-primary">Self Bank Transfer</h2>

            <form id="form1" runat="server">
                <div class="mb-3">
                    <label class="form-label fw-bold">From Bank</label>
                    <asp:DropDownList ID="ddlFromBank" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">To Bank</label>
                    <asp:DropDownList ID="ddlToBank" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Amount</label>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter amount"></asp:TextBox>
                </div>

                <div class="text-center">
                    <asp:Button ID="btnTransfer" runat="server" CssClass="btn btn-success btn-lg" Text="Transfer"  />
                </div>

                <div class="mt-3 text-center">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
