<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankTransfer.aspx.cs" Inherits="PaymentApp.BankTransfer" %>

<!DOCTYPE html>
<html>
<head>
    <title>Bank Transfer</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="text-center text-primary">Bank Transfer</h2>
        <form id="form1" runat="server" class="card p-4 shadow-lg">
            <div class="form-group">
                <label>Select Linked Bank:</label>
                <asp:DropDownList ID="ddlBanks" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Bank" Value=""></asp:ListItem>
                    <asp:ListItem Text="State Bank of India" Value="SBI"></asp:ListItem>
                    <asp:ListItem Text="HDFC Bank" Value="HDFC"></asp:ListItem>
                    <asp:ListItem Text="ICICI Bank" Value="ICICI"></asp:ListItem>
                    <asp:ListItem Text="Axis Bank" Value="Axis"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Recipient Account Number:</label>
                <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" placeholder="Enter Account Number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>IFSC Code:</label>
                <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control" placeholder="Enter IFSC Code"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Transfer Amount (₹):</label>
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter Amount"></asp:TextBox>
            </div>

            <asp:Button ID="btnTransfer" runat="server" CssClass="btn btn-success btn-block" Text="Transfer Now"  />
            
            <asp:Label ID="lblMessage" runat="server" CssClass="text-center text-danger mt-3"></asp:Label>
        </form>
    </div>
</body>
</html>
