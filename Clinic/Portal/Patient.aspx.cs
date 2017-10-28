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
//using KT_Classes;
using System.Drawing;
using ZMTClinics.Class; 

namespace ZMTClinics
{
    public partial class patient_copy : System.Web.UI.Page
    {
        Connection oConnection = new Connection();

        Connection oConn = new Connection();
        
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;

        SqlCommandBuilder c_Builder = default(SqlCommandBuilder);
        SqlDataAdapter d_Adapter = default(SqlDataAdapter);

        DataTable T_Detail = new DataTable();

        double viewCount = 0;
        int I_Count;
        string sysTicketMasterNo;
        string SAVE_BUTTON = "Save Patient";

        protected void Page_Load(object sender, EventArgs e)
        {

            this.MaintainScrollPositionOnPostBack = true;
            this.CreateMenu();

            DateTime localDate = DateTime.Now;
            lblPatientRegistrationDate.Text = localDate.ToString();
            if (!IsPostBack)
            {
                this.PopulatePayingStatus();
                this.PopulateServices();
                this.PopulateGuardian();
                this.CreateTable();
                this.PopulateSuffix();
                this.PopulateArea();
                this.PopulatePermanentArea();
                this.PopulateClinic();
                this.PopulateReligion();
               // this.getUserImage();
                this.getUsername();
                this.GenerateToken();
                this.PopulateRegisterRelation();
                this.DefaultSelectedValuesDropDown();
                
                btn_Submit.Text = SAVE_BUTTON;
                ddSuffix.Focus();
            }
            ddClinic.SelectedValue = Session["sysClinicSNo"].ToString();
        }


        #region "CREATE-MENU"


        private void CreateMenu()
        {

            // ******************* MENU ************************//
            string userCode;
            SqlConnection conn = new SqlConnection(constr);
            userCode = (Session["User_Code"].ToString());
            SqlDataAdapter da = new SqlDataAdapter("SELECT Menu_Code, MenuText, MenuPath,MenuParent from SEC_Menu where MenuType = 6 AND MenuParent=0", conn);
            DataTable dttc = new DataTable();
            da.Fill(dttc);
            HtmlGenericControl main = UList("main-menu", "main-menu");
            foreach (DataRow row in dttc.Rows)
            {
                da = new SqlDataAdapter("select Menu_Code,MenuText,MenuPath,MenuParent from SEC_Menu where MenuParent=" + row["Menu_Code"].ToString() + " order by ISNULL(sortorder,0)", conn);
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

        #endregion

        #region "LOAD-HEADER-DROPDOWNS"
        private void PopulateReligion()
        {

            oConn = new Connection();
            string _sql= "SELECT sysReligionSno,Religion_Name from HRM_ReligionSetup Order By Religion_Name";
            ddReligion.DataSource = oConn.GetDataTable(_sql);
            ddReligion.DataTextField = "Religion_Name";
            ddReligion.DataValueField = "sysReligionSno";
            ddReligion.DataBind();
            oConn.CloseConnection(); 
        }
        private void PopulateArea()
        {
            oConn = new Connection();
            string _sql = "SELECT Area_Code,Area_Name FROM MED_PatientLocation ORDER BY Area_Name";
            ddlArea.DataSource = oConn.GetDataTable(_sql);
            ddlArea.DataTextField = "Area_Name";
            ddlArea.DataValueField = "Area_Code";
            ddlArea.DataBind();
            //ddReligion.Items.Insert(0, new ListItem("Select Religion", "0"));
            oConn.CloseConnection();
        }
        private void PopulatePermanentArea()
        {
            oConn = new Connection();
            string _sql = "SELECT Area_Code,Area_Name FROM MED_PatientLocation ORDER BY Area_Name";
            ddPermanentArea.DataSource = oConn.GetDataTable(_sql);
            ddPermanentArea.DataTextField = "Area_Name";
            ddPermanentArea.DataValueField = "Area_Code";
            ddPermanentArea.DataBind();
            //ddReligion.Items.Insert(0, new ListItem("Select Religion", "0"));
            oConn.CloseConnection();
        }
        private void PopulateClinic()
        {
            oConn = new Connection();
            string _sql = "Select sysClinicSno,Clinic_Name from MED_ClinicRegistration Order by Clinic_Name";
            ddClinic.DataSource = oConn.GetDataTable(_sql);
            ddClinic.DataTextField = "Clinic_Name";
            ddClinic.DataValueField = "sysClinicSno";
            ddClinic.DataBind();
            oConn.CloseConnection();
            ddClinic.SelectedValue = Session["sysClinicSNo"].ToString();

            // ddClinic.Enabled = false; // For Normal User 


        }
        private void DefaultSelectedValuesDropDown()
        {
            ddRegisterRelation.SelectedValue = "1";
            ddSuffix.SelectedValue = "1";
            ddGurdian.SelectedValue = "1";
            ddlServices.SelectedValue = "4";
            ddReligion.SelectedValue = "1";
            this.ddlServices_SelectedIndexChanged(null, null);
            //lblServiceCharges.Text = "30";
            txtRegisterBy.Text = "Self";
        }
        private void PopulateServices()
        {
            oConn = new Connection();
            string _sql = "Select sysServiceSno,Service_Code,Service_Name from MED_Services Order By Service_Name ASC";
            ddlServices.DataSource = oConn.GetDataTable(_sql);
            ddlServices.DataTextField = "Service_Name";
            ddlServices.DataValueField = "Service_Code";
            ddlServices.DataBind();
            // ddClinic.Items.Insert(0, new ListItem("Select Clinic", "0"));
            oConn.CloseConnection();

        }
        private void PopulateGuardian()
        {
            oConn = new Connection();
            string _sql = "SELECT Code,Name from GEN_ListOfvalues  where class='GUARDIAN' Order By Name";
            ddGurdian.DataSource = oConn.GetDataTable(_sql);
            ddGurdian.DataTextField = "Name";
            ddGurdian.DataValueField = "Code";
            ddGurdian.DataBind();
            // ddClinic.Items.Insert(0, new ListItem("Select Clinic", "0"));
            oConn.CloseConnection();

        }
        private void PopulateSuffix()
        {
            oConn = new Connection();
            string _sql = "SELECT Code,Name from GEN_ListOfvalues  where class='Suffix' Order By Name";
            ddSuffix.DataSource = oConn.GetDataTable(_sql);
            ddSuffix.DataTextField = "Name";
            ddSuffix.DataValueField = "Code";
            ddSuffix.DataBind();
            // ddClinic.Items.Insert(0, new ListItem("Select Clinic", "0"));
            oConn.CloseConnection();
        }
        private void PopulateRegisterRelation()
        {
            oConn = new Connection();
            string _sql = "SELECT Code,Name from GEN_ListOfvalues  where class='Relation' Order By Name";
            ddRegisterRelation.DataSource = oConn.GetDataTable(_sql);
            ddRegisterRelation.DataTextField = "Name";
            ddRegisterRelation.DataValueField = "Code";
            ddRegisterRelation.DataBind();
            // ddClinic.Items.Insert(0, new ListItem("Select Clinic", "0"));
            oConn.CloseConnection();

        }
        protected void ddRegisterRelation_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddRegisterRelation.SelectedValue == "1")
            {
                txtRegisterBy.Text = "Self";
            }
            else
            {
                txtRegisterBy.Text = "";
            }

        }
        private void PopulatePayingStatus()
        {
            oConn = new Connection();
            string _sql = "SELECT Code,Name from GEN_ListOfvalues  where class='PayingStatus' Order By Name";
            ddPatientPayingStatus.DataSource = oConn.GetDataTable(_sql);
            ddPatientPayingStatus.DataTextField = "Name";
            ddPatientPayingStatus.DataValueField = "Code";
            ddPatientPayingStatus.DataBind();
            

        }
        private void getUserImage()
        {
            oConn = new Connection();
            object img;
            img = oConn.GetDataTable("SELECT Employee_Image FROM HRM_EmployeeSetup WHERE sysEmployeeSno =dbo.Func_SEC_UserCode_sysEmployeeSno(" + Session["User_Code"] + ")").Rows[0]["Employee_Image"];
            if (img != DBNull.Value)
            {
                byte[] bytes = (byte[])img;
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                ImgUser.ImageUrl = "data:image/png;base64," + base64String;
            }
        }
        private void getUsername()
        {
            string usercode = Session["User_Code"].ToString();
            oConn = new Connection();
            string _sql = "Select User_Name from SEC_User where User_Code =' " + usercode + " '";
            lblUserName.Text = oConn.ExecuteScalarQuery(_sql);

        }

        #endregion

        //***********************************Basic Button Click Event********************************//
        protected void btn_Submit_Click(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection(constr);
            
        try
        {
            if (btn_Submit.Text == SAVE_BUTTON)
            {
           
                string User_Code;
                User_Code = (Session["User_Code"].ToString());
                string genderPatient = "";
                if (rbnMale.Checked == true)
                {
                    genderPatient = "Male";
                }
                if (rbnFemale.Checked)
                {
                    genderPatient = "Female";
                }
                GenerateMrNo(ddClinic.SelectedValue);
                string iSql;
                iSql = "INSERT INTO MED_PatientRegistration( Suffix,";
                iSql += "  Registration_No,Registration_Date, First_Name,Middle_Name, Last_Name,";
                iSql += "  Father_Name,CNIC_No,Religion_Code,Gender,Age,";
                iSql += "  Maritial_Status,Mobile_1,Mobile_2,Registered_By,Registered_Relation,";
                iSql += "  Registered_ContactNo,Present_Address,Present_Area,Present_City,Present_Country,";
                iSql += "  Present_Province,Permanent_Address,Permanent_City,Permanent_Area,Permanent_Province,";
                iSql += "  Permanent_Country,DOB,sysClinicSno,User_Code, ";

                iSql += "  Phone_Number,Patient_Of,Zakat_Eligble,Age_Months ) ";

                iSql += " VALUES ('" + ddSuffix.SelectedValue + "', ";
                iSql += " '" + lblPatientMrNo.Text + "','" + lblPatientRegistrationDate.Text + "','" + txtFirstName.Text + "','" + txtMiddleName.Text + "','" + txtLastName.Text + "', ";
                iSql += " '" + txtFatherName.Text + "','" + txtCNICNO.Text + "','" + ddReligion.SelectedValue + "','" + genderPatient + "','" + txtAge.Text + "',";
                iSql += " '" + ddMaritialStatus.SelectedValue + "','" + txtMobile1.Text + "','" + txtMobile2.Text + "','" + txtRegisterBy.Text + "','" + ddRegisterRelation.SelectedValue + "',";
                iSql += " '" + txtRegisterByContactNo.Text + "' , '" + txtAddress.Text + "' ,'" + ddlArea.SelectedValue + "','" + ddlCity.SelectedValue + "','" + ddlCountry.SelectedValue + "',";
                iSql += " '" + ddlProvince.SelectedValue + "','" + txtPermanentBlock.Text + "','" + ddlPermanentCity.SelectedValue.ToString() + "','" + ddPermanentArea.SelectedValue + "','" + ddlPermanentProvince.SelectedValue.ToString() + "',";
                iSql += " '" + ddlPermanentCountry.SelectedValue.ToString() + "','" + txtDOB.Text + "','" + ddClinic.SelectedValue.ToString() + "','" + User_Code + "',";
                iSql += " '" + txtContactNo.Text + "','" + ddGurdian.SelectedValue.ToString() + "','" + ddPatientPayingStatus.SelectedValue + "','" + txtAgeMonth.Text + "'); ";
               



                iSql += " INSERT INTO MED_TicketMaster (MR_No,sysClinicSno,Ticket_Date,Ticket_Number,User_Code) ";
                iSql += " VALUES ('" + lblPatientMrNo.Text + "', '" + ddClinic.SelectedValue.ToString() + "', '" + DateTime.Now + "','" + lblPatientToken.Text + "','" + User_Code + "'); ";

                iSql += " SELECT IDENT_CURRENT('MED_TicketMaster')";

                Connection conn = new Connection();
                sysTicketMasterNo = conn.ExecuteScalarQuery(iSql);
               
              
                }
                
          
            else
            {
                string User_Code;
                User_Code = (Session["User_Code"].ToString());
                string sqlQuery;
               
                    string MRNO;
                    MRNO = lblPatientMrNo.Text;
                    con.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE MED_PatientRegistration SET First_Name=@First_Name,Middle_Name=@Middle_Name,Last_Name=@Last_Name,Father_Name=@Father_Name,CNIC_No=@CNIC_No,Permanent_Address=@Permanent_Address,Permanent_Area=@Permanent_Area,Permanent_City=@Permanent_City,Permanent_Province=@Permanent_Province,Permanent_Country=@Permanent_Country,Present_Address=@Present_Address,Present_Area=@Present_Area,Present_City=@Present_City,Present_Country=@Present_Country,Present_Province=@Present_Province,Age=@Age,Maritial_Status=@Maritial_Status,Mobile_1=@Mobile_1,Mobile_2=@Mobile_2,Phone_Number=@Phone_Number,Registered_By=@Registered_By,Registered_Relation=@Registered_Relation,Registered_ContactNo=@Registered_ContactNo,sysClinicSno=@Clinic,User_Code=@User_Code,Zakat_Eligble=@Zakat_Eligble,Age_Months=@Age_Months where sys_PatientSno= @sys_PatientSno", con);
                    cmd.Parameters.AddWithValue("@First_Name", txtFirstName.Text);
                    cmd.Parameters.AddWithValue("@Middle_Name", txtMiddleName.Text);
                    cmd.Parameters.AddWithValue("@Last_Name", txtLastName.Text);
                    cmd.Parameters.AddWithValue("@Father_Name", txtFatherName.Text);
                    cmd.Parameters.AddWithValue("@CNIC_No", txtCNICNO.Text);
                    cmd.Parameters.AddWithValue("@Permanent_Address", txtPermanentBlock.Text);
                    cmd.Parameters.AddWithValue("@Permanent_Area", ddPermanentArea.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@Permanent_City", ddlPermanentCity.SelectedValue);
                    cmd.Parameters.AddWithValue("@Permanent_Province", ddlPermanentProvince.SelectedValue);
                    cmd.Parameters.AddWithValue("@Permanent_Country", ddlPermanentCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@Present_Address", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@Present_Area", ddlArea.SelectedValue);
                    cmd.Parameters.AddWithValue("@Present_City", ddlCity.SelectedValue);
                    cmd.Parameters.AddWithValue("@Present_Country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@Present_Province", ddlProvince.SelectedValue);
                    cmd.Parameters.AddWithValue("@Age", txtAge.Text);
                    cmd.Parameters.AddWithValue("@Maritial_Status", ddMaritialStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@Mobile_1", txtMobile1.Text);
                    cmd.Parameters.AddWithValue("@Mobile_2", txtMobile2.Text);
                    cmd.Parameters.AddWithValue("@Phone_Number", txtContactNo.Text);
                    cmd.Parameters.AddWithValue("@Registered_By", txtRegisterBy.Text);
                    cmd.Parameters.AddWithValue("@Registered_Relation", ddRegisterRelation.SelectedValue);
                    cmd.Parameters.AddWithValue("@Registered_ContactNo", txtRegisterByContactNo.Text);
                    cmd.Parameters.AddWithValue("@Clinic", ddClinic.SelectedValue);
                    cmd.Parameters.AddWithValue("@User_Code", User_Code);
                    cmd.Parameters.AddWithValue("@Mrno", lblPatientMrNo.Text);
                    cmd.Parameters.AddWithValue("@sys_PatientSno", lblSrNo.Text);
                    cmd.Parameters.AddWithValue("@Zakat_Eligble", ddPatientPayingStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@Age_Months", txtAgeMonth.Text);
                    cmd.ExecuteNonQuery();
                    ShowMessage("Patient Updated");
                   Session["SESSION_MRNO"] = lblPatientMrNo.Text;
                   // string ticketNumber;
                   sysTicketMasterNo = lblTicketNo.Text;
                   Session["SESSION_TICKETNO"] = sysTicketMasterNo;
                    this.EnableDisable(true); // Enabling after Updating Record 
                  //  ShowPrintMessage();

                    //        //**************************** Popluate Gridview*************************************************//

                    
            }


            //==================== ADDING SERVICES DETAIL TO SERVICE DETAIL TABLE ======================

            string _Select;
            if (btn_Submit.Text == SAVE_BUTTON){
                _Select = " SELECT sysTicketMasterNo,Service_Code,Service_DetailNo,Charges from MED_TicketDetail Where sysTicketDetailNo is Null ";
            }
            else {
                _Select = " SELECT sysTicketDetailNo,sysTicketMasterNo,Service_Code,Service_DetailNo,Charges from MED_TicketDetail Where sysTicketMasterNo = '" + sysTicketMasterNo.ToString() + "' ";
                this.GetPatient(lblSrNo.Text);
             
               
            }

            
            d_Adapter = new SqlDataAdapter(_Select.ToString(), con);
            c_Builder = new SqlCommandBuilder(d_Adapter);
            T_Detail = new DataTable();
            d_Adapter.FillSchema(T_Detail, SchemaType.Source);
            d_Adapter.Fill(T_Detail);


            int i = 0;

            foreach (GridViewRow l_dgRow in gvServiceDetail.Rows)
            {
                string _sysTicketDetailNo = gvServiceDetail.Rows[i].Cells[0].Text.Replace("&nbsp;", "0").ToString();
                string _ServiceCode = gvServiceDetail.Rows[i].Cells[1].Text.Replace("&nbsp;", "0").ToString();
                string _ServiceDetailCode = gvServiceDetail.Rows[i].Cells[2].Text.Replace("&nbsp;", "0").ToString();
                string _Charges = gvServiceDetail.Rows[i].Cells[5].Text.Replace("&nbsp;", "0").ToString();
                if (btn_Submit.Text == SAVE_BUTTON)
                {
                    T_Detail.LoadDataRow(new object[] { sysTicketMasterNo.ToString(), _ServiceCode, _ServiceDetailCode, _Charges }, LoadOption.Upsert);
                }
                else {
                    T_Detail.LoadDataRow(new object[] { _sysTicketDetailNo, sysTicketMasterNo.ToString(), _ServiceCode, _ServiceDetailCode, _Charges }, LoadOption.Upsert);
                  
                }
                
                i = i + 1;

            }


            if (btn_Submit.Text == SAVE_BUTTON)
            {
            }
            else {
                btn_Submit.Text = SAVE_BUTTON;
            }
          //  con.Open();
            d_Adapter.Update(this.T_Detail);
            con.Close();
            this.T_Detail.AcceptChanges();
            //==========================================================================================
            //iSql = " INSERT INTO MED_TicketDetail (sysTicketMasterNo,Service_Code,Service_DetailNo,Charges) ";
            //iSql += " VALUES ('" + sysTicketMasterNo + "', '" + ddlServices.SelectedValue.ToString() + "', '" + ddServicesDetail.SelectedValue.ToString() + "', '" + lblServiceCharges.Text + "') ";

            // Below lines                 
            //SqlCommand cmd = new SqlCommand(iSql, con);
            //cmd.CommandType = CommandType.Text;
            //con.Open();
            //cmd.ExecuteNonQuery();
            Literal1.Text = "Data Inserted Succesfully";
            con.Close();
            string MR_NO;
            MR_NO = lblPatientMrNo.Text;
            
            Session["SESSION_MRNO"] = lblPatientMrNo.Text;
            Session["SESSION_TICKETNO"] = sysTicketMasterNo;
            ShowPrintMessage();
            this.clear();
         
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
        protected void btn_Cancel_Click(object sender, EventArgs e)
        {
            clear();
        }
        public void ShowPrintMessage()
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "Confirm();", true);
        }

        //*********************************** Detail Grid Function/Events ********************************//
        private void CreateTable()
        {

            T_Detail.Columns.Add("sysTicketDetailNo", typeof(string));
            T_Detail.Columns.Add("Service_Code", typeof(string));
            T_Detail.Columns.Add("Service_Name", typeof(string));
            T_Detail.Columns.Add("Service_DetailNo", typeof(string));
            T_Detail.Columns.Add("Service_DetailName", typeof(string));
            T_Detail.Columns.Add("Charges", typeof(string));


            gvServiceDetail.DataSource = T_Detail;
            ViewState.Add("T_Detail", T_Detail);
            gvServiceDetail.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {

            T_Detail = (DataTable)ViewState["T_Detail"];
            I_Count = Convert.ToInt32(ViewState["I_COUNT"]) + 1;
            Int16 i = default(Int16);
            T_Detail.Rows.InsertAt(AddRow(I_Count.ToString(), ddlServices.SelectedValue.ToString(), ddlServices.SelectedItem.Text.ToString(), ddServicesDetail.SelectedValue.ToString(), ddServicesDetail.SelectedItem.Text.ToString(), lblServiceCharges.Text), gvServiceDetail.Rows.Count + 1);
            ViewState["I_COUNT"] = Convert.ToInt16(I_Count + i).ToString();
            this.ReFreshGrid();

        }
        private void ReFreshGrid()
        {
            T_Detail = (DataTable)ViewState["T_Detail"];
            gvServiceDetail.DataSource = T_Detail;
            gvServiceDetail.DataBind();
            ViewState.Add("T_Detail", T_Detail);
        }
        private DataRow AddRow(string sysTicketDetailNo, string Service_Code, string Service_Name, string Service_DetailNo, string Service_DetailName, string Charges)
        {
            DataRow R_Row = default(DataRow);
            R_Row = this.T_Detail.NewRow();
            R_Row["sysTicketDetailNo"] = sysTicketDetailNo;
            R_Row["Service_Code"] = Service_Code;
            R_Row["Service_Name"] = Service_Name;
            R_Row["Service_DetailNo"] = Service_DetailNo;
            R_Row["Service_DetailName"] = Service_DetailName;
            R_Row["Charges"] = Charges;
            return R_Row;
        }
        protected void gvServiceDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string User_Code;
            User_Code = (Session["User_Code"].ToString());
            string sqlQuery;
            
            T_Detail = (DataTable)ViewState["T_Detail"];
            T_Detail.Rows[e.RowIndex].Delete();
     
            //else  popup you want to del this recd.  Sql="delete from MED_serviceDetail Where sysServiceDetailNo=";
            // 
            if (!(btn_Submit.Text == SAVE_BUTTON)){
                sqlQuery = " Delete FROM MED_TicketDetail WHERE sysTicketDetailNo='" + gvServiceDetail.Rows[e.RowIndex].Cells[0].Text + "'";
                Connection Connection = new Connection();
                Connection.ExecuteQuery(sqlQuery);


            }
            this.ReFreshGrid();

        }
        protected void gvServiceDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                viewCount += Convert.ToDouble((DataBinder.Eval(e.Row.DataItem, "Charges").Equals(DBNull.Value) ? 0 : DataBinder.Eval(e.Row.DataItem, "Charges")));
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                this.ViewState["viewCountSum"] = viewCount;
                e.Row.Cells[5].Text = this.ViewState["viewCountSum"].ToString() + "/-";
                e.Row.Cells[4].Text = "Total Rs.";
            }
        }
        protected void ddServicesDetail_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            ddServicesDetail.AppendDataBoundItems = true;
            string strQuery = "Select sysServiceDetailSno,Service_Code,Service_DetailNo,Service_DetailName,isNull(Charges,0) Charges from MED_ServicesDetail where Service_DetailNo =@Service_Code ORDER BY Service_DetailName ASC";
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Service_Code", ddServicesDetail.SelectedValue);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            da.Fill(dt);
            try
            {
                con.Open();
                SqlDataReader SqlReader;
                SqlReader = cmd.ExecuteReader();

                if (!(ddPatientPayingStatus.SelectedItem.Value.Equals("1")))
                {
                    lblServiceCharges.Text = dt.Rows[0]["Charges"].ToString();
                }
                else
                {
                    SetPatientSupportFee();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        protected void ddlServices_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            ddServicesDetail.Items.Clear();
            DataTable dt = new DataTable();
            //ddServicesDetail.Items.Add(new ListItem("--Select Service Detail ---"));
            ddServicesDetail.AppendDataBoundItems = true;
            string strQuery = "Select sysServiceDetailSno,Service_Code,Service_DetailNo,Service_DetailName,Charges from MED_ServicesDetail where Service_Code =@Service_Code ORDER BY Service_DetailName ASC ";
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Service_Code", ddlServices.SelectedItem.Value);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            da.Fill(dt);
            if (dt.Rows.Count.Equals(0)) return ;
            try
            {
                con.Open();
                SqlDataReader SqlReader;
                SqlReader = cmd.ExecuteReader();
                ddServicesDetail.DataSource = SqlReader;
                ddServicesDetail.DataTextField = "Service_DetailName";
                ddServicesDetail.DataValueField = "Service_DetailNo";
                ddServicesDetail.DataBind();
                if (!(ddPatientPayingStatus.SelectedItem.Value.Equals("1")))
                {
                    lblServiceCharges.Text = dt.Rows[0]["Charges"].ToString();
                }
                else
                {
                    SetPatientSupportFee();
                }
              

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        private void SetPatientSupportFee()
        {
            if (ddPatientPayingStatus.SelectedItem.Value.Equals("1"))
            {
                lblServiceCharges.Text = "0";
            }
            else {
                this.ddServicesDetail_SelectedIndexChanged(null, null); 
            
            }
        }

        protected void ddServices_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {


                SqlConnection con = new SqlConnection(constr);
                ddServicesDetail.Items.Clear();
                DataTable dt = new DataTable();
                //ddServicesDetail.Items.Add(new ListItem("--Select Service Detail ---"));
                ddServicesDetail.AppendDataBoundItems = true;
                string strQuery = "SELECT sysServiceDetailSno,Service_Code,Service_DetailNo,Service_DetailName,Charges from MED_ServicesDetail where Service_Code =@Service_Code";
                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@Service_Code", ddlServices.SelectedItem.Value);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strQuery;
                cmd.Connection = con;

                da.Fill(dt);
                if (dt.Rows.Count.Equals(0)) return;
                con.Open();
                SqlDataReader SqlReader;
                SqlReader = cmd.ExecuteReader();
                ddServicesDetail.DataSource = SqlReader;
                // lstServicesDetail.DataSource = SqlReader;
                ddServicesDetail.DataTextField = "Service_DetailName";
                //  lstServicesDetail.DataTextField = "Service_DetailName";
                ddServicesDetail.DataValueField = "Service_DetailNo";
                //  lstServicesDetail.DataValueField = "Service_DetailName";
                ddServicesDetail.DataBind();
                //  lstServicesDetail.DataBind();
                if (ddPatientPayingStatus.SelectedValue == "2")
                {
                    lblServiceCharges.Text = "0";
                }
                else
                {
                    lblServiceCharges.Text = dt.Rows[0]["Charges"].ToString();
                }
                if (ddServicesDetail.Items.Count > 1)
                {
                    ddServicesDetail.Enabled = true;
                }
                else
                {
                    ddServicesDetail.Enabled = true;
                }


            }


            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

      
        //***********************************Search Button Click Event********************************//
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            // Search Patient 
            GetPatient(txtPatientSearch.Text);

        }
        private void GetPatient(string patientName)
        {
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("MED_GetPatientRegistration", con);
                cmd.CommandType = CommandType.StoredProcedure;
                if (!string.IsNullOrEmpty(patientName))
                {
                    SqlParameter parameter = new SqlParameter("@SearchString", patientName);
                    cmd.Parameters.Add(parameter);
                }
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                gvPatients.DataSource = rdr;
                gvPatients.DataBind();

            }
        }
        //*********************************Click Patient Grid (Select patient) ***************************//
        protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)
        {


            Connection Conn = new Connection();
            DataTable DT = new DataTable();
            DT = Conn.GetDataTable("EXECUTE [MED_GetPatientDetail]  ' AND Registration_No =''" + gvPatients.SelectedRow.Cells[1].Text + "'' ' ");
            clear();
            lblPatientMrNo.Text = DT.Rows[0]["Registration_No"].ToString();
            lblPatientRegistrationDate.Text = DT.Rows[0]["Registration_Date"].ToString();
            txtFirstName.Text = DT.Rows[0]["First_Name"].ToString();
            txtFatherName.Text = DT.Rows[0]["Father_Name"].ToString();
            txtCNICNO.Text = DT.Rows[0]["CNIC_No"].ToString();
            txtAge.Text = DT.Rows[0]["Age"].ToString();
            txtMobile1.Text = DT.Rows[0]["Mobile_1"].ToString();
            txtRegisterBy.Text = DT.Rows[0]["Registered_By"].ToString();
            txtRegisterByContactNo.Text = DT.Rows[0]["Registered_ContactNo"].ToString();
            ddReligion.SelectedValue = DT.Rows[0]["Religion_Code"].ToString();

            lblTicketNo.Text = DT.Rows[0]["sysTicketMasterNo"].ToString();



            if (DT.Rows[0]["Gender"].ToString() == "Male")
            {
                rbnMale.Checked = true;
                rbnFemale.Checked = false;
            }
            else if (DT.Rows[0]["Gender"].ToString() == "Female")
            {
                rbnFemale.Checked = true;
                rbnMale.Checked = false;
            }

            ddMaritialStatus.SelectedValue = DT.Rows[0]["Maritial_Status"].ToString();
            txtMobile2.Text = DT.Rows[0]["Mobile_2"].ToString();
            txtContactNo.Text = DT.Rows[0]["Phone_Number"].ToString();
            ddRegisterRelation.SelectedValue = DT.Rows[0]["Registered_Relation"].ToString();
            txtRegisterByContactNo.Text = DT.Rows[0]["Registered_ContactNo"].ToString();
            txtMiddleName.Text = DT.Rows[0]["Middle_Name"].ToString();
            txtLastName.Text = DT.Rows[0]["Last_Name"].ToString();
            ddPermanentArea.SelectedValue = DT.Rows[0]["Permanent_Area"].ToString();
            txtPermanentBlock.Text = DT.Rows[0]["Permanent_Address"].ToString();
            ddlPermanentCity.SelectedValue = DT.Rows[0]["Permanent_City"].ToString();
            ddlPermanentCountry.SelectedValue = DT.Rows[0]["Permanent_Country"].ToString();
            txtAddress.Text = DT.Rows[0]["Present_Address"].ToString();
            ddlArea.SelectedValue = DT.Rows[0]["Present_Area"].ToString();
            ddlCity.SelectedValue = DT.Rows[0]["Present_City"].ToString();
            ddlCountry.SelectedValue = DT.Rows[0]["Present_Country"].ToString();
            ddlProvince.SelectedValue = DT.Rows[0]["Present_Province"].ToString();
            ddlPermanentProvince.SelectedValue = DT.Rows[0]["Permanent_Province"].ToString();
            lblSrNo.Text = DT.Rows[0]["sys_PatientSno"].ToString();
            lblServiceCharges.Text = DT.Rows[0]["Charges"].ToString();
            // ddlServices.SelectedValue = DT.Rows[0]["Service_Code"].ToString();
            //  this.ddlServices_SelectedIndexChanged(null, null);
            // ddServicesDetail.SelectedValue = DT.Rows[0]["Service_DetailNo"].ToString();
            // txtDOB.Text = DT.Rows[0]["DOB"].ToString();
            ddSuffix.SelectedValue = DT.Rows[0]["Suffix"].ToString();
            ddGurdian.SelectedValue = DT.Rows[0]["Patient_Of"].ToString();
            lblPatientToken.Text = DT.Rows[0]["Ticket_Number"].ToString();
            ddPatientPayingStatus.SelectedValue = DT.Rows[0]["Zakat_Eligble"].ToString();
            txtAgeMonth.Text = DT.Rows[0]["Age_Months"].ToString();

            // Populating Services Detail 
            this.GetTicketDetail(DT.Rows[0]["sysTicketMasterNo"].ToString());
            lblstn.Text = DT.Rows[0]["sysTicketMasterNo"].ToString();
            btn_Submit.Text = "Update Patient";
            this.EnableDisable(true);
        }
        private void GetTicketDetail(string sysTicketMasterNo)
        {
            Connection con = new Connection();
            //DataTable DT = new DataTable();
            //T_Detail = con.GetDataTable("EXECUTE [MED_GetPatientDetailByTicketNo]  '" + sysTicketMasterNo + "'  ");

            string _sql = " SELECT sysTicketDetailNo,Service_Code,Service_DetailNo,dbo.func_MED_ServiceCode_ServiceName(Service_Code) Service_Name,dbo.Func_MED_ServiceDetailCode_ServiceDetailName(Service_DetailNo) Service_DetailName,Charges ";
            _sql += " FROM MED_TicketDetail Where sysTicketMasterNo =  '" + sysTicketMasterNo + "' ";

            T_Detail = con.GetDataTable(_sql);
            ViewState.Add("T_Detail", T_Detail);
            this.ReFreshGrid();

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
        //*****************************Custom Function *******************************//
        private void EnableDisable(Boolean Value)
        {
            // No Edit in TicketMaster/Detail 
            ddlServices.Enabled = Value;
            ddServicesDetail.Enabled = Value;
            ddPatientPayingStatus.Enabled = Value;
        }
        public void ShowMessage(string msg)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script  language='javascript'>alert('" + msg + "');</script>");
        }
        private void GenerateToken()
        {
            string sql;
            //sql = "SELECT Right('0000' + CAST(isNull(Count(*),0)+1 AS  VARCHAR(10)),5) AS TokenNumber from MED_PatientRegistration ";
            //sql += " WHERE CAST(Created_Date as date) = CAST(getdate() as date)";
            //sql += " AND sysClinicSNo='"+ ddClinic.SelectedValue.ToString()   +"' ";

            sql = "SELECT Right('000' + CAST(isNull(MAX(Ticket_Number),0)+1 AS  VARCHAR(10)),4) AS TokenNumber from MED_TicketMaster	  ";
            sql += " WHERE CAST(Ticket_Date as date) = CAST(GETDATE() as date) ";
            sql += " AND sysClinicSNo='" + ddClinic.SelectedValue.ToString() + "' ";


            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(sql))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            lblPatientToken.Text = dt.Rows[0]["TokenNumber"].ToString();

                        }
                    }
                }
            }
        }
        private void GenerateMrNo(string clinicNo)
        {
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter sda = new SqlDataAdapter();
                SqlCommand cmd = new SqlCommand("MED_GetMRNumberByClinic", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter parameter = new SqlParameter("@sysCliniceSNo", clinicNo);
                cmd.Parameters.Add(parameter);
                con.Open();

                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    lblPatientMrNo.Text = rdr["MR_No"].ToString();
                }
            }
        }
        public void clear()
        {
            lblPatientMrNo.Text = string.Empty;
            lblPatientRegistrationDate.Text = string.Empty;
            txtFirstName.Text = string.Empty;
            txtFatherName.Text = string.Empty;
            txtCNICNO.Text = string.Empty;
            txtAge.Text = string.Empty;
            txtMobile1.Text = string.Empty;
            txtRegisterBy.Text = string.Empty;
            txtRegisterByContactNo.Text = string.Empty;
            txtMobile2.Text = string.Empty;
            txtContactNo.Text = string.Empty;
            txtRegisterByContactNo.Text = string.Empty;
            txtMiddleName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            ddPermanentArea.SelectedIndex = 0;
            txtPermanentBlock.Text = string.Empty;
            lblServiceCharges.Text = string.Empty;
            txtAddress.Text = string.Empty;
            btn_Submit.Text = SAVE_BUTTON;

        }
        //*****************************Events Function *******************************//
        protected void ddClinic_SelectedIndexChanged(object sender, EventArgs e)
        {
            GenerateToken();
        }

        protected void ddPatientPayingStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.SetPatientSupportFee();

        }
        //*****************************End Events Function *******************************//
    }
}
