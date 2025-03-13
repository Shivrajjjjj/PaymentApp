<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="PaymentApp.Profile" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/8.0.1/adapter.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jsqr"></script>
    <script src="scanner.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .profile-container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #007bff;
            object-fit: cover;
        }
        .btn-custom {
            width: 100%;
        }
        .scanner-box {
            border: 2px dashed #007bff;
            border-radius: 10px;
            padding: 15px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="profile-container">
            <h2 class="text-center text-primary">User Profile</h2>
            <hr>

            <form id="form1" runat="server">
                <div class="row">
                    <!-- ✅ Profile Section -->
                    <div class="col-md-4 text-center">
                        <h4>Profile Picture</h4>
                        <asp:Image ID="imgProfile" runat="server" CssClass="profile-pic mb-2" />
                        <br />
                        <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="form-control mb-2" />
                        <asp:Button ID="btnUpload" runat="server" CssClass="btn btn-primary btn-sm btn-custom" Text="Upload Photo" />
                    </div>

                    <!-- ✅ Bank Details Section -->
                    <div class="col-md-4">
                        <h4>Bank Details</h4>
                        <asp:GridView ID="gvBankDetails" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="BankName" HeaderText="Bank Name" />
                                <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" />
                                <asp:BoundField DataField="IFSC" HeaderText="IFSC Code" />
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="btnAddBank" runat="server" CssClass="btn btn-success btn-sm btn-custom" Text="Add Bank Account" />
                    </div>

                    <!-- ✅ QR Scanner Section -->
                    <div class="col-md-4 text-center">
                        <h4>QR Scanner</h4>
                        <div class="scanner-box">
                            <video id="scanner" width="150" height="150"></video>
                        </div>
                        <p id="result" class="text-danger font-weight-bold mt-2"></p>
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>
                        <br />
                        <asp:Button ID="btnProceedToPayment" runat="server" CssClass="btn btn-info btn-sm btn-custom mt-2" 
                            Text="Proceed to Payment" Enabled="false" />
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- ✅ JavaScript for QR Scanner -->
    <script>
        const video = document.getElementById("scanner");
        const result = document.getElementById("result");
        const btnProceed = document.getElementById('<%= btnProceedToPayment.ClientID %>');

        async function startScanner() {
            const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } });
            video.srcObject = stream;
            video.play();

            const canvas = document.createElement("canvas");
            const ctx = canvas.getContext("2d");
            const interval = setInterval(async () => {
                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
                ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
                const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
                const code = jsQR(imageData.data, canvas.width, canvas.height);

                if (code) {
                    result.textContent = "QR Code Detected: " + code.data;
                    btnProceed.disabled = false;
                    clearInterval(interval);
                    stream.getTracks().forEach(track => track.stop()); // ✅ Stop Camera After Scanning
                }
            }, 500);
        }

        startScanner();
    </script>
</body>
</html>
