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
    public partial class Service : System.Web.UI.Page
    {
        SqlCommandBuilder c_Builder = default(SqlCommandBuilder);
        SqlDataAdapter d_Adapter = default(SqlDataAdapter);
        double viewCountSum = 0;
        double viewCount = 0;
        DataTable T_Detail = new DataTable();
        int I_Count;
        string SAVE_BUTTON = "Generate Token";
        Connection oConnection = new Connection();
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
        // string conn = System.Configuration.ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
       // SqlConnection con = new SqlConnection("Data Source=Server-DB;Initial Catalog=KT;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            
            this.LoadMenu();
            DateTime localDate = DateTime.Now;
            this.EnableControl();
            if (!IsPostBack)
            {
                this.CreateTable(); // Grid Temp Table
                this.PopulateServices();
                this.PopulateClinic();
                this.getUserImage();
                this.getUsername();
                this.GenerateToken();
                this.GetPatientServices();
                // PopulateReligion();
                ServiceAdded.Visible = false;
                btn_Submit.Text = SAVE_BUTTON;
                btnAdd.Enabled = false;
                
            }
            

        }
        #region LOAD MENU
        private void LoadMenu()
        {
            SqlConnection con = new SqlConnection(constr);
            string userCode;
            userCode = (Session["User_Code"].ToString());
            SqlDataAdapter da = new SqlDataAdapter("Select Menu_Code, MenuText, MenuPath,MenuParent from SEC_Menu where MenuType = 6 AND MenuParent=0", con);
            //  SqlDataAdapter da = new SqlDataAdapter("SEC_GetUserMenu 8,4", con);
            DataTable dttc = new DataTable();
            da.Fill(dttc);
            HtmlGenericControl main = UList("main-menu", "main-menu");
            foreach (DataRow row in dttc.Rows)
            {
                da = new SqlDataAdapter("select Menu_Code,MenuText,MenuPath,MenuParent from SEC_Menu where MenuParent=" + row["Menu_Code"].ToString() + " order by ISNULL(sortorder,0)", con);
                // da = new SqlDataAdapter("SELECT  Case MP.Menu_Code WHEN 0 THEN NULL ELSE MP.Menu_Code END AS ParentCode , MP.MenuText AS ParentMenu , M.MenuText , M.Menu_Code , M.MenuType, M.MenuPath, M.MenuDirPath FROM SEC_Menu M INNER JOIN SEC_RoleDetail RD ON RD.Menu_Code = M.Menu_Code INNER JOIN SEC_Role R ON RD.Role_Code = R.Role_Code INNER JOIN SEC_GroupDetail GD ON GD.Role_Code = RD.Role_Code INNER JOIN SEC_Group G ON GD.Group_Code = G.Group_Code INNER JOIN SEC_User U ON U.Group_Code = G.Group_Code INNER JOIN SEC_Menu MP ON MP.Menu_Code = M.MenuParent  WHERE 	U.User_Code  = '8' AND M.Menu_Code NOT IN (SELECT Menu_Code FROM SEC_UserRights WHERE User_Code  = '8')and M.MenuType='4' and MP.Menu_Code <>0 UNION SELECT   Case MP.Menu_Code WHEN 0 THEN NULL ELSE MP.Menu_Code END AS ParentCode , MP.MenuText AS ParentMenu , M.MenuText , M.Menu_Code ,M.MenuType    , M.MenuPath, M.MenuDirPath FROM SEC_Menu M  INNER JOIN SEC_UserRights UR ON UR.Menu_Code = M.Menu_Code INNER JOIN SEC_Menu MP ON MP.Menu_Code = M.MenuParent WHERE User_Code  = '8'and M.MenuType='4' and m.Menu_Code <>0", con);
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
        

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            string User_Code;
            User_Code = (Session["User_Code"].ToString());
            string sqlQuery;
            string sysTicketMasterNo;
            try
            {

                if (!btn_Submit.Text.Equals("Update Token"))
                {

                    this.GenerateToken();
                    sqlQuery = "INSERT INTO MED_TicketMaster (MR_No,sysClinicSno,Ticket_Date,User_Code,Created_Date,Ticket_Number)";
                    sqlQuery += " VALUES ('" + lblPatientMrNo.Text + "', '" + ddClinic.SelectedValue.ToString() + "', '" + DateTime.Now + "', '" + User_Code.ToString() + "', '" + DateTime.Now + "','" + lblPatientToken.Text + "') ";
                    sqlQuery += " SELECT IDENT_CURRENT('MED_TicketMaster')";
                    Connection Connection = new Connection();
                    sysTicketMasterNo = Connection.ExecuteScalarQuery(sqlQuery);
                }
                else {
                    

                     sysTicketMasterNo = Convert.ToString(ViewState["sysTicketMasterNo"]) ;
                     sqlQuery = " Delete FROM MED_TicketDetail WHERE sysTicketMasterNo='" + sysTicketMasterNo + "'";
                     Connection Connection = new Connection();
                     Connection.ExecuteQuery (sqlQuery);
               
                }
                string _Select;
                _Select = " SELECT sysTicketMasterNo,Service_Code,Service_DetailNo,Charges from MED_TicketDetail Where sysTicketDetailNo is Null ";

                d_Adapter = new SqlDataAdapter(_Select.ToString(), con );
                c_Builder = new SqlCommandBuilder(d_Adapter);
                T_Detail = new DataTable();
                d_Adapter.FillSchema(T_Detail, SchemaType.Source);
                d_Adapter.Fill(T_Detail);

                
            int i = 0;

            foreach (GridViewRow l_dgRow in gvServiceDetail.Rows)
            {

                string _ServiceCode = gvServiceDetail.Rows[i].Cells[1].Text.Replace("&nbsp;", "0").ToString();
                string _ServiceDetailCode = gvServiceDetail.Rows[i].Cells[2].Text.Replace("&nbsp;", "0").ToString();
                string _Charges = gvServiceDetail.Rows[i].Cells[5].Text.Replace("&nbsp;", "0").ToString();

                T_Detail.LoadDataRow(new object[] { sysTicketMasterNo, _ServiceCode, _ServiceDetailCode, _Charges }, LoadOption.Upsert);
                i = i + 1;

            }

                con.Open();
                d_Adapter.Update(this.T_Detail);
                con.Close();
                this.T_Detail.AcceptChanges();

                this.GenerateToken();

                Literal1.Text = "Data Inserted Succesfully";
                if (chkPrint.Checked) {
                    this.PrintReport();
                }
                Session["SESSION_MRNO"] = lblPatientMrNo.Text;
                Session["SESSION_TICKETNO"] = sysTicketMasterNo;
                ShowPrintMessage();
                
            }
            catch (Exception ex)
            {
                Literal1.Text = ex.Message;
            }
        }
        private void ServicePanelShowHide()
        {
            if(lblPatientMrNo.Text == "")
            {
                ServiceAdded.Visible = false;
            }
            else
            {
                ServiceAdded.Visible = true;
            }
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

            // ddClinic.Enabled = false; // For Normal User 


        }
        public void ShowPrintMessage()
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "Confirm();", true);
        }
        private void PopulateServices()
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("Select sysServiceSno,Service_Code,Service_Name from MED_Services", con);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            ddlServices.DataSource = cmd.ExecuteReader();
            ddlServices.DataTextField = "Service_Name";
            ddlServices.DataValueField = "Service_Code";
            ddlServices.DataBind();
            con.Close();

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
        private void GetPatientServices()
        {
            DataTable dt = new DataTable();
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("MED_GetPatientServices", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                da.Fill(dt);
                SqlDataReader rdr = cmd.ExecuteReader();
                gvPatientService.DataSource = rdr;
                gvPatientService.DataBind();


            }
        }
        protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.SetPatientDetail(gvPatients.SelectedRow.Cells[1].Text);
           // ViewState["T_Detail"] = T_Detail;
           // ReFreshGrid();
            btn_Submit.Text = "Generate Token";
        }

        private void SetPatientDetail(string MRNO) {
            Connection con = new Connection();
            DataTable DT = new DataTable();
            DT = con.GetDataTable("EXECUTE [MED_GetPatientDetail]  ' AND Registration_No =''" + MRNO + "'' ' ");
            clear();
            lblPatientMrNo.Text = DT.Rows[0]["Registration_No"].ToString();
            lblPatientRegistrationDate.Text = DT.Rows[0]["Registration_Date"].ToString();
            lblPatientFirstName.Text = DT.Rows[0]["First_Name"].ToString();
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
            lblPatientReligion.Text = ReligionStatus;
           // lblPatientMiddleName.Text = DT.Rows[0]["Middle_Name"].ToString();
          //  lblPatientLastName.Text = DT.Rows[0]["Last_Name"].ToString();
            lblPatientToken.Text = DT.Rows[0]["Ticket_Number"].ToString();
            // lblSrNo.Text = gvPatients.SelectedRow.Cells[32].Text;
            ServiceAdded.Visible = true;


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

      
        public void ShowMessage(string msg)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script  language='javascript'>alert('" + msg + "');</script>");
        }

        protected void btn_Cancel_Click(object sender, EventArgs e)
        {
          
            clear();
        }

        private void PrintReport()
        {
            Response.Write("<script>window.open('receipt.aspx');</script>"); 
        }

        public void clear()
        {
            lblPatientMrNo.Text = string.Empty;
            lblPatientRegistrationDate.Text = string.Empty;
            lblPatientFirstName.Text = string.Empty;
            lblPatientFatherName.Text = string.Empty;
            lblPatientReligion.Text = string.Empty;
            lblPatientGender.Text = string.Empty;
            lblPatientAge.Text = string.Empty;
            lblPatientToken.Text = string.Empty;
            lblPatientMaritialStatus.Text = string.Empty;
        }

        protected void ddlServices_SelectedIndexChanged(object sender, EventArgs e)
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
                    lblPatientServiceCharges.Text = dt.Rows[0]["Charges"].ToString();


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
        private void GenerateToken()
        {
            string sql;
            sql = "SELECT Right('000' + CAST(isNull(Count(Ticket_Number),0)+1 AS  VARCHAR(10)),5) AS Ticket_Number from MED_TicketMaster  ";
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
                            lblPatientToken.Text = dt.Rows[0]["Ticket_Number"].ToString();

                        }
                    }
                }
            }
        }
        private void CreateTable(){

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

            T_Detail.Rows.InsertAt(AddRow(I_Count.ToString(), ddlServices.SelectedValue.ToString(), ddlServices.SelectedItem.Text.ToString() , ddServicesDetail.SelectedValue.ToString(), ddServicesDetail.SelectedItem.Text.ToString(), lblPatientServiceCharges.Text), gvServiceDetail.Rows.Count + 1);
            ViewState["I_COUNT"] = Convert.ToInt16(I_Count + i).ToString();
            this.ReFreshGrid();
        
        }
        private void ReFreshGrid() {

            gvServiceDetail.DataSource = T_Detail;
            gvServiceDetail.DataBind();
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
            T_Detail = (DataTable)ViewState["T_Detail"];
            T_Detail.Rows[e.RowIndex].Delete();
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
        
        //Charges TextBox Rate Populate
        protected void ddServicesDetail_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            ddServicesDetail.AppendDataBoundItems = true;
            string strQuery = "Select sysServiceDetailSno,Service_Code,Service_DetailNo,Service_DetailName,isNull(Charges,0) Charges from MED_ServicesDetail where Service_DetailNo =@Service_Code";
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
                lblPatientServiceCharges.Text = dt.Rows[0]["Charges"].ToString();

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

        protected void gvPatientService_SelectedIndexChanged(object sender, EventArgs e)
        {
            // populate Patient Tab Only 
            this.SetPatientDetail(gvPatientService.SelectedRow.Cells[1].Text);
            // populate ticket detail for patient
            this.GetTicketDetail(gvPatientService.SelectedRow.Cells[2].Text);
            // setting Status For Update
            btn_Submit.Text = "Update Token";
            ViewState.Add("sysTicketMasterNo", gvPatientService.SelectedRow.Cells[2].Text);

        }
        private void GetTicketDetail(string sysTicketMasterNo)
        {
            Connection con = new Connection();
            //DataTable DT = new DataTable();
            T_Detail = con.GetDataTable("EXECUTE [MED_GetPatientDetailByTicketNo]  '" + sysTicketMasterNo + "'  ");
            this.ReFreshGrid();
            ViewState.Add("T_Detail", T_Detail);
        
        }
     private void EnableControl()
        {
         if(ddlServices.SelectedItem.ToString() != "Select Services")
         {
             btnAdd.Enabled = true;
         }
         else
         {
             btnAdd.Enabled = false;
             
         }
        }


    }
}