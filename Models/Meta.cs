using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Meta
    {
        //props only
    }

    public static class MetaData
    {
        static readonly Database _db = new Database();

        internal static object Write(IHostingEnvironment _appEnvironment)
        {
            Dictionary<string, object> res = Service.createSuccessRes();
            res.Add("Areas", _db.ExecReader("select * from Areas"));
            res.Add("Cities", _db.ExecReader("select * from Cities"));
            res.Add("HoursOfWork", _db.ExecReader("select * from HoursOfWork"));
            res.Add("OrderStatus", _db.ExecReader("select * from OrderStatus"));
            res.Add("OrderTypes", _db.ExecReader("select * from OrderTypes"));
            res.Add("Problems", _db.ExecReader("select * from Problems where CategoryId = 1"));
            res.Add("Questions", _db.ExecReader("select * from QuestionsForCategory"));
            res.Add("Businesses", _db.ExecReader("select * from Business"));
            res.Add("InsuranceCompanies", _db.ExecReader("select * from InsuranceCompanies"));
            return Files.SaveJson(_appEnvironment, res);
        }

        internal static Dictionary<string, object> Get()
        {
            Dictionary<string, object> res = Service.createSuccessRes();
            res.Add("Areas", _db.ExecReader("select * from Areas"));
            res.Add("Cities", _db.ExecReader("select * from Cities"));
            res.Add("HoursOfWork", _db.ExecReader("select * from HoursOfWork"));
            res.Add("OrderStatus", _db.ExecReader("select * from OrderStatus"));
            res.Add("OrderTypes", _db.ExecReader("select * from OrderTypes"));
            res.Add("Problems", _db.ExecReader("select * from Problems where CategoryId = 1"));
            res.Add("Questions", _db.ExecReader("select * from QuestionsForCategory"));
            res.Add("Businesses", _db.ExecReader("select * from Business"));
            res.Add("InsuranceCompanies", _db.ExecReader("select * from InsuranceCompanies"));
            res.Add("Categories", _db.ExecReader("select * from Categories"));
            return res;
        }
    }
}