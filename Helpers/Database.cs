using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace API.Helpers
{
    public class Database
    {
        public Database()
        {
            //this.Con = new SqlConnection(@"Server=.\SQLEXPRESS;Database=DB_9FBCC4_insurance;Trusted_Connection=True"); //dev 

            this.Con = new SqlConnection(@"Data Source=SQL5037.site4now.net;Initial Catalog=DB_9FBCC4_insurance;User Id=DB_9FBCC4_insurance_admin;Password=insu357241;"); //prod 

        }
        public SqlConnection Con { get; private set; }

        public SqlConnection GetConnestion()
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            return Con;
        }

        public int ExecNonQuery(string sql, Dictionary<string, object> p)
        {
            int rowsaffected = -1;
            try
            {
                SqlCommand cmd = new SqlCommand(sql, GetConnestion());
                cmd.CommandType = CommandType.StoredProcedure;
                if (!Service.IsNullOrEmpty(p))
                    foreach (string key in p.Keys)
                    {
                        cmd.Parameters.Add(new SqlParameter(key, p[key]));
                    }

                rowsaffected = cmd.ExecuteNonQuery();


            }
            catch (System.Exception)
            {
            }
            finally
            {
                Con.Close();
            }
            return rowsaffected;
        }

        public object ExecScalar(string sql)
        {
            object obj = -1;
            try
            {
                SqlCommand cmd = new SqlCommand(sql, GetConnestion());
                obj = cmd.ExecuteScalar();
            }
            catch (System.Exception)
            {
            }
            finally
            {
                Con.Close();
            }
            return obj;

        }

        public DataTable ExecReader(string sql, Dictionary<string, object> p = null, string type = "")
        {
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand(sql, GetConnestion());
                SqlDataReader sdr;
                cmd.CommandType = (type == "proc") ? CommandType.StoredProcedure : CommandType.Text;
                if (!Service.IsNullOrEmpty(p))
                    foreach (string key in p.Keys)
                    {
                        cmd.Parameters.Add(new SqlParameter(key, p[key]));
                    }
                sdr = cmd.ExecuteReader();
                dt.Load(sdr);
            }
            catch (System.Exception)
            {

            }
            finally
            {
                Con.Close();
            }
            return dt;
        }
    }
}