using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Company
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Logo { get; set; }
    }


    public class CompanyFiles
    {
        public int CompanyId { get; set; }
        public string Src { get; set; }
        public string Name { get; set; }
        public string FullPath { get; set; }
    }

    public static class CompanyData
    {
        static readonly Database _db = new Database();

        internal static Dictionary<string, object> Create(Company company, IHostingEnvironment appEnvironment)
        {
            Dictionary<string, object> res;
            
            string sql = "AddCompany";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Name", company.Name}
            };

            List<Dictionary<string, object>> rows = Service.ConvertDataTableToList(_db.ExecReader(sql, p, "proc"));
            if ((string)rows[0]["Id"] != "0")
            {
                string type = company.Logo.Split(";")[0].Split("/")[1];
                CompanyFiles cf = new CompanyFiles()
                {
                    CompanyId = int.Parse(rows[0]["Id"].ToString()),
                    Src = company.Logo,
                    Name = (string)rows[0]["Id"],
                    FullPath = $"/uploads/companies/{(string)rows[0]["Id"]}/{(string)rows[0]["Id"]}.{type}"
                };
                res = Service.createSuccessRes();
                res.Add("Save", UpdateCompanyLogo(cf, appEnvironment));
            }
            else{
                sql = "select * from dbo.GetSystemMessage(3)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(sql));
            }
            return res;
        }

        internal static object UpdateCompanyLogo(CompanyFiles companyFiles, IHostingEnvironment appEnvironment)
        {
            List<object> res = new List<object>();
            try
            {
                string type = companyFiles.Src.Split(";")[0].Split("/")[1];
                string dir = $"companies/{companyFiles.CompanyId}/";
                object obj = Files.SaveImage(companyFiles.Src, companyFiles.Name, type, appEnvironment, dir);
                if ((bool)obj)
                {
                    string sql = "UpdateCompanyLogo";
                    Dictionary<string, object> p = new Dictionary<string, object>(){
                        {"@CompanyId",companyFiles.CompanyId},
                        {"@Logo",companyFiles.FullPath}
                    };
                    return _db.ExecNonQuery(sql, p);
                }
                else return false;

            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}