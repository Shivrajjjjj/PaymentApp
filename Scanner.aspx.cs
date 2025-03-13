using System;
using System.Drawing;
using System.IO;
using System.Web.UI;
using QRCoder;

namespace PaymentApp
{
    public partial class Scanner : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Disable the Proceed to Payment button by default
            btnProceedToPayment.Enabled = false;
        }

        // ✅ Handles QR Code Generation for UPI Payments
        protected void btnGenerateUPIQR_Click(object sender, EventArgs e)
        {
            string upiID = txtUPIID.Text.Trim();
            string amount = txtAmount.Text.Trim();

            if (!string.IsNullOrEmpty(upiID))
            {
                string upiUri = $"upi://pay?pa={upiID}&pn=User&mc=&tid=&tr=&tn=Payment&am={amount}&cu=INR&url=";

                using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
                {
                    QRCodeData qrCodeData = qrGenerator.CreateQrCode(upiUri, QRCodeGenerator.ECCLevel.Q);
                    using (QRCode qrCode = new QRCode(qrCodeData))
                    {
                        using (Bitmap qrBitmap = qrCode.GetGraphic(10))
                        {
                            using (MemoryStream ms = new MemoryStream())
                            {
                                qrBitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                                byte[] byteImage = ms.ToArray();
                                imgUPIQRCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                            }
                        }
                    }
                }
                lblMessage.Text = "QR Code generated successfully!";
                lblMessage.CssClass = "text-success font-weight-bold";
            }
            else
            {
                lblMessage.Text = "Please enter a valid UPI ID.";
                lblMessage.CssClass = "text-danger font-weight-bold";
            }
        }

        // ✅ Handles Payment Process After Scanning QR Code
        protected void btnProceedToPayment_Click(object sender, EventArgs e)
        {
            string scannedData = Request.Form["hiddenScannedValue"];

            if (!string.IsNullOrEmpty(scannedData))
            {
                lblMessage.Text = "Redirecting to Payment...";
                lblMessage.CssClass = "text-success font-weight-bold";
                Response.Redirect($"Payment.aspx?data={scannedData}");
            }
            else
            {
                lblMessage.Text = "No valid QR code scanned.";
                lblMessage.CssClass = "text-danger font-weight-bold";
            }
        }
    }
}
