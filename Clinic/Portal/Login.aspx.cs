using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using EncrypteDecrypte;
using ZMTClinics.Class;

namespace ZMTClinics
{
    public partial class Login : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            //SqlCommand cmd = new SqlCommand("SELECT * from SEC_User where Login= '" + txtusername.Text + "' AND Password2 = '" + txtpassword.Text + "'", con);
            //SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //sda.Fill(dt);
            //con.Open();
            //int i = cmd.ExecuteNonQuery();
            //con.Close();
            //if (dt.Rows.Count > 0)
            //{
            //    Session["User_Code"] = txtusername.Text;
            //    Response.Redirect("Patient.aspx");
            //    Session.RemoveAll();
            //}
            //else
            //{
                
            //}
            login_user();
        }
        private void login_user()
        {
            DataTable _dt = new DataTable();
            //connection _conn = new connection();
            ConNew _conn = new ConNew();
            User ouser;
            ouser = new User();
            _dt = _conn.GetDataTable("Select User_Code,Login,Password, (SELECT Top 1 sysClinicSNo from MED_ClinicRegistration where Clinic_UserCode=A.User_Code) As sysClinicSNo from SEC_User  A where Login='" + txtusername.Text + "'AND Password ='" + ouser.PasswordEncrypt(txtpassword.Text) + "'");
            if (!_dt.Rows.Count.Equals(0))
            {
                Session["User_Code"] = _dt.Rows[0].ItemArray[0].ToString();
                Session["Login"] = _dt.Rows[0].ItemArray[1].ToString();
                Session["Password"] = _dt.Rows[0].ItemArray[2].ToString();
                Session["sysClinicSNo"] = _dt.Rows[0].ItemArray[3].ToString();  

            }
            if (_dt.Rows.Count > 0)
            {

                Response.Redirect("grid.aspx?User_Code");
            }
            else
            {
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='Javascript'>alert('Invalid Username and Password')</script>");
            }
        }
    }

}