<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Scanner.aspx.cs" Inherits="PaymentApp.Scanner" %>

<!DOCTYPE html>
<html>
<head>
    <title>QR Scanner & Generator</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/8.0.1/adapter.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jsqr"></script>
    <script src="scanner.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5 text-center">
        <h2 class="text-success">UPI QR Scanner & Generator</h2>

        <form id="form1" runat="server">
            <div class="row justify-content-center">
                <!-- ✅ QR Scanner Section -->
                <div class="col-md-6">
                    <h4>Scan QR Code</h4>
                    <video id="scanner" width="300" height="300" class="border"></video>
                    <input type="hidden" id="hiddenScannedValue" runat="server" />
                    <p id="result" class="text-danger font-weight-bold mt-3"></p>
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>
                    <br />
                    <asp:Button ID="btnProceedToPayment" runat="server" CssClass="btn btn-success mt-3" 
                        Text="Proceed to Payment" Enabled="false" OnClick="btnProceedToPayment_Click" />
                </div>

                <!-- ✅ QR Code Generator Section -->
                <div class="col-md-6">
                    <h4>Generate UPI QR Code</h4>
                    <asp:TextBox ID="txtUPIID" runat="server" CssClass="form-control mb-2" placeholder="Enter UPI ID (e.g. user@upi)"></asp:TextBox>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control mb-2" placeholder="Enter Amount (Optional)"></asp:TextBox>
                    <asp:Button ID="btnGenerateUPIQR" runat="server" CssClass="btn btn-primary" Text="Generate UPI QR" OnClick="btnGenerateUPIQR_Click" />
                    <br />
                    <asp:Image ID="imgUPIQRCode" runat="server" CssClass="mt-3" />
                </div>
            </div>
        </form>
    </div>

    <!-- ✅ JavaScript for QR Scanner -->
    <script>
        const video = document.getElementById("scanner");
        const result = document.getElementById("result");
        const btnProceed = document.getElementById('<%= btnProceedToPayment.ClientID %>');
        const hiddenInput = document.getElementById('<%= hiddenScannedValue.ClientID %>');

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
                    hiddenInput.value = code.data;
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
