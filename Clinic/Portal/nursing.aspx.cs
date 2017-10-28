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

namespace ZMTClinics
{
    public partial class nursing : System.Web.UI.Page
    {
        Connection oConnection = new Connection();
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
        // string conn = System.Configuration.ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
      //  SqlConnection con = new SqlConnection("Data Source=Server-DB;Initial Catalog=KT;Integrated Security=True");
        string userCode;
        string SAVE_BUTTON = "Save Nursing Triage";
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            // ******************* MENU ************************//
            string userCode;

            userCode = (Session["User_Code"].ToString());
            SqlDataAdapter da = new SqlDataAdapter("SELECT Menu_Code, MenuText, MenuPath,MenuParent from SEC_Menu where MenuType = 6 AND MenuParent=0", con);
            DataTable dttc = new DataTable();
            da.Fill(dttc);
            HtmlGenericControl main = UList("main-menu", "main-menu");
            foreach (DataRow row in dttc.Rows)
            {
                da = new SqlDataAdapter("select Menu_Code,MenuText,MenuPath,MenuParent from SEC_Menu where MenuParent=" + row["Menu_Code"].ToString() + " order by ISNULL(sortorder,0)", con);
                DataTable dtDist = new DataTable();
                da.Fill(dtDist);
                if (dtDist.Rows.Count > 0)
                {
                    HtmlGenericControl sub_menu = LIList(row["MenuText"].ToString(), row["Menu_Code"].ToString(), row["MenuPath"].ToString());
                    HtmlGenericControl ul = new HtmlGenericControl("ul");
                    foreach (DataRow r in dtDist.Rows)
                    {
                        ul.Controls.Add(LIList(r["MenuText"].ToString(), r["MenuParent"].ToString(), r["MenuPath"].ToString()));
                    }
                    sub_menu.Controls.Add(ul);
                    main.Controls.Add(sub_menu);
                }
                else
                {
                    main.Controls.Add(LIList(row["MenuText"].ToString(), row["Menu_Code"].ToString(), row["MenuPath"].ToString()));
                }
            }
            Panel1.Controls.Add(main);
            // ******************* END MENU ************************//
            if (!IsPostBack)
            {
                getUserImage();
                getUsername();
                Panel1.Controls.Add(main);
                PopulateClinic();
                btn_Submit.Text = SAVE_BUTTON;
                DateTime localDate = DateTime.Now;
            }

        }
        private HtmlGenericControl UList(string id, string cssClass)
        {
            HtmlGenericControl ul = new HtmlGenericControl("ul");
            ul.ID = id;
            ul.Attributes.Add("class", cssClass);
            return ul;
        }
        private HtmlGenericControl LIList(string innerHtml, string rel, string url)
        {
            HtmlGenericControl li = new HtmlGenericControl("li");
            li.Attributes.Add("rel", rel);
            //  li.InnerHtml = "<a href=" + string.Format("http://{0}", url) + ">" + innerHtml + "</a>";
            li.InnerHtml = "<a href=" + string.Format("{0}", url) + ">" + innerHtml + "</a>";
            return li;
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            if (btn_Submit.Text == SAVE_BUTTON)
            {
                string User_Code;
                User_Code = (Session["User_Code"].ToString());
                string sqlQuery;
                sqlQuery = "INSERT INTO MED_NursingTriage(MR_No,Patient_Bp,Patient_Pulse,Patient_Temperature,Patient_Weight,Patient_Height_ft,Patient_Height_inc,Blood_Group,Disease,Family_Disease,User_Code,sysTicketMasterNo)" ;
                sqlQuery += " values('" + lblPatientMrNo.Text + "','" + txtPatientBp.Text + "','" + txtPatientPulse.Text + "','" + txtPatientTemperature.Text + "','" + txtPatientWeight.Text + "','" + txtPatientHeightfeet.Text + "','" + txtPatientHeightinch.Text + "','" + txtBloodGroup.Text + "','" + txtDesease.Text + "','" + txtFamilyDesease.Text + "','" + User_Code + "','" + lblTicketmasterNo.Text + "')";
                SqlCommand cmd = new SqlCommand(sqlQuery, con);
                cmd.CommandType = CommandType.Text;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Literal1.Text = "Data Inserted Succesfully";
                    Session["SESSION_MRNO"] = lblPatientMrNo.Text;
                    Session["SESSION_TICKETNO"] = lblTicketmasterNo.Text;
                    clear();
                    GetPatientForNursingTriage();
                    con.Close();
                    
                    ShowPrintMessage();

                }
                catch (Exception ex)
                {
                    Literal1.Text = ex.Message;
                }
            }
            else
            {
                string User_Code;
                User_Code = (Session["User_Code"].ToString());
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE MED_NursingTriage SET Patient_Bp=@Patient_Bp,Patient_Pulse=@Patient_Pulse,Patient_Temperature=@Patient_Temperature,Patient_Weight=@Patient_Weight,Patient_Height_ft=@Patient_Height_ft,Patient_Height_inc=@Patient_Height_inc,Disease=@Disease,Blood_Group=@BloodGroup,Family_Disease=@FamilyDisease,User_Code=@User_Code where MR_No= @MR_No", con);

                    cmd.Parameters.AddWithValue("@BloodGroup", txtBloodGroup.Text);
                    cmd.Parameters.AddWithValue("@Disease", txtDesease.Text);
                    cmd.Parameters.AddWithValue("@FamilyDisease", txtFamilyDesease.Text);
                    cmd.Parameters.AddWithValue("@User_Code", User_Code);
                    cmd.Parameters.AddWithValue("@MR_No", lblPatientMrNo.Text);
                    cmd.Parameters.AddWithValue("@Patient_Bp", txtPatientBp.Text);
                    cmd.Parameters.AddWithValue("@Patient_Pulse", txtPatientPulse.Text);
                    cmd.Parameters.AddWithValue("@Patient_Temperature", txtPatientTemperature.Text);
                    cmd.Parameters.AddWithValue("@Patient_Weight", txtPatientWeight.Text);
                    cmd.Parameters.AddWithValue("@Patient_Height_ft", txtPatientHeightfeet.Text);
                    cmd.Parameters.AddWithValue("@Patient_Height_inc", txtPatientHeightinch.Text);
                    cmd.ExecuteNonQuery();
                    con.Dispose();
                    ShowMessage("Nursing Triage Updated");

                    // Popluate Gridview

                    this.GetPatient(lblSrNo.Text);
                    Session["SESSION_MRNO"] = lblPatientMrNo.Text;
                    Session["SESSION_TICKETNO"] = lblTicketmasterNo.Text;
                    ShowPrintMessage();
                    clear();
                    btn_Submit.Text = SAVE_BUTTON;

                }
                catch (SqlException ex)
                {
                    ShowMessage(ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }
        }
        public void ShowPrintMessage()
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "Confirm();", true);
        }
        private void PopulateClinic()
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("Select sysClinicSno,Clinic_Name from MED_ClinicRegistration Order by Clinic_Name ", con);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            ddClinic.DataSource = cmd.ExecuteReader();
            ddClinic.DataTextField = "Clinic_Name";
            ddClinic.DataValueField = "sysClinicSno";
            ddClinic.DataBind();
            con.Close();
            ddClinic.SelectedValue = Session["sysClinicSNo"].ToString();
            GetPatientForNursingTriage();
           // ddClinic.Enabled = false;
        }
        private void getUserImage()
        {
            object img;
            img = oConnection.GetDataTable("SELECT Employee_Image FROM HRM_EmployeeSetup WHERE sysEmployeeSno =dbo.Func_SEC_UserCode_sysEmployeeSno(" + Session["User_Code"] + ")").Rows[0]["Employee_Image"];
            if (img != DBNull.Value)
            {
                byte[] bytes = (byte[])img;
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                ImgUser.ImageUrl = "data:image/png;base64," + base64String;
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
                            lblUserName.Text = dt.Rows[0]["User_Name"].ToString();
                            // lblUser.Text = dt.Rows[0]["User_Name"].ToString();
                            return dt;
                        }
                    }
                }
            }

        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {

            if (!txtPatientSearch.Text.Length.Equals(0)) { 
                GetPatient(txtPatientSearch.Text);
            }
            
            //string parameter;
            //parameter = "AND Search Like ''%" + txtPatientSearch.Text + "%'' AND CONVERT(varchar(15),Ticket_DATE,6)= CONVERT(varchar(15),Getdate(),6) ";
            //GetPatient(parameter);


        }
        private void GetPatient(string patientName)
        {
            
            
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("MED_GetNursingRegistration", con);
                cmd.CommandType = CommandType.StoredProcedure;
                if (!string.IsNullOrEmpty(patientName))
                {
                    SqlParameter parameter = new SqlParameter("@SearchString", patientName);
                    cmd.Parameters.Add(parameter);
                }  
                con.Open();
                SqlDataReader rdr;
                rdr= cmd.ExecuteReader();
                gvPatients.DataSource = rdr;
                gvPatients.DataBind();

            }
        }
       private void GetPatientForNursingTriage()
        {
            DataTable dt = new DataTable();
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("MED_GetPatientForNursingTriage", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                da.Fill(dt);
                SqlDataReader rdr = cmd.ExecuteReader();
                gvNursingTriage.DataSource = rdr;
                gvNursingTriage.DataBind();
                
                
            }
        }
        
        protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)
        {
            Connection Conn = new Connection();
            DataTable DT = new DataTable();
            DT = Conn.GetDataTable("EXECUTE [MED_GetPatientDetail]  ' AND Registration_No =''" + gvPatients.SelectedRow.Cells[2].Text + "'' AND sysNursingTriageSNo =''" + gvPatients.SelectedRow.Cells[1].Text + "''    ' ");
            clear();
            lblPatientMrNo.Text = DT.Rows[0]["Registration_No"].ToString();
            lblPatientRegistrationDate.Text = DT.Rows[0]["Registration_Date"].ToString();
            string FirstName;
            string MiddleName;
            string LastName;
            FirstName = DT.Rows[0]["First_Name"].ToString();
            MiddleName = DT.Rows[0]["Middle_Name"].ToString();
            LastName = DT.Rows[0]["Last_Name"].ToString();
            lblPatientFirstName.Text = FirstName  + "    " +  MiddleName  + "    " +  LastName;
          //  lblPatientFirstName.Text = DT.Rows[0]["First_Name"].ToString() +  "   "  + DT.Rows[0]["Middle_Name"].ToString() +  "   "  + DT.Rows[0]["Last_Name"].ToString();
            lblPatientFatherName.Text = DT.Rows[0]["Father_Name"].ToString();
            lblPatientAge.Text = DT.Rows[0]["Age"].ToString();
            if (DT.Rows[0]["Gender"].ToString() == "Male")
            {

                lblPatientGender.Text = "Male";
            }
            else if (DT.Rows[0]["Gender"].ToString() == "Female")
            {

                lblPatientGender.Text = "Female";
            }
            string MaritialStatus;
            if (DT.Rows[0]["Maritial_Status"].ToString() == "1")
            {
                MaritialStatus = "Married";
            }
            else
            {
                MaritialStatus = "Single";
            }
            lblPatientMaritialStatus.Text = MaritialStatus;
            string ReligionStatus;
            if (DT.Rows[0]["Religion_Code"].ToString() == "1")
            {
                ReligionStatus = "Islam";
            }
            else if (DT.Rows[0]["Religion_Code"].ToString() == "2")
            {
                ReligionStatus = "Chiristianity";
            }
            else
            {
                ReligionStatus = "Hinduism";
            }
            // ddReligion.SelectedValue = DT.Rows[0]["Religion_Code"].ToString();
            lblPatientReligion.Text = ReligionStatus;
           // ddMaritialStatus.SelectedValue = DT.Rows[0]["Maritial_Status"].ToString();
            //ddReligion.SelectedValue = DT.Rows[0]["Religion_Code"].ToString();
            lblSrNo.Text = DT.Rows[0]["sys_PatientSno"].ToString();
            lblPatientToken.Text = DT.Rows[0]["Ticket_Number"].ToString();
            txtPatientBp.Text = DT.Rows[0]["Patient_Bp"].ToString();
            txtPatientPulse.Text = DT.Rows[0]["Patient_Pulse"].ToString();
            txtPatientTemperature.Text = DT.Rows[0]["Patient_Temperature"].ToString();
            txtPatientWeight.Text = DT.Rows[0]["Patient_Weight"].ToString();
            txtPatientHeightfeet.Text = DT.Rows[0]["Patient_Height_ft"].ToString();
            txtPatientHeightinch.Text = DT.Rows[0]["Patient_Height_inc"].ToString();
            txtDesease.Text = DT.Rows[0]["Disease"].ToString();
            txtFamilyDesease.Text = DT.Rows[0]["Family_Disease"].ToString();
            txtBloodGroup.Text = DT.Rows[0]["Blood_Group"].ToString();
            lblTicketmasterNo.Text = DT.Rows[0]["sysTicketMasterNo"].ToString();
            
            btn_Submit.Text = "Update Nursing Triage";
        }

        protected void gvPatients_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                e.Row.Attributes["onKeyDown"] = "javascript:setMouseOverColor(this);";
                e.Row.Attributes["onblur"] = "javascript:setMouseOutColor(this);";

                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvPatients, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }


        }

        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvPatients.Rows)
            {
                if (row.RowIndex == gvPatients.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                    row.ToolTip = string.Empty;
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }
            }
        }

        protected void btn_Update_Click(object sender, EventArgs e)
        {
          
            //con.Open();
            //SqlCommand cmd = new SqlCommand("UPDATE MED_PatientRegistration SET First_Name= '" + txtFirstName.Text + "', Middle_Name = '" + txtMiddleName.Text + "',Last_Name = '" + txtLastName.Text + "',CNIC_No = '" + txtCNICNO.Text + "',Permanent_Address = '" + txtPermanentAddress.Text + "',Permanent_Area = '" + txtPermanentBlock.Text + "',Permanent_City = '" + ddlPermanentCity.SelectedValue + "',Permanent_Province= '" + ddlPermanentProvince.SelectedValue + "',Permanent_Country = '" + ddlPermanentCountry.SelectedValue + "',Present_Address = '" + txtAddress.Text + "',Present_Area = '" + txtArea.Text + "',Present_City = '" + ddlCity.SelectedValue + "',Present_Country = '" + ddlCountry.SelectedIndex + "',Present_Province = '" + ddlProvince.SelectedValue + "',Age = '" + txtAge.Text + "',Maritial_Status = '" + ddMaritialStatus.SelectedValue + "',Mobile_1 = '" + txtMobile1.Text + "',Mobile_2 = '" + txtMobile2.Text + "',Phone_Number = '" + txtContactNo.Text + "',Registered_By = '" + txtRegisterBy.Text + "',Registered_Relation = '" + ddReligion.SelectedValue + "',Registered_ContactNo = '" + txtRegisterByContactNo.Text + "',Clinic = '" + ddClinic.SelectedValue + "',Zakat_Eligble = '" + txtZakaEligble.Text + "',Monthly_Income = '" + txtMonthlyIncome.Text + "',No_Of_Children = '" + txtNoOfChildren.Text + "' WHERE sys_PatientSno = '" + lblSrNo.Text + "'", con);
            //cmd.ExecuteNonQuery();
        }
        public void ShowMessage(string msg)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script  language='javascript'>alert('" + msg + "');</script>");
        }

        protected void btn_Cancel_Click(object sender, EventArgs e)
        {
            clear();
        }

        public void clear()
        {
            txtBloodGroup.Text = string.Empty;
            txtDesease.Text = string.Empty;
            txtFamilyDesease.Text = string.Empty;
            txtPatientBp.Text = string.Empty;
            txtPatientPulse.Text = string.Empty;
            txtPatientTemperature.Text = string.Empty;
            txtPatientWeight.Text = string.Empty;
            txtPatientHeightfeet.Text = string.Empty;
            txtPatientHeightinch.Text = string.Empty;
            lblPatientAge.Text = string.Empty;
            //lblPatientCNICNo.Text = string.Empty;
            lblPatientReligion.Text = string.Empty;
            lblPatientFatherName.Text = string.Empty;
            lblPatientFirstName.Text = string.Empty;
            lblPatientRegistrationDate.Text = string.Empty;
            lblPatientRegistrationDate.Text = string.Empty;
            lblPatientMrNo.Text = string.Empty;
            lblPatientToken.Text = string.Empty;
            lblPatientGender.Text = string.Empty;
            lblPatientMaritialStatus.Text = string.Empty;
        }

        protected void gvNursingTriage_SelectedIndexChanged(object sender, EventArgs e)
        {
            Connection Conn = new Connection();
            DataTable DT = new DataTable();
            DT = Conn.GetDataTable("EXECUTE [MED_GetPatientDetail]  ' AND Registration_No =''" + gvNursingTriage.SelectedRow.Cells[2].Text + "'' ' ");
            clear();
            
            lblPatientRegistrationDate.Text = DT.Rows[0]["Registration_Date"].ToString();
            //ddReligion.SelectedValue = DT.Rows[0]["Religion_Code"].ToString();
            string FirstName;
            string MiddleName;
            string LastName;
            FirstName = DT.Rows[0]["First_Name"].ToString();
            MiddleName = DT.Rows[0]["Middle_Name"].ToString();
            LastName = DT.Rows[0]["Last_Name"].ToString();
            lblPatientFirstName.Text = FirstName + "    " + MiddleName + "    " + LastName;
            lblPatientFatherName.Text = DT.Rows[0]["Father_Name"].ToString();
            lblPatientAge.Text = DT.Rows[0]["Age"].ToString();
            //lblPatientCNICNo.Text = DT.Rows[0]["CNIC_No"].ToString();
            

            if (DT.Rows[0]["Gender"].ToString() == "Male")
            {

                lblPatientGender.Text = "Male";
            }
            else if (DT.Rows[0]["Gender"].ToString() == "Female")
            {

                lblPatientGender.Text = "Female";
            }
            string MaritialStatus;
            if (DT.Rows[0]["Maritial_Status"].ToString() == "1")
            {
                MaritialStatus = "Married";
            }
            else
            {
                MaritialStatus = "Single";
            }
           // ddMaritialStatus.SelectedValue = DT.Rows[0]["Maritial_Status"].ToString();
            lblPatientMaritialStatus.Text = MaritialStatus;
            string ReligionStatus;
            if (DT.Rows[0]["Religion_Code"].ToString() == "1")
            {
                ReligionStatus = "Islam";
            }
            else if (DT.Rows[0]["Religion_Code"].ToString() == "2")
            {
                ReligionStatus = "Chiristianity";
            }
            else
            {
                ReligionStatus = "Hinduism";
            }
           // ddReligion.SelectedValue = DT.Rows[0]["Religion_Code"].ToString();
            lblPatientReligion.Text = ReligionStatus;
            lblSrNo.Text = DT.Rows[0]["sys_PatientSno"].ToString();


            // load from grid 
            lblTicketmasterNo.Text = gvNursingTriage.SelectedRow.Cells[1].Text.ToString();
            lblPatientMrNo.Text = gvNursingTriage.SelectedRow.Cells[2].Text.ToString();
            lblPatientToken.Text = gvNursingTriage.SelectedRow.Cells[4].Text.ToString();
            


            btn_Submit.Text = "Save Nursing Triage";
        }
    }
}