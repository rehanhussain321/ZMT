using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;//
using System.Data.SqlClient;//
namespace Clinic
{
    /// <summary>
    /// Summary description for MainPageChart
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class MainPageChart : System.Web.Services.WebService
    {
        public class PharmasyCount
        {
            public int Pharmasy_User { get; set; }
            public string Item_Name { get; set; }
        }

        [WebMethod]
        public List<PharmasyCount> PharmasyCountAnalysis()
        {
            List<PharmasyCount> PharmasyCountInfo = new List<PharmasyCount>();
            try
            {
                DataSet ds = new DataSet();
                string enddate = DateTime.Now.ToString("dd-MMM-yy");
                //DateTime end_date = Convert.ToDateTime(enddate);
                // string date_starting = "1 Jan 15";
                //DateTime datestart = Convert.ToDateTime(date_starting);
                string Report_Type = "98";
                // string Report_Option = "2";
                // string Report_option_two = "1";
                using (SqlConnection con = new SqlConnection("Data Source=SERVER-DB;Initial Catalog=KTDWH;Integrated Security=True"))
                {
                    using (SqlCommand cmd = new SqlCommand("MED_GetPharmasyUse"))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            cmd.Connection = con;
                            cmd.CommandTimeout = 0;
                            da.SelectCommand = cmd;
                            da.Fill(ds, "MED_GetPharmasyUse");
                        }
                    }
                }
                if (ds != null)
                {
                    if (ds.Tables["MED_GetPharmasyUse"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["MED_GetPharmasyUse"].Rows)
                        {
                            PharmasyCountInfo.Add(new PharmasyCount { Item_Name = dr["Item_Name"].ToString(), Pharmasy_User = Convert.ToInt32(dr["Pharmasy_Use"]) });
                        }
                    }
                }
                return PharmasyCountInfo;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
