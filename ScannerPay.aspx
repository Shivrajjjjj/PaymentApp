<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScannerPay.aspx.cs" Inherits="PaymentApp.ScannerPay" %>

<!DOCTYPE html>
<html>
<head>
    <title>QR Payment Scanner</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/8.0.1/adapter.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jsqr"></script>
    <script src="scanner.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .scanner-container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        #scanner {
            width: 100%;
            height: auto;
            border: 2px solid #007bff;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="scanner-container">
            <h3 class="text-primary">Scan UPI QR Code</h3>

           
            <form id="form1" runat="server">
                <video id="scanner" class="mt-3"></video>
                <p id="result" class="text-danger font-weight-bold mt-3"></p>

                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>
                <asp:HiddenField ID="hfScannedUPI" runat="server" />

                <div class="mt-3">
                    <asp:TextBox ID="txtUPI" runat="server" CssClass="form-control mb-2" placeholder="Scanned UPI ID" ReadOnly="true"></asp:TextBox>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control mb-2" placeholder="Enter Amount"></asp:TextBox>
                    <asp:Button ID="btnProceedToPayment" runat="server" CssClass="btn btn-success btn-block mt-2" 
                        Text="Proceed to Payment" OnClick="btnProceedToPayment_Click" Enabled="false" />
                </div>
            </form>
           
        </div>
    </div>

    <script>
        let video = document.getElementById('scanner');
        let resultField = document.getElementById('result');
        let txtUPI = document.getElementById('<%= txtUPI.ClientID %>');
        let btnProceed = document.getElementById('<%= btnProceedToPayment.ClientID %>');

        navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } })
            .then(stream => {
                video.srcObject = stream;
                video.setAttribute("playsinline", true);
                video.play();
                requestAnimationFrame(tick);
            });

        function tick() {
            let canvas = document.createElement('canvas');
            let context = canvas.getContext('2d');
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            let imageData = context.getImageData(0, 0, canvas.width, canvas.height);
            let code = jsQR(imageData.data, imageData.width, imageData.height);

            if (code) {
                resultField.innerText = "Scanned: " + code.data;
                txtUPI.value = code.data;
                btnProceed.disabled = false;
            }
            requestAnimationFrame(tick);
        }
    </script>
</body>
</html>
