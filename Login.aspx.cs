using System;
using System.Data.SqlClient;
using System.Configuration;

namespace PaymentApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.Cookies["UserEmail"] != null)
            {
                txtEmail.Text = Request.Cookies["UserEmail"].Value;
                chkRememberMe.Checked = true;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT UserID FROM Users WHERE Email=@Email AND PasswordHash=@Password", con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    Session["UserID"] = result.ToString();

                    if (chkRememberMe.Checked)
                    {
                        Response.Cookies["UserEmail"].Value = email;
                        Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(7);
                    }
                    else
                    {
                        Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(-1);
                    }

                    // 🔹 Debugging Before Redirect
                    Response.Write("<script>alert('Login Successful! UserID: " + result + "');</script>");
                    Response.Write("Session UserID: " + Session["UserID"]);
                    Response.End();  // Stops execution before redirect

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid email or password!";
                }
            }
        }
    }
}
