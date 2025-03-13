using System;
using System.Data.SqlClient;
using System.Configuration;

namespace PaymentApp
{
    public partial class AddBank : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAddBank_Click(object sender, EventArgs e)
        {
            if (txtAccountNumber.Text != txtConfirmAccountNumber.Text)
            {
                Response.Write("<script>alert('Account Numbers do not match!');</script>");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO BankAccounts (UserID, BankName, AccountHolder, AccountNumber, IFSC, UPI_ID) VALUES (@UserID, @BankName, @AccountHolder, @AccountNumber, @IFSC, @UPIID)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]); // Assuming User is Logged In
                    cmd.Parameters.AddWithValue("@BankName", ddlBankName.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@AccountHolder", txtAccountHolder.Text);
                    cmd.Parameters.AddWithValue("@AccountNumber", txtAccountNumber.Text);
                    cmd.Parameters.AddWithValue("@IFSC", txtIFSC.Text);
                    cmd.Parameters.AddWithValue("@UPIID", txtUPIID.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Response.Write("<script>alert('Bank Account Added Successfully!');window.location='Profile.aspx';</script>");
                }
            }
        }
    }
}
