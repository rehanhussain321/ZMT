using System;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Web.Mail;
using System.Web.Script.Serialization;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.Drawing;
using ZMTClinics.Class;
using System.IO;

namespace ZMTClinics
{
    public partial class grid : System.Web.UI.Page
    {
        Connection oConnection = new Connection();
       // string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string userCode;
            userCode = (Session["User_Code"].ToString());
            SqlDataAdapter da = new SqlDataAdapter("Select Menu_Code, MenuText, MenuPath,MenuParent from SEC_Menu where MenuType = 6 AND MenuParent=0", constr);
            //  SqlDataAdapter da = new SqlDataAdapter("SEC_GetUserMenu 8,4", con);
            DataTable dttc = new DataTable();
            da.Fill(dttc);
            //HtmlGenericControl main = UList("main-menu", "main-menu");
            //foreach (DataRow row in dttc.Rows)
            //{
            //    da = new SqlDataAdapter("select Menu_Code,MenuText,MenuPath,MenuParent from SEC_Menu where MenuParent=" + row["Menu_Code"].ToString() +" order by ISNULL(sortorder,0)", constr);
            //    // da = new SqlDataAdapter("SELECT  Case MP.Menu_Code WHEN 0 THEN NULL ELSE MP.Menu_Code END AS ParentCode , MP.MenuText AS ParentMenu , M.MenuText , M.Menu_Code , M.MenuType, M.MenuPath, M.MenuDirPath FROM SEC_Menu M INNER JOIN SEC_RoleDetail RD ON RD.Menu_Code = M.Menu_Code INNER JOIN SEC_Role R ON RD.Role_Code = R.Role_Code INNER JOIN SEC_GroupDetail GD ON GD.Role_Code = RD.Role_Code INNER JOIN SEC_Group G ON GD.Group_Code = G.Group_Code INNER JOIN SEC_User U ON U.Group_Code = G.Group_Code INNER JOIN SEC_Menu MP ON MP.Menu_Code = M.MenuParent  WHERE 	U.User_Code  = '8' AND M.Menu_Code NOT IN (SELECT Menu_Code FROM SEC_UserRights WHERE User_Code  = '8')and M.MenuType='4' and MP.Menu_Code <>0 UNION SELECT   Case MP.Menu_Code WHEN 0 THEN NULL ELSE MP.Menu_Code END AS ParentCode , MP.MenuText AS ParentMenu , M.MenuText , M.Menu_Code ,M.MenuType    , M.MenuPath, M.MenuDirPath FROM SEC_Menu M  INNER JOIN SEC_UserRights UR ON UR.Menu_Code = M.Menu_Code INNER JOIN SEC_Menu MP ON MP.Menu_Code = M.MenuParent WHERE User_Code  = '8'and M.MenuType='4' and m.Menu_Code <>0", con);
            //    DataTable dtDist = new DataTable();
            //    da.Fill(dtDist);
            //    if (dtDist.Rows.Count > 0)
            //    {
            //        HtmlGenericControl sub_menu = LIList(row["MenuText"].ToString(), row["Menu_Code"].ToString(), row["MenuPath"].ToString());
            //        HtmlGenericControl ul = new HtmlGenericControl("ul");
            //        foreach (DataRow r in dtDist.Rows)
            //        {
            //            ul.Controls.Add(LIList(r["MenuText"].ToString(), r["MenuParent"].ToString(), r["MenuPath"].ToString()));
            //        }
            //        sub_menu.Controls.Add(ul);
            //        main.Controls.Add(sub_menu);
            //    }
            //    else
            //    {
            //        main.Controls.Add(LIList(row["MenuText"].ToString(), row["Menu_Code"].ToString(), row["MenuPath"].ToString()));
            //    }
            //}
            GetLastMonthPatient();
            GetThisMonthPatients();
            GetPharmasyThisMonth();
            PopulatePatientGrid();
            //PopulatePatientMaritialStatusGrid();
            //PopulategrdPatientAdmissionRelation();
            //PopulategrdPatientDetail();
           // getUserImage();
            getUsername();
           // Panel1.Controls.Add(main);
            DateTime localDate = DateTime.Now;
            System.Guid guid = System.Guid.NewGuid();
            string MRNo = guid.ToString();
            if (!this.IsPostBack)
            {
                DataTable dt = this.GetData(0);
                PopulateMenu(dt, 0, null);
            }
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
        private void GetLastMonthPatient()
        {
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            string query = "SELECT COUNT(sys_PatientSno) As RecordCount FROM MED_PatientRegistration WHERE Registration_Date BETWEEN (SELECT  DATEADD (DAY, -DAY(GETDATE())+1 , DATEADD (MONTH ,-1,GETDATE())))	AND (SELECT DATEADD (day,-DAY(GETDATE()) ,GETDATE()))";
            SqlCommand cmd = new SqlCommand(query,con);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            con.Close();
            lblPatientLastMonth.Text = ds.Tables[0].Rows[0]["RecordCount"].ToString();
        }
        private void GetThisMonthPatients()
        {
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            string query = "SELECT COUNT(*) AS RecordCount FROM MED_PatientRegistration WHERE Registration_Date BETWEEN (SELECT DATEADD (day,-DAY(GETDATE())+1 ,GETDATE())) AND GETDATE()";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            con.Close();
            lblPatientThisMonth.Text = ds.Tables[0].Rows[0]["RecordCount"].ToString();
        }
        private void GetPharmasyThisMonth()
        {
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            string query = "SELECT SUM(A.Quantity_Issued) AS Total_Pharmasy FROM STR_IssueDetail A INNER JOIN STR_IssueMaster B ON A.sysIssueMasterNo = B.sysIssueMasterNo WHERE Document_Date BETWEEN (SELECT DATEADD (day,-DAY(GETDATE())+1 ,GETDATE())) AND GETDATE()";
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            con.Close();
            lblMedicineIssuedThisMonth.Text = ds.Tables[0].Rows[0]["Total_Pharmasy"].ToString();
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
        private void PopulatePatientGrid()
        {
            DataTable resultText = new DataTable();
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT TOP(20) Cast(Ticket_Date as Date) AS Ticket_Date,dbo.Func_MED_sysClinicSno_Clinic_Name(sysClinicSNo) ClinicName,COUNT(*) 'No. of Patients'   FROM MED_TicketMaster Group By	Cast(Ticket_Date as Date),sysClinicSNo order by 1 desc"))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        cmd.Connection = con;
                        da.SelectCommand = cmd;
                        da.Fill(ds, "MED_TicketMaster");
                        grdPatient.DataSource  = ds;
                        grdPatient.DataBind();
                    }
                }
            }
        }
        //private void PopulatePatientMaritialStatusGrid()
        //{
        //    DataTable resultText = new DataTable();
        //    DataSet ds = new DataSet();
        //    using (SqlConnection con = new SqlConnection(constr))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("SELECT TOP 20	Cast(Registration_Date as Date) RegistrationDate,dbo.Func_MED_sysClinicSno_Clinic_Name(sysClinicSNo) ClinicName,COUNT(*) 'No. of Patients'     from MED_PatientRegistration WHERE Cast(Registration_Date as Date) < DATEADD(d,-4,Cast(GETDATE() as Date) ) Group By	Cast(Registration_Date as Date),sysClinicSNo Order By		Cast(Registration_Date as Date) DESC"))
        //        {
        //            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //            {
        //                cmd.Connection = con;
        //                da.SelectCommand = cmd;
        //                da.Fill(ds, "MED_PatientRegistrationn");
        //                grdPatientMaritialStatus.DataSource = ds;
        //                grdPatientMaritialStatus.DataBind();
        //            }
        //        }
        //    }
        //}
        //private void PopulategrdPatientAdmissionRelation()
        //{
        //    DataTable resultText = new DataTable();
        //    DataSet ds = new DataSet();
        //    using (SqlConnection con = new SqlConnection(constr))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("Select Doctor_Name from MED_DoctorRegistration "))
        //        {
        //            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //            {
        //                cmd.Connection = con;
        //                da.SelectCommand = cmd;
        //                da.Fill(ds, "MED_DoctorRegistration");
        //                grdPatientAdmissionRelation.DataSource = ds;
        //                grdPatientAdmissionRelation.DataBind();
        //            }
        //        }
        //    }
        //}
        //private void PopulategrdPatientDetail()
        //{
        //    DataTable resultText = new DataTable();
        //    DataSet ds = new DataSet();
        //    using (SqlConnection con = new SqlConnection(constr))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("Select Clinic_Name,Clinic_Incharge,Clinic_Area from MED_ClinicRegistration "))
        //        {
        //            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //            {
        //                cmd.Connection = con;
        //                da.SelectCommand = cmd;
        //                da.Fill(ds, "MED_ClinicRegistration");
        //                grdPatientDetail.DataSource = ds;
        //                grdPatientDetail.DataBind();
        //            }
        //        }
        //    }
        //}
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
        private void getUserImage()
        {
            object img;
            img = oConnection.GetDataTable("SELECT Employee_Image FROM HRM_EmployeeSetup WHERE sysEmployeeSno =dbo.Func_SEC_UserCode_sysEmployeeSno(" + Session["User_Code"] + ")").Rows[0]["Employee_Image"];
            if (img!= DBNull.Value)
            {
                byte[] bytes = (byte[])img;
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                ImgUser.ImageUrl = "data:image/png;base64," + base64String;
            }
            else
            {
                Response.Write("<script>alert'Image not Available';</script>");
            }
        }
        //protected void btnSubmit_Click(object sender, EventArgs e)
        //{
        //    string dt = Request.Form[txtDOB.UniqueID];
        //}
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
                            lblUserName.Text = dt.Rows[0]["User_Name"].ToString();
                            // lblUser.Text = dt.Rows[0]["User_Name"].ToString();
                            return dt;
                        }
                    }
                }
            }

        }
    }
}