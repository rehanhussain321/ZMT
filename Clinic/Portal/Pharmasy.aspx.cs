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
    public partial class Pharmasy : System.Web.UI.Page
    {
        SqlCommandBuilder c_Builder = default(SqlCommandBuilder);
        SqlDataAdapter d_Adapter = default(SqlDataAdapter);
        double viewCountSum = 0;
        double viewCount = 0;
        DataTable T_Detail = new DataTable();
        int I_Count;
        string SAVE_BUTTON = "Save Pharmacy";
        Connection oConnection = new Connection();
        ConNew oConn = new ConNew();
        string constr = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
      

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
        protected void Page_Load(object sender, EventArgs e)
        {
            this.LoadMenu();
            DateTime localDate = DateTime.Now;
            // this.EnableControl();
            if (!IsPostBack)
            {
                this.CreateTable(); // Grid Temp Table
                this.PopulateMedicine();
                this.PopulateClinic();
                this.PopulateUnit();
                // this.getUserImage();
                //this.getUsername();
                // this.GenerateToken();
                this.GetPatientServices();
                // PopulateReligion();
                //  ServiceAdded.Visible = false;
                btn_Submit.Text = SAVE_BUTTON;
                //  btnAdd.Enabled = false;

            }
        }
        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(constr);
                string sysIssueMasterNo;
                con.Open();
                if (!btn_Submit.Text.Equals("Update Pharmacy"))
                {
                    string User_Code;
                    User_Code = (Session["User_Code"].ToString());
                    string sqlQuery;
                    sqlQuery = "MED_AddItemIssueMaster";
                    SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Reference_No", lblsysTicketMasterNo.Text.ToString());
                    cmd.Parameters.AddWithValue("@Main_Dept_Code", lblDeptCode.Text.ToString());
                    cmd.Parameters.AddWithValue("@sysGodownLocation_Code", lblLocationCode.Text.ToString());
                    cmd.Parameters.AddWithValue("@sysClinicSNo", ddClinic.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@User_Code", User_Code);
                    sysIssueMasterNo = cmd.ExecuteScalar().ToString();
                }
                else {
                    sysIssueMasterNo = lblHide.Text;
                }

            //Literal1.Text = "Data Inserted Succesfully";
            
            string _Select;
            if (!btn_Submit.Text.Equals("Update Pharmacy"))
            {
                _Select = " SELECT sysIssueMasterNo,sysItemCodeSno,Item_Location_Code,Sub_Dept_Code,Description,Quantity_Required,Quantity_Issued,Unit_Code,Machine_Code,Replacement_Required		From STR_IssueDetail  Where sysIssueDetailNo is Null ";
            }
            else {
                _Select = " SELECT sysIssueDetailNo,sysIssueMasterNo,sysItemCodeSno,Item_Location_Code,Sub_Dept_Code,Description,Quantity_Required,Quantity_Issued,Unit_Code,Machine_Code,Replacement_Required		From STR_IssueDetail  Where sysIssueMasterNo='" + lblHide.Text + "' ";
            }

            d_Adapter = new SqlDataAdapter(_Select.ToString(), con);
            c_Builder = new SqlCommandBuilder(d_Adapter);
            T_Detail = new DataTable();
            d_Adapter.FillSchema(T_Detail, SchemaType.Source);
            d_Adapter.Fill(T_Detail);


            int i = 0;

            foreach (GridViewRow l_dgRow in gvServiceDetail.Rows)
            {
                string sysIssueDetailNo = gvServiceDetail.Rows[i].Cells[0].Text.Replace("&nbsp;", "0").ToString();
                string _sysItemCodeSno = gvServiceDetail.Rows[i].Cells[7].Text.Replace("&nbsp;", "0").ToString();
                string _ItemLocationCode = "1";
                string _SubDeptCode = "1";
                string _Description = gvServiceDetail.Rows[i].Cells[3].Text.Replace("&nbsp;", "0").ToString();
                string _QuantityRequired = gvServiceDetail.Rows[i].Cells[4].Text.Replace("&nbsp;", "0").ToString();
                string _QuantityIssued = gvServiceDetail.Rows[i].Cells[4].Text.Replace("&nbsp;", "0").ToString();
                string _UnitCode = gvServiceDetail.Rows[i].Cells[1].Text.Replace("&nbsp;", "0").ToString();
                string _MachineCode = "1";
                Boolean _ReplacementRequired = true ;
                if (!btn_Submit.Text.Equals("Update Pharmacy"))
                {
                    T_Detail.LoadDataRow(new object[] { sysIssueMasterNo, _sysItemCodeSno, _ItemLocationCode, _SubDeptCode, _Description, _QuantityRequired, _QuantityIssued, _UnitCode, _MachineCode, _ReplacementRequired }, LoadOption.Upsert);
                }
                else {
                    T_Detail.LoadDataRow(new object[] { sysIssueDetailNo,sysIssueMasterNo, _sysItemCodeSno, _ItemLocationCode, _SubDeptCode, _Description, _QuantityRequired, _QuantityIssued, _UnitCode, _MachineCode, _ReplacementRequired }, LoadOption.Upsert);
                }
                
                i = i + 1;

            }
            con.Close();
            con.Open();
            d_Adapter.Update(this.T_Detail);
            con.Close();
            this.T_Detail.AcceptChanges();

            //    this.GenerateToken();

                Literal1.Text = "Data Inserted Succesfully";
            //    if (chkPrint.Checked) {
            //        this.PrintReport();
            //    }
            //    Session["SESSION_MRNO"] = lblPatientMrNo.Text;
            //    Session["SESSION_TICKETNO"] = sysTicketMasterNo;
            //    ShowPrintMessage();

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

            try
            {
                string userCode;
                DataTable _datatable = new DataTable();

                userCode = (Session["User_Code"].ToString());
                oConn = new ConNew();
                string _sql = "Select sysClinicSno,Clinic_Name,Dept_Code,sysGodownLocation_Code from MED_ClinicRegistration WHERE UserCode = '" + userCode + "' Order by Clinic_Name";
                _datatable = oConn.GetDataTable(_sql);
                ddClinic.DataSource = _datatable;
                ddClinic.DataTextField = "Clinic_Name";
                ddClinic.DataValueField = "sysClinicSno";
                ddClinic.DataBind();
              
                ddClinic.SelectedValue = Session["sysClinicSNo"].ToString();
                lblDeptCode.Text = _datatable.Rows[0]["Dept_Code"].ToString();
                lblLocationCode.Text = _datatable.Rows[0]["sysGodownLocation_Code"].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oConn.CloseConnection();
            }
        }
        private void PopulateUnit()
        {
            oConn = new ConNew();
            string _sql = "Select Unit_Code,Unit_Name from GEN_UnitSetup";
            ddUnit.DataSource = oConn.GetDataTable(_sql);
            ddUnit.DataTextField = "Unit_Name";
            ddUnit.DataValueField = "Unit_Code";
            ddUnit.DataBind();
            oConn.CloseConnection();
        }
        public void ShowPrintMessage()
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "Confirm();", true);
        }
        private void PopulateMedicine()
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("Select sysItemCodeSno,Item_Code,Item_Name from STR_ItemSetup", con);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            ddlMedicine.DataSource = cmd.ExecuteReader();
            ddlMedicine.DataTextField = "Item_Name";
            ddlMedicine.DataValueField = "sysItemCodeSno";
            ddlMedicine.DataBind();
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

        private void GetGetDocumentNoByDocumentTypeCode()
        {

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
        private void SetPatientDetail(string MRNO)
        {
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
            lblsysTicketMasterNo.Text = DT.Rows[0]["sysTicketMasterNo"].ToString();
            ServiceAdded.Visible = true;
            this.GetPharmacyDetail(DT.Rows[0]["sysTicketMasterNo"].ToString());




        }
        private void SetPatientDetailView(string MRNO)
        {
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
            lblsysTicketMasterNo.Text = DT.Rows[0]["sysTicketMasterNo"].ToString();
            ServiceAdded.Visible = true;
        }
        private void GetPharmacyDetail(string sysTicketMasterNo)
        {
            Connection con = new Connection();
            string _sql = " SELECT sysIssueDetailNo,A.sysIssueMasterNo,sysItemCodeSno,dbo.Func_STR_sysItemCodeSNo_ItemName(sysItemCodeSno) Item_Name,Item_Location_Code,Description,Quantity_Required,Quantity_Issued,Machine_Code,Unit_Code,dbo.Func_GEN_UnitCode_UnitName(Unit_Code )Unit_Name ";
            _sql += " FROM	STR_IssueMaster A Inner Join   STR_IssueDetail B On A.sysIssueMasterNo = B.sysIssueMasterNo Where A.Reference_No =  '" + sysTicketMasterNo + "' ";
            T_Detail = con.GetDataTable(_sql);
            ViewState.Add("T_Detail", T_Detail);
            this.ReFreshGrid();
            lblHide.Text = T_Detail.Rows[0]["sysIssueMasterNo"].ToString();
        }

        private void GetPatientServices()
        {
            DataTable dt = new DataTable();
            string cs = ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("MED_GetPatientPharmacy", con);
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
            btn_Submit.Text = "Update Pharmacy";
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

            T_Detail.Columns.Add("sysIssueDetailNo", typeof(string));/*HardCode*/
            T_Detail.Columns.Add("sysIssueMasterNo", typeof(string));/*HardCode*/
            T_Detail.Columns.Add("sysItemCodeSno", typeof(string));/*ddMedicin.SelectedValue*/
            T_Detail.Columns.Add("Item_Name", typeof(string));/*ddMedicine.SelectedItem.Text*/
            T_Detail.Columns.Add("Item_Location_Code", typeof(string));  /*Hard Code 1*/ 
            T_Detail.Columns.Add("Description", typeof(string));/*User Enter Textbox in grid*/
            T_Detail.Columns.Add("Quantity_Required", typeof(string));/*User Enter Textbox in grid*/
            T_Detail.Columns.Add("Quantity_Issued", typeof(string));/*User Enter Textbox in grid*/
            T_Detail.Columns.Add("Machine_Code", typeof(string));/*HardCode*/
            T_Detail.Columns.Add("Unit_Code", typeof(string));/*ddUnit.SelectedValue*/
            T_Detail.Columns.Add("Unit_Name", typeof(string));/*ddUnit.SelectedItem.text*/
            gvServiceDetail.DataSource = T_Detail;
            ViewState.Add("T_Detail", T_Detail);
            gvServiceDetail.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {

            T_Detail = (DataTable)ViewState["T_Detail"];
            I_Count = Convert.ToInt32(ViewState["I_COUNT"]) + 1;
            Int16 i = default(Int16);
            
            T_Detail.Rows.InsertAt(AddRow(I_Count.ToString(), ddlMedicine.SelectedValue.ToString(),   ddlMedicine.SelectedItem.Text.ToString(),txtPatientMedicineDosage.Text,txtQuantity.Text , ddUnit.SelectedValue.ToString(), ddUnit.SelectedItem.Text.ToString()), gvServiceDetail.Rows.Count + 1);
            ViewState["I_COUNT"] = Convert.ToInt16(I_Count + i).ToString();
            this.ReFreshGrid();
        
        }
        private void ReFreshGrid() {

            gvServiceDetail.DataSource = T_Detail;
            gvServiceDetail.DataBind();
        }
        private DataRow AddRow(string sysIssueDetailNo, string sysItemCodeSno, string ItemName, string Description, string Quantity_Required, string Unit_Code, string Unit_Name)
        {
            
            DataRow R_Row = default(DataRow);
            R_Row = this.T_Detail.NewRow();
            R_Row["sysIssueDetailNo"] = sysIssueDetailNo;
            R_Row["sysItemCodeSno"] = sysItemCodeSno;
            R_Row["Item_Name"] = ItemName;
            R_Row["Description"] = Description;
            R_Row["Quantity_Required"] = Quantity_Required;
            R_Row["Unit_Code"] = Unit_Code;
            R_Row["Unit_Name"] = Unit_Name;
            
            return R_Row;
        }
        protected void gvServiceDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string User_Code;
            User_Code = (Session["User_Code"].ToString());
            string sqlQuery;
            T_Detail = (DataTable)ViewState["T_Detail"];
            T_Detail.Rows[e.RowIndex].Delete();

            if (!(btn_Submit.Text == SAVE_BUTTON))
            {
                sqlQuery = " Delete FROM STR_IssueDetail WHERE sysIssueDetailNo='" + gvServiceDetail.Rows[e.RowIndex].Cells[0].Text + "'";
                Connection Connection = new Connection();
                Connection.ExecuteQuery(sqlQuery);


            }
            this.ReFreshGrid();
        }
        protected void gvServiceDetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                viewCount += Convert.ToDouble((DataBinder.Eval(e.Row.DataItem, "Quantity_Required").Equals(DBNull.Value) ? 0 : DataBinder.Eval(e.Row.DataItem, "Quantity_Required")));
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                this.ViewState["viewCountSum"] = viewCount;
                e.Row.Cells[4].Text = this.ViewState["viewCountSum"].ToString() + " Pieces";
                e.Row.Cells[3].Text = "Total Qty.";
            }
        }
        protected void gvPatientService_SelectedIndexChanged(object sender, EventArgs e)
        {
            // populate Patient Tab Only 
            this.SetPatientDetailView(gvPatientService.SelectedRow.Cells[1].Text);
            // populate ticket detail for patient
           // this.GetTicketDetail(gvPatientService.SelectedRow.Cells[2].Text);
            // setting Status For Update
           // btn_Submit.Text = "Update Pharmacy";
            //ViewState.Add("sysTicketMasterNo", gvPatientService.SelectedRow.Cells[2].Text);

        }
     private void EnableControl()
        {
         if(ddlMedicine.SelectedItem.ToString() != "Select Services")
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