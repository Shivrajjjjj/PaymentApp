using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.UI;

namespace PaymentApp
{
    public partial class Chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChatMessages();
            }
        }

        private void LoadChatMessages()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string userID = Session["UserID"].ToString();
            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT SenderID, MessageText FROM ChatMessages ORDER BY SentAt ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string senderID = reader["SenderID"].ToString();
                        string messageText = reader["MessageText"].ToString();
                        string messageClass = senderID == userID ? "sent" : "received";

                        //chatBox.InnerHtml += $"<div class='message {messageClass}'>{messageText}</div>";
                    }
                }
            }
        }
    }
}
