using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace PaymentApp
{
    public partial class SelfTransfer : System.Web.UI.Page
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
                    ddlFromBank.DataSource = reader;
                    ddlFromBank.DataTextField = "BankDetails";
                    ddlFromBank.DataValueField = "BankID";
                    ddlFromBank.DataBind();
                    reader.Close();

                    reader = cmd.ExecuteReader();
                    ddlToBank.DataSource = reader;
                    ddlToBank.DataTextField = "BankDetails";
                    ddlToBank.DataValueField = "BankID";
                    ddlToBank.DataBind();
                    con.Close();
                }
            }
        }

        protected void btnTransfer_Click(object sender, EventArgs e)
        {
            string fromBankID = ddlFromBank.SelectedValue;
            string toBankID = ddlToBank.SelectedValue;
            decimal amount;

            if (fromBankID == toBankID)
            {
                lblMessage.Text = "You cannot transfer to the same account!";
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
                string query = "INSERT INTO Transactions (SenderID, SenderBankID, ReceiverID, ReceiverBankID, Amount, TransactionType, Status, CreatedAt) " +
                               "VALUES (@SenderID, @FromBankID, @ReceiverID, @ToBankID, @Amount, 'Self Transfer', 'Completed', GETDATE())";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@SenderID", userID);
                    cmd.Parameters.AddWithValue("@FromBankID", fromBankID);
                    cmd.Parameters.AddWithValue("@ReceiverID", userID); // Self-transfer
                    cmd.Parameters.AddWithValue("@ToBankID", toBankID);
                    cmd.Parameters.AddWithValue("@Amount", amount);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    con.Close();

                    lblMessage.Text = rows > 0 ? "Self-transfer successful!" : "Transfer failed. Try again.";
                }
            }
        }
    }
}
