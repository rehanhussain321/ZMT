using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
namespace ZMTClinics.Class
{
    public class Connection
       {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["KTConnectionString"].ConnectionString);
        public Connection()
        {
          //  con.Open(); 
        }
        private void setConnection()
        {
            con.Open();
        }
        public  void CloseConnection()
        {
            con.Close();
            con.Dispose();
        }
        public DataTable GetDataTable(string _query)
        {
            setConnection();
            SqlCommand cmd = new SqlCommand(_query, con);
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = (cmd);
            DataTable _dt = new DataTable();
            da.Fill(_dt);
            CloseConnection();
            return _dt;
        }
        public void ExecuteQuery(string _query)
        {
            setConnection();
            SqlCommand cmd = new SqlCommand(_query, con);
            cmd.ExecuteNonQuery();
            CloseConnection();
        }
        public string ExecuteScalarQuery(string _query)
        {
            setConnection();
            SqlCommand cmd = new SqlCommand(_query, con);
            string _return = cmd.ExecuteScalar().ToString();
            CloseConnection();
            return _return;

        }
       
        }
}
