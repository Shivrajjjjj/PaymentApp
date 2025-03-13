using System;
using System.Data.SqlClient;
using System.Configuration;

namespace PaymentApp
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT FullName, WalletAmount FROM Users WHERE UserID=@UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblUserName.Text = reader["FullName"].ToString();
                    lblWalletBalance.Text = "₹" + Convert.ToDecimal(reader["WalletAmount"]).ToString("N2");
                }
                else
                {
                    lblUserName.Text = "User Not Found";
                    lblWalletBalance.Text = "₹0.00";
                }
            }
        }
    }
}
