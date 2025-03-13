using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace PaymentApp
{
    public partial class BankTransfer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserBanks();
            }
        }

        private void LoadUserBanks()
        {
            string userID = Session["UserID"]?.ToString(); // Ensure user is logged in
            if (string.IsNullOrEmpty(userID))
            {
                lblMessage.Text = "Please log in to continue.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT BankID, BankName + ' - ' + AccountNumber AS BankDetails FROM UserBanks WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlUserBanks.DataSource = reader;
                    ddlUserBanks.DataTextField = "BankDetails";
                    ddlUserBanks.DataValueField = "BankID";
                    ddlUserBanks.DataBind();
                    con.Close();
                }
            }
        }

        protected void btnTransfer_Click(object sender, EventArgs e)
        {
            string senderBankID = ddlUserBanks.SelectedValue;
            string receiverBank = txtReceiverBank.Text.Trim();
            string receiverAccNo = txtReceiverAccount.Text.Trim();
            string ifscCode = txtIFSC.Text.Trim();
            decimal amount;

            if (string.IsNullOrEmpty(receiverBank) || string.IsNullOrEmpty(receiverAccNo) || string.IsNullOrEmpty(ifscCode))
            {
                lblMessage.Text = "Please enter all bank details.";
                return;
            }

            if (!decimal.TryParse(txtAmount.Text, out amount) || amount <= 0)
            {
                lblMessage.Text = "Invalid amount!";
                return;
            }

            string userID = Session["UserID"]?.ToString();
            if (string.IsNullOrEmpty(userID))
            {
                lblMessage.Text = "Session expired. Please log in again.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Transactions (SenderID, SenderBankID, ReceiverBank, ReceiverAccount, IFSCCode, Amount, TransactionType, Status, CreatedAt) " +
                               "VALUES (@SenderID, @SenderBankID, @ReceiverBank, @ReceiverAccount, @IFSCCode, @Amount, 'Bank Transfer', 'Pending', GETDATE())";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@SenderID", userID);
                    cmd.Parameters.AddWithValue("@SenderBankID", senderBankID);
                    cmd.Parameters.AddWithValue("@ReceiverBank", receiverBank);
                    cmd.Parameters.AddWithValue("@ReceiverAccount", receiverAccNo);
                    cmd.Parameters.AddWithValue("@IFSCCode", ifscCode);
                    cmd.Parameters.AddWithValue("@Amount", amount);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    con.Close();

                    lblMessage.Text = rows > 0 ? "Transfer initiated successfully!" : "Transfer failed. Try again.";
                }
            }
        }
    }
}
