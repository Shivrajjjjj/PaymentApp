using System;
using System.Web.UI;

namespace PaymentApp
{
    public partial class Payment : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["data"] != null)
                {
                    txtQRCodeData.Text = Request.QueryString["data"];
                }
            }
        }

        protected void btnPayNow_Click(object sender, EventArgs e)
        {
            string qrData = txtQRCodeData.Text;
            string amount = txtAmount.Text;

            if (!string.IsNullOrEmpty(qrData) && decimal.TryParse(amount, out decimal paymentAmount) && paymentAmount > 0)
            {
                // Simulate transaction processing (In real scenario, integrate with a payment gateway)
                lblMessage.Text = "✅ Payment Successful!";
                lblMessage.CssClass = "text-success";

                // Redirect to transaction history or success page
                Response.Redirect("History.aspx");
            }
            else
            {
                lblMessage.Text = "❌ Payment failed. Invalid data!";
                lblMessage.CssClass = "text-danger";
            }
        }
    }
}
