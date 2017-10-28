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
    public partial class reciept_copy : System.Web.UI.Page
    {
        Connection oConn = new Connection();
        
        double viewCount = 0;

        DataTable DT = new DataTable();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["SESSION_MRNO"] == null || Session["SESSION_TICKETNO"] == null)
            {
                Response.Redirect("../login.aspx");
            }
            else
            {

                if (!IsPostBack ){
                
                string MRNO = (Session["SESSION_MRNO"].ToString());
                string TCKTNO = (Session["SESSION_TICKETNO"].ToString());
                string query;

                query = " EXECUTE MED_GetPatientDetail ' AND registration_No = ''" + MRNO + "'' AND B.sysTicketMasterNo=''" + TCKTNO + "''   '";

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
                lblDate.Text =  DT.Rows[0]["Created_Date"].ToString();



              //  lblTotalAmount.Text = DT.Rows[0]["Charges"].ToString();
                lblPayingStatus.Text = DT.Rows[0]["Zakat_Eligble_Name"].ToString();
                lblGuardian.Text = DT.Rows[0]["PatientOf_Name"].ToString();

                gvServices.DataSource = DT;
                gvServices.DataBind();

                
                ViewState.Add("DT", DT);
                }

            }
        }
        public void BindGrid()
        {
            gvServices.DataSource = ViewState["DT"] as DataTable;
            gvServices.DataBind();
        }
        protected void gvServices_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[6].ID = "id6_h"; 
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                viewCount += Convert.ToDouble((DataBinder.Eval(e.Row.DataItem, "Amount").Equals(DBNull.Value) ? 0 : DataBinder.Eval(e.Row.DataItem, "Amount")));
                e.Row.Cells[5].ID = "id5_i";
                e.Row.Cells[6].ID = "id6_i"; 
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                this.ViewState["viewCountSum"] = viewCount;
                e.Row.Cells[5].Text = this.ViewState["viewCountSum"].ToString();
                e.Row.Cells[4].Text = "Total Rs.";
                e.Row.Cells[5].ID = "id5_f";

                e.Row.Cells[6].ID = "id6_f"; 
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            //foreach(GridView gvr in gvServices.Rows)
            //{
            //    if(((CheckBox)gvr.FindControl("chkRow")).Checked == true)
            //    {
            //        gvr.Visible = false;
            //    }
            //}
        }

        protected void gvServices_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            DT = (DataTable)ViewState["DT"];
            DT.Rows[e.RowIndex].Delete();
            gvServices.DataSource = DT;
            gvServices.DataBind();
            ViewState.Add("DT", DT);
           // BindGrid();
        }

       



        
    }
}