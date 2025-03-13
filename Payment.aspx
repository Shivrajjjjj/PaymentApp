<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="PaymentApp.Payment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Make Payment</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: #f5f5f5;
        }
        .payment-container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .btn-success {
            background: #28a745;
            border: none;
            font-size: 18px;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            background: #218838;
        }
        .hidden {
            display: none;
        }
    </style>
    <script>
        function validatePayment() {
            var amount = document.getElementById("<%= txtAmount.ClientID %>").value;
            if (amount === "" || isNaN(amount) || parseFloat(amount) <= 0) {
                alert("❌ Please enter a valid amount.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="payment-container">
                <h2 class="text-success">💰 Make a Payment</h2>

                <label class="mt-3">QR Code Data:</label>
                <asp:TextBox ID="txtQRCodeData" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>

                <label class="mt-3">Enter Amount (₹):</label>
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" Placeholder="Enter amount" required></asp:TextBox>

                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-2"></asp:Label>

                <asp:Button ID="btnPayNow" runat="server" CssClass="btn btn-success mt-4" Text="Proceed to Pay" OnClick="btnPayNow_Click" OnClientClick="return validatePayment();" />
            </div>
        </div>
    </form>
</body>
</html>
