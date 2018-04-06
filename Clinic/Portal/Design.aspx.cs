using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Drawing;
using ZMTClinics.Class;
using System.IO;

namespace Clinic.Portal
{
    public partial class Design : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = this.GetData(0);
            PopulateMenu(dt, 0, null);
        }
        private DataTable GetData(int parentMenuId)
        {

            // string query = "SELECT [MenuId], [Title], [Description], [Url] FROM [Menus] WHERE ParentMenuId = @ParentMenuId";
            string query = "SELECT Menu_Code, MenuText, MenuPath,MenuParent from SEC_Menu where MenuType = 6 AND MenuParent=@ParentMenuId";
            using (SqlConnection con = new SqlConnection(constr))
            {
                DataTable dt = new DataTable();
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Parameters.AddWithValue("@ParentMenuId", parentMenuId);
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }
        }
        private void PopulateMenu(DataTable dt, int parentMenuId, MenuItem parentMenuItem)
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath);
            foreach (DataRow row in dt.Rows)
            {
                MenuItem menuItem = new MenuItem
                {
                    Value = row["Menu_Code"].ToString(),
                    Text = row["MenuText"].ToString(),
                    NavigateUrl = row["MenuPath"].ToString(),
                    Selected = row["MenuPath"].ToString().EndsWith(currentPage, StringComparison.CurrentCultureIgnoreCase)
                };
                if (parentMenuId == 0)
                {
                    Menu1.Items.Add(menuItem);
                    DataTable dtChild = this.GetData(int.Parse(menuItem.Value));
                    PopulateMenu(dtChild, int.Parse(menuItem.Value), menuItem);
                }
                else
                {
                    parentMenuItem.ChildItems.Add(menuItem);
                }
            }
        }

    }
}