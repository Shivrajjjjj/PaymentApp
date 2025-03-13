using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace PaymentApp
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfilePicture();
                LoadBankDetails();
            }
        }

        private void LoadProfilePicture()
        {
            string imgPath = "~/Images/default-profile.png"; // Default image
            string userId = "123"; // Replace with actual user ID

            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT ProfilePic FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    con.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        imgPath = result.ToString();
                    }
                    imgProfile.ImageUrl = imgPath;
                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fuProfilePic.HasFile)
            {
                string folderPath = Server.MapPath("~/Images/");
                string filePath = "~/Images/" + Path.GetFileName(fuProfilePic.FileName);
                fuProfilePic.SaveAs(folderPath + Path.GetFileName(fuProfilePic.FileName));

                string userId = "123"; // Replace with actual user ID
                string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "UPDATE Users SET ProfilePic = @ProfilePic WHERE UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ProfilePic", filePath);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                imgProfile.ImageUrl = filePath;
            }
        }

        private void LoadBankDetails()
        {
            string userId = "123"; // Replace with actual user ID
            string connStr = ConfigurationManager.ConnectionStrings["PaymentDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT BankName, AccountNumber, IFSC FROM BankAccounts WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvBankDetails.DataSource = dt;
                        gvBankDetails.DataBind();
                    }
                }
            }
        }

        protected void btnAddBank_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddBank.aspx");
        }
    }
}
