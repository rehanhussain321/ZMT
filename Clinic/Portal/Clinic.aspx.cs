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
using KT_Classes;
using System.Drawing;
using ZMTClinics.Class;
using System.IO;

namespace ZMTClinics
{
    public partial class Clinic : System.Web.UI.Page
    {
        Connection oConnection = new Connection();
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
        //SqlConnection con = new SqlConnection("Data Source=Server-DB;Initial Catalog=KT;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            string userCode;
            userCode = (Session["User_Code"].ToString());
            if (!this.IsPostBack)
            {
                DataTable dt = this.GetData(0);
                PopulateMenu(dt, 0, null);
            }
        //    SqlDataAdapter da = new SqlDataAdapter("Select Menu_Code, MenuText, MenuPath,MenuParent from SEC_Menu where MenuType = 6 AND MenuParent=0", con);
        //    //  SqlDataAdapter da = new SqlDataAdapter("SEC_GetUserMenu 8,4", con);
        //    DataTable dttc = new DataTable();
        //    da.Fill(dttc);
        //    /*##########################################################Coding for Menu Start ##############################################################################################*/
        //    HtmlGenericControl main = UList("main-menu", "main-menu");
        //    foreach (DataRow row in dttc.Rows)
        //    {
        //        da = new SqlDataAdapter("select Menu_Code,MenuText,MenuPath,MenuParent from SEC_Menu where MenuParent=" + row["Menu_Code"].ToString() + " order by ISNULL(sortorder,0)", con);
        //        // da = new SqlDataAdapter("SELECT  Case MP.Menu_Code WHEN 0 THEN NULL ELSE MP.Menu_Code END AS ParentCode , MP.MenuText AS ParentMenu , M.MenuText , M.Menu_Code , M.MenuType, M.MenuPath, M.MenuDirPath FROM SEC_Menu M INNER JOIN SEC_RoleDetail RD ON RD.Menu_Code = M.Menu_Code INNER JOIN SEC_Role R ON RD.Role_Code = R.Role_Code INNER JOIN SEC_GroupDetail GD ON GD.Role_Code = RD.Role_Code INNER JOIN SEC_Group G ON GD.Group_Code = G.Group_Code INNER JOIN SEC_User U ON U.Group_Code = G.Group_Code INNER JOIN SEC_Menu MP ON MP.Menu_Code = M.MenuParent  WHERE 	U.User_Code  = '8' AND M.Menu_Code NOT IN (SELECT Menu_Code FROM SEC_UserRights WHERE User_Code  = '8')and M.MenuType='4' and MP.Menu_Code <>0 UNION SELECT   Case MP.Menu_Code WHEN 0 THEN NULL ELSE MP.Menu_Code END AS ParentCode , MP.MenuText AS ParentMenu , M.MenuText , M.Menu_Code ,M.MenuType    , M.MenuPath, M.MenuDirPath FROM SEC_Menu M  INNER JOIN SEC_UserRights UR ON UR.Menu_Code = M.Menu_Code INNER JOIN SEC_Menu MP ON MP.Menu_Code = M.MenuParent WHERE User_Code  = '8'and M.MenuType='4' and m.Menu_Code <>0", con);
        //        DataTable dtDist = new DataTable();
        //        da.Fill(dtDist);
        //        if (dtDist.Rows.Count > 0)
        //        {
        //            HtmlGenericControl sub_menu = LIList(row["MenuText"].ToString(), row["Menu_Code"].ToString(), row["MenuPath"].ToString());
        //            HtmlGenericControl ul = new HtmlGenericControl("ul");
        //            foreach (DataRow r in dtDist.Rows)
        //            {
        //                ul.Controls.Add(LIList(r["MenuText"].ToString(), r["MenuParent"].ToString(), r["MenuPath"].ToString()));
        //            }
        //            sub_menu.Controls.Add(ul);
        //            main.Controls.Add(sub_menu);
        //        }
        //        else
        //        {
        //            main.Controls.Add(LIList(row["MenuText"].ToString(), row["Menu_Code"].ToString(), row["MenuPath"].ToString()));
        //        }
        //    }
        //    /*##########################################################Coding for Menu End ##############################################################################################*/
        //    getUserImage();/*Function to get UserImage*/
        //    getUsername();/*Function to get UserName*/
        //    PopulateClinic();/*Function to Populate Clinics*/
        //    Panel1.Controls.Add(main);/*For Menu*/
        //    DateTime localDate = DateTime.Now;
        //   // txtRegtDate.Text = localDate.ToString();
        //   // System.Guid guid = System.Guid.NewGuid();
        //   // txtClinicID.Text = guid.ToString(); 
        //   // string MRNo = guid.ToString();
        //   // txtMrNo.Text = MRNo;
        //    // txtAge.Attributes.Add("onKeyUp", "CalculateAge()");
        //}
        ///*##########################################################Functions for Menu Part ##############################################################################################*/
        //private HtmlGenericControl UList(string id, string cssClass)
        //{
        //    HtmlGenericControl ul = new HtmlGenericControl("ul");
        //    ul.ID = id;
        //    ul.Attributes.Add("class", cssClass);
        //    return ul;
        //}
        //private HtmlGenericControl LIList(string innerHtml, string rel, string url)
        //{
        //    HtmlGenericControl li = new HtmlGenericControl("li");
        //    li.Attributes.Add("rel", rel);
        //    //  li.InnerHtml = "<a href=" + string.Format("http://{0}", url) + ">" + innerHtml + "</a>";
        //    li.InnerHtml = "<a href=" + string.Format("{0}", url) + ">" + innerHtml + "</a>";
        //    return li;
        //}
        ///*##########################################################End of Functions for Menu Part ##############################################################################################*/
        //private void getUserImage()
        //{
        //    object img;
        //    img = oConnection.GetDataTable("SELECT Employee_Image FROM HRM_EmployeeSetup WHERE sysEmployeeSno =dbo.Func_SEC_UserCode_sysEmployeeSno(" + Session["User_Code"] + ")").Rows[0]["Employee_Image"];
        //    if (img != DBNull.Value)
        //    {
        //        byte[] bytes = (byte[])img;
        //        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        //        ImgUser.ImageUrl = "data:image/png;base64," + base64String;
        //    }
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
        private DataTable getUsername()
        {
            string usercode = Session["User_Code"].ToString();

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Select User_Name from SEC_User where User_Code =' " + usercode + " '"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            //lblUserName.Text = dt.Rows[0]["User_Name"].ToString();
                            // lblUser.Text = dt.Rows[0]["User_Name"].ToString();
                            return dt;
                        }
                    }
                }
            }

        }
        /*################################################################ Function for Gridview ##################################################################################*/
        private void GetClinics(string ClinicName)
        {
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("MED_GetClinics", con);
                cmd.CommandType = CommandType.StoredProcedure;
                if (!string.IsNullOrEmpty(ClinicName))
                {
                    SqlParameter parameter = new SqlParameter("@SearchString", ClinicName);
                    cmd.Parameters.Add(parameter);
                }
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                gvClinics.DataSource = rdr;
                gvClinics.DataBind();
            }
        }
        /*##########################################################End of Function ##############################################################################################*/
        /*##########################################################Clinic Save Event Start ##############################################################################################*/
        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("INSERT INTO MED_ClinicRegistration(Clinic_Registration_No,Clinic_Name,Clinic_Area,Clinic_City,Clinic_Province,Clinic_ContactNumber,Clinic_Country,Clinic_InchargeContactNumber,Clinic_Incharge,Clinic_Address) values ('" + txtClinicID.Text + "','" + txtClinicName.Text + "','" + txtArea.Text + "','" + ddlCity.SelectedItem.ToString() + "','" + ddlProvince.SelectedItem.ToString() + "','" + txtClinicContactNo.Text + "','" + ddlCountry.SelectedItem.ToString() + "','" + txtClinicHeadContact.Text + "','" + txtClinicHead.Text + "','" + txtArea.Text + "')", con);
            cmd.CommandType = CommandType.Text;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                Literal1.Text = "Data Inserted Succesfully";
                con.Close();
            }
            catch (Exception ex)
            {
                Literal1.Text = ex.Message;
            }
        }
        /*##########################################################Clinic Save Event End ##############################################################################################*/
        protected void gvClinics_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtClinicID.Text = gvClinics.SelectedRow.Cells[1].Text;
            txtClinicName.Text = gvClinics.SelectedRow.Cells[2].Text;
            txtClinicHead.Text = gvClinics.SelectedRow.Cells[3].Text;
            txtClinicContactNo.Text = gvClinics.SelectedRow.Cells[4].Text;
            txtClinicHeadContact.Text = gvClinics.SelectedRow.Cells[5].Text;
            ddlCity.SelectedValue = gvClinics.SelectedRow.Cells[6].Text;
            ddlProvince.SelectedValue = gvClinics.SelectedRow.Cells[7].Text;
            ddlCountry.SelectedValue = gvClinics.SelectedRow.Cells[8].Text;
            txtAddress.Text = gvClinics.SelectedRow.Cells[9].Text;
            txtArea.Text = gvClinics.SelectedRow.Cells[10].Text;
            lblSrNo.Text = gvClinics.SelectedRow.Cells[12].Text;
        }

        protected void gvClinics_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                e.Row.Attributes["onKeyDown"] = "javascript:setMouseOverColor(this);";
                e.Row.Attributes["onblur"] = "javascript:setMouseOutColor(this);";

                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvClinics, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

         /*##############################################Search Button Click to show GridView################################################*/
        protected void Search_Click(object sender, EventArgs e)
        {
            GetClinics(txtPatientSearch.Text);
        }
        /*##############################################To Populate Clinics ###################################################################*/
        private void PopulateClinic()
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("Select sysClinicSno,Clinic_Name from MED_ClinicRegistration", con);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            ddClinic.DataSource = cmd.ExecuteReader();
            ddClinic.DataTextField = "Clinic_Name";
            ddClinic.DataValueField = "sysClinicSno";
            ddClinic.DataBind();
            // ddClinic.Items.Insert(0, new ListItem("Select Clinic", "0"));
            con.Close();
            ddClinic.SelectedValue = "3";
        }
       /*##############################################To Update Clinic #######################################################################*/
        protected void btn_Update_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            string User_Code;
            User_Code = (Session["User_Code"].ToString());
            try
            {

                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE MED_ClinicRegistration SET Clinic_Registration_No=@Clinic_Registration_No,Clinic_Name=@Clinic_Name,Clinic_Incharge=@Clinic_Incharge,Clinic_ContactNumber=@Clinic_ContactNumber,Clinic_InchargeContactNumber=@Clinic_InchargeContactNumber,Clinic_Address=@Clinic_Address,Clinic_Area=@Clinic_Area,UserCode=@User_Code where sysClinicSno= @sys_ClinicSno", con);
                cmd.Parameters.AddWithValue("@Clinic_Registration_No", txtClinicID.Text);
                cmd.Parameters.AddWithValue("@Clinic_Name", txtClinicName.Text);
                cmd.Parameters.AddWithValue("@Clinic_Incharge", txtClinicHead.Text);
                cmd.Parameters.AddWithValue("@Clinic_ContactNumber",txtClinicContactNo.Text);
                cmd.Parameters.AddWithValue("@Clinic_InchargeContactNumber", txtClinicHeadContact.Text);
                cmd.Parameters.AddWithValue("@Clinic_Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@Clinic_Area", txtArea.Text);
                cmd.Parameters.AddWithValue("@sys_ClinicSno", lblSrNo.Text);
                cmd.Parameters.AddWithValue("@User_Code", User_Code);
                cmd.ExecuteNonQuery();
                con.Dispose();
                ShowMessage("Clinic Updated");

                // Popluate Gridview

                this.GetClinics(lblSrNo.Text);


            }
            catch (SqlException ex)
            {
                ShowMessage(ex.Message);
            }
            finally
            {
                con.Close();
            }
            //con.Open();
            //SqlCommand cmd = new SqlCommand("UPDATE MED_PatientRegistration SET First_Name= '" + txtFirstName.Text + "', Middle_Name = '" + txtMiddleName.Text + "',Last_Name = '" + txtLastName.Text + "',CNIC_No = '" + txtCNICNO.Text + "',Permanent_Address = '" + txtPermanentAddress.Text + "',Permanent_Area = '" + txtPermanentBlock.Text + "',Permanent_City = '" + ddlPermanentCity.SelectedValue + "',Permanent_Province= '" + ddlPermanentProvince.SelectedValue + "',Permanent_Country = '" + ddlPermanentCountry.SelectedValue + "',Present_Address = '" + txtAddress.Text + "',Present_Area = '" + txtArea.Text + "',Present_City = '" + ddlCity.SelectedValue + "',Present_Country = '" + ddlCountry.SelectedIndex + "',Present_Province = '" + ddlProvince.SelectedValue + "',Age = '" + txtAge.Text + "',Maritial_Status = '" + ddMaritialStatus.SelectedValue + "',Mobile_1 = '" + txtMobile1.Text + "',Mobile_2 = '" + txtMobile2.Text + "',Phone_Number = '" + txtContactNo.Text + "',Registered_By = '" + txtRegisterBy.Text + "',Registered_Relation = '" + ddReligion.SelectedValue + "',Registered_ContactNo = '" + txtRegisterByContactNo.Text + "',Clinic = '" + ddClinic.SelectedValue + "',Zakat_Eligble = '" + txtZakaEligble.Text + "',Monthly_Income = '" + txtMonthlyIncome.Text + "',No_Of_Children = '" + txtNoOfChildren.Text + "' WHERE sys_PatientSno = '" + lblSrNo.Text + "'", con);
            //cmd.ExecuteNonQuery()
        }
        public void ShowMessage(string msg)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script  language='javascript'>alert('" + msg + "');</script>");
        }
    }
}