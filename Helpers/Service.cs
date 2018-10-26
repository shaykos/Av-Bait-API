using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;

namespace API.Helpers
{
    public class Service
    {
        //create succesful json
        internal static Dictionary<string, object> createSuccessRes()
        {
            Dictionary<string, object> res = new Dictionary<string, object>();
            res.Add("state", 1);
            return res;
        }

        internal static Dictionary<string, object> createSuccessRes(string msg)
        {
            Dictionary<string, object> res = new Dictionary<string, object>();
            res.Add("state", 1);
            res.Add("message", msg);
            return res;
        }

        //create error json
        internal static Dictionary<string, object> createErrorRes(string msg = "")
        {
            Dictionary<string, object> res = new Dictionary<string, object>();
            res.Add("state", 0);
            if(msg != "")
                res.Add("message", msg);
            return res;
        }


        //get the row item according to the list type
        internal static List<Dictionary<string, object>> ConvertDataTableToList(DataTable dt)
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return rows;
        }

        internal static bool IsNullOrEmpty<T>(IList<T> List)
        {
            return (List == null || List.Count < 1);
        }

        internal static bool IsNullOrEmpty<T, U>(IDictionary<T, U> Dictionary)
        {
            return (Dictionary == null || Dictionary.Count < 1);
        }
    }
}