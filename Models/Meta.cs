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

        internal static object Get(IHostingEnvironment _appEnvironment)
        {
            Dictionary<string, object> res = Service.createSuccessRes();
            res.Add("Areas", _db.ExecReader("select * from Areas"));
            res.Add("Cities", _db.ExecReader("select * from Cities"));
            res.Add("HoursOfWork", _db.ExecReader("select * from HoursOfWork"));
            res.Add("OrderStatus", _db.ExecReader("select * from OrderStatus"));
            res.Add("OrderTypes", _db.ExecReader("select * from OrderTypes"));
            res.Add("Problems", _db.ExecReader("select * from Problems where CategoryId = 1"));
            res.Add("Questions", _db.ExecReader("select * from QuestionsForCategory"));
            return Save.Json(_appEnvironment, res);
        }
    }
}