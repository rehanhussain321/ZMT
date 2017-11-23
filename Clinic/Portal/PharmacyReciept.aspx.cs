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

namespace Clinic.Portal
{
    public partial class PharmacyReciept : System.Web.UI.Page
    {
        Connection oConn = new Connection();
        double viewCount = 0;
        double viewCount_Days = 0;

        DataTable DT = new DataTable();
        DataTable T_Detail = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SESSION_MRNO"] == null || Session["SESSION_TICKETNO"] == null)
            {
                Response.Redirect("../login.aspx");
            }
            else
                if (!IsPostBack)
                {

                    string MRNO = (Session["SESSION_MRNO"].ToString());
                  //  string TCKTNO = (Session["SESSION_TICKETNO"].ToString());
                    string query;

                    query = " EXECUTE MED_GetPatientDetail ' AND registration_No = ''" + MRNO + "''   '";

                    Connection con = new Connection();
                    DT = con.GetDataTable(query);



                    // ----- Setting Header Values -----
                    lblMrNo.Text = DT.Rows[0]["Registration_No"].ToString();
                    lblPatientName.Text = DT.Rows[0]["First_Name"].ToString();
                    lblPatientFatherName.Text = DT.Rows[0]["Father_Name"].ToString();

                    lblAgeYear.Text = DT.Rows[0]["Age"].ToString();
                    lblAgeMonth.Text = DT.Rows[0]["Age_Months"].ToString();
                    lblGender.Text = DT.Rows[0]["Gender"].ToString();

                    lblAddress.Text = DT.Rows[0]["Present_Address"].ToString();
                    // lblContactNo.Text = DT.Rows[0]["Mobile_1"].ToString();



                    // lblCharges.Text = DT.Rows[0]["Charges"].ToString();
                    //  lblService.Text = DT.Rows[0]["Service_Name"].ToString();
                    //  lblServiceDetail.Text = DT.Rows[0]["Service_DetailName"].ToString();
                    lblClinicAddress.Text = DT.Rows[0]["Clinic_Address"].ToString();
                    lbltokenNo.Text = DT.Rows[0]["Ticket_Number"].ToString();
                    lblDate.Text = DT.Rows[0]["Created_Date"].ToString();



                    //  lblTotalAmount.Text = DT.Rows[0]["Charges"].ToString();
                    lblPayingStatus.Text = DT.Rows[0]["Zakat_Eligble_Name"].ToString();
                    lblGuardian.Text = DT.Rows[0]["PatientOf_Name"].ToString();
                    this.GetPharmacyDetail(DT.Rows[0]["sysTicketMasterNo"].ToString());
                    lblPharmacyNumber.Text = DT.Rows[0]["Document_No"].ToString();
                    //gvServiceDetail.DataSource = DT;
                    //gvServiceDetail.DataBind();


                    ViewState.Add("DT", DT);
                }

        }
        private void GetPharmacyDetail(string sysTicketMasterNo)
        {
            Connection con = new Connection();
            string _sql = " SELECT sysIssueDetailNo,A.sysIssueMasterNo,sysItemCodeSno,Document_No,dbo.Func_STR_sysItemCodeSNo_ItemName(sysItemCodeSno) Item_Name,Item_Location_Code,Description,Quantity_Required,Quantity_Issued,Machine_Code,Unit_Code,dbo.Func_GEN_UnitCode_UnitName(Unit_Code )Unit_Name,Days ";
            _sql += " FROM	STR_IssueMaster A Inner Join   STR_IssueDetail B On A.sysIssueMasterNo = B.sysIssueMasterNo Where A.Reference_No =  '" + sysTicketMasterNo + "' ";
            DT = con.GetDataTable(_sql);
            ViewState.Add("DT", DT);
            this.ReFreshGrid();
        }
        private void ReFreshGrid()
        {

            gvServiceDetail.DataSource = DT;
            gvServiceDetail.DataBind();
        }
        protected void gvServiceDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            DT = (DataTable)ViewState["DT"];
            DT.Rows[e.RowIndex].Delete();
            gvServiceDetail.DataSource = DT;
            gvServiceDetail.DataBind();
            ViewState.Add("DT", DT);
            // BindGrid();
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
                e.Row.Cells[4].Text = this.ViewState["viewCountSum"].ToString() + " Unit(s)";
                e.Row.Cells[3].Text = "Total Qty.";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                viewCount_Days += Convert.ToDouble((DataBinder.Eval(e.Row.DataItem, "Days").Equals(DBNull.Value) ? 0 : DataBinder.Eval(e.Row.DataItem, "Days")));
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                this.ViewState["viewCount_daysSum"] = viewCount_Days;
                e.Row.Cells[2].Text = this.ViewState["viewCount_daysSum"].ToString() + " Day(s)";
               // e.Row.Cells[3].Text = "Total Qty.";
            }
        }
    }
}
 

