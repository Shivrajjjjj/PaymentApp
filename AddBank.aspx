<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBank.aspx.cs" Inherits="PaymentApp.AddBank" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Bank Account</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .bank-container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="bank-container">
            <h2 class="text-center text-primary">Add Bank Account</h2>
            <hr>

            <form id="form1" runat="server">
                <div class="form-group">
                    <label>Select Bank</label>
                    <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control">
                        <asp:ListItem Text="-- Select Bank --" Value="" />
                        <asp:ListItem Text="State Bank of India (SBI)" Value="SBI" />
                        <asp:ListItem Text="HDFC Bank" Value="HDFC" />
                        <asp:ListItem Text="ICICI Bank" Value="ICICI" />
                        <asp:ListItem Text="Axis Bank" Value="AXIS" />
                        <asp:ListItem Text="Punjab National Bank (PNB)" Value="PNB" />
                        <asp:ListItem Text="Bank of Baroda" Value="BOB" />
                        <asp:ListItem Text="Union Bank of India" Value="UNION" />
                        <asp:ListItem Text="Kotak Mahindra Bank" Value="KOTAK" />
                        <asp:ListItem Text="Yes Bank" Value="YES" />
                        <asp:ListItem Text="Canara Bank" Value="CANARA" />
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Account Holder Name</label>
                    <asp:TextBox ID="txtAccountHolder" runat="server" CssClass="form-control" placeholder="Enter Account Holder Name"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Account Number</label>
                    <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" placeholder="Enter Account Number"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Confirm Account Number</label>
                    <asp:TextBox ID="txtConfirmAccountNumber" runat="server" CssClass="form-control" placeholder="Re-enter Account Number"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>IFSC Code</label>
                    <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control" placeholder="Enter IFSC Code"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>UPI ID (Optional)</label>
                    <asp:TextBox ID="txtUPIID" runat="server" CssClass="form-control" placeholder="Enter UPI ID (e.g. user@upi)"></asp:TextBox>
                </div>

                <asp:Button ID="btnAddBank" runat="server" CssClass="btn btn-success btn-custom" Text="Add Bank Account"  />
            </form>
        </div>
    </div>
</body>
</html>
