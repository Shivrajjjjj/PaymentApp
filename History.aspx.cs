using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace PaymentApp
{
    public partial class History : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTransactionHistory();
            }
        }

        private void LoadTransactionHistory()
        {
            // Ensure UserID exists in Session
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx"); // Redirect to login if not authenticated
                return;
            }

            string userID = Session["UserID"].ToString(); // Get UserID from session
            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT TransactionID, [CreatedAt] AS Date, Amount, TransactionType AS Type, Status FROM Transactions WHERE SenderID = @UserID OR ReceiverID = @UserID ORDER BY [CreatedAt] DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID); // Now userID is properly set
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvTransactionHistory.DataSource = dt;
                        gvTransactionHistory.DataBind();
                    }
                }
            }
        }
    }
}
