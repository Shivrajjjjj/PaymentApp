using System;
using System.Web.UI;

namespace PaymentApp
{
    public partial class ScannerPay : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnProceedToPayment.Enabled = false;
            }
        }

        protected void btnProceedToPayment_Click(object sender, EventArgs e)
        {
            string upiID = txtUPI.Text;
            string amount = txtAmount.Text;

            if (!string.IsNullOrEmpty(upiID))
            {
                string paymentURL = $"upi://pay?pa={upiID}&pn=UPI Payment&am={amount}&cu=INR";
                Response.Redirect(paymentURL);
            }
            else
            {
                lblMessage.Text = "Invalid UPI ID. Please scan again.";
            }
        }
    }
}
