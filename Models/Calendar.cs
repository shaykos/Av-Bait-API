using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Calendar
    {
        public int handymanId { get; set; }
    }

    public static class CalendarData
    {
        static readonly Database _db = new Database();

        internal static object GetAllEvents(Calendar c)
        {
            string sql = $"select * from AllEvents";
            sql += (c.handymanId != 0) ? $" where [HandymanId] = {c.handymanId}" : "";
            return _db.ExecReader(sql);
        }

        internal static object GetHandymen(Calendar c)
        {
            string sql = "select * from Handymen";
            sql += (c.handymanId != 0) ? $" where [Id] = {c.handymanId}" : "";
            return _db.ExecReader(sql);
        }
    }
}