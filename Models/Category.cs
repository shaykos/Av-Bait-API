using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class Problem
    {
        public int Id { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; }
    }


    public static class CategoryData
    {
        static readonly Database _db = new Database();

        internal static Dictionary<string, object> Create(Category category)
        {
            Dictionary<string, object> res;

            string sql = "AddCategory";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Name", category.Name}
            };

            List<Dictionary<string, object>> rows = Service.ConvertDataTableToList(_db.ExecReader(sql, p, "proc"));
            if ((string)rows[0]["Id"] != "0")
            {
                res = Service.createSuccessRes();
                res.Add("Save", true);
            }
            else
            {
                sql = "select * from dbo.GetSystemMessage(5)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(sql));
            }
            return res;
        }

        internal static Dictionary<string, object> AddProblem(Problem problem)
        {
            Dictionary<string, object> res;

            string sql = "AddProblem";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Name", problem.Name},
                {"@CategoryId",problem.CategoryId}
            };

            List<Dictionary<string, object>> rows = Service.ConvertDataTableToList(_db.ExecReader(sql, p, "proc"));
            if ((string)rows[0]["Id"] != "0")
            {
                res = Service.createSuccessRes();
                res.Add("Save", true);
            }
            else
            {
                sql = "select * from dbo.GetSystemMessage(6)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(sql));
            }
            return res;
        }
    }
}