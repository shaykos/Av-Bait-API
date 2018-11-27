using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Handyman
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string Color { get; set; }
        public string BackgroundColor { get; set; }
        public bool IsEmployee { get; set; }
        public List<int> Businesses { get; set; }
        public List<int> Categories { get; set; }
        public List<int> Areas { get; set; }
    }

    public static class HandymanData
    {
        static readonly Database _db = new Database();

        internal static object GetHandyman(Handyman h)
        {
            string sql = "select Id, Name, Color, BackgroundColor, Email, IsEmployee from [dbo].[Handymen] where [Id] = @Id";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Id",h.Id}
            };
            return _db.ExecReader(sql, p);
        }

        internal static object GetAll()
        {
            string sql = "select Id, Name, Color, BackgroundColor, Email, IsEmployee from [dbo].[Handymen]";
            return _db.ExecReader(sql);
        }

        internal static object GetHandymanCategories(int id)
        {
            string sql = "select * from dbo.GetHandymanCategories(@Id)";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Id",id}
            };
            return _db.ExecReader(sql, p);
        }

        internal static Dictionary<string, object> Create(Handyman handyman)
        {
            Dictionary<string, object> res;

            string sql = "AddHandyman";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Name", handyman.Name},
                {"@Color", handyman.Color},
                {"@BackgroundColor", handyman.BackgroundColor},
                {"@Email", handyman.Email},
                {"@Password", Crypt.Hash(handyman.Password)},
                {"@IsEmployee", handyman.IsEmployee}
            };

            List<Dictionary<string, object>> rows = Service.ConvertDataTableToList(_db.ExecReader(sql, p, "proc"));
            if ((string)rows[0]["Id"] != "0")
            {
                handyman.Id = int.Parse(rows[0]["Id"].ToString());
                res = Service.createSuccessRes();
                int categories = 0, businesses = 0, areas = 0;
                for (int i = 0; i < handyman.Categories.Count; i++)
                {
                    sql = "AddHandymanCategory";
                    p = new Dictionary<string, object>(){
                        {"@HandymanId", handyman.Id},
                        {"@CategoryId", handyman.Categories[i]}
                    };
                    categories += _db.ExecNonQuery(sql, p);
                }

                for (int i = 0; i < handyman.Businesses.Count; i++)
                {
                    sql = "AddHandymanBusniess";
                    p = new Dictionary<string, object>(){
                        {"@HandymanId", handyman.Id},
                        {"@BusniessId", handyman.Businesses[i]}
                    };
                    businesses += _db.ExecNonQuery(sql, p);
                }

                for (int i = 0; i < handyman.Areas.Count; i++)
                {
                    sql = "AddHandymanArea";
                    p = new Dictionary<string, object>(){
                        {"@HandymanId", handyman.Id},
                        {"@AreaId", handyman.Areas[i]}
                    };
                    areas += _db.ExecNonQuery(sql, p);
                }

                res.Add("Save", (handyman.Id != 0 && categories == handyman.Categories.Count && businesses == handyman.Businesses.Count && areas == handyman.Areas.Count));
            }
            else
            {
                sql = "select * from dbo.GetSystemMessage(4)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(sql));
            }
            return res;
        }

        internal static Dictionary<string, object> Update(Handyman handyman)
        {
            Dictionary<string, object> res, p;
            string sql;

            if (handyman.Id != 0)
            {
                res = Service.createSuccessRes();
                int categories = 0, businesses = 0, areas = 0, updated = 0, deleted = 0;
                sql = "ClearHandymanBeforeUpdate";
                p = new Dictionary<string, object>(){
                    {"@HandymanId", handyman.Id}
                };
                deleted = _db.ExecNonQuery(sql, p);
                
                for (int i = 0; i < handyman.Categories.Count; i++)
                {
                    sql = "AddHandymanCategory";
                    p = new Dictionary<string, object>(){
                        {"@HandymanId", handyman.Id},
                        {"@CategoryId", handyman.Categories[i]}
                    };
                    categories += _db.ExecNonQuery(sql, p);
                }

                for (int i = 0; i < handyman.Businesses.Count; i++)
                {
                    sql = "AddHandymanBusniess";
                    p = new Dictionary<string, object>(){
                        {"@HandymanId", handyman.Id},
                        {"@BusniessId", handyman.Businesses[i]}
                    };
                    businesses += _db.ExecNonQuery(sql, p);
                }

                for (int i = 0; i < handyman.Areas.Count; i++)
                {
                    sql = "AddHandymanArea";
                    p = new Dictionary<string, object>(){
                        {"@HandymanId", handyman.Id},
                        {"@AreaId", handyman.Areas[i]}
                    };
                    areas += _db.ExecNonQuery(sql, p);
                }

                sql = "UpdateHandyman";
                p = new Dictionary<string, object>(){
                    {"@Id", handyman.Id},
                    {"@Name", handyman.Name},
                    {"@Color", handyman.Color},
                    {"@BackgroundColor", handyman.BackgroundColor},
                    {"@Email", handyman.Email},
                    {"@Password", (handyman.Password != null) ? Crypt.Hash(handyman.Password) : ""},
                    {"@IsEmployee", handyman.IsEmployee}
                };
                updated += _db.ExecNonQuery(sql, p);

                res.Add("Save", (updated != 0 && categories == handyman.Categories.Count && businesses == handyman.Businesses.Count && areas == handyman.Areas.Count));
            }
            else
            {
                sql = "select * from dbo.GetSystemMessage(4)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(sql));
            }
            return res;
        }

        internal static Dictionary<string, object> Delete(Handyman handyman)
        {
            Dictionary<string, object> res = Service.createSuccessRes(); ;

            string sql = "DeleteHandyman";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@HandymanId", handyman.Id}
            };
            res.Add("Deleted", _db.ExecNonQuery(sql, p));
            return res;
        }

        internal static object GetHandymanAreas(int id)
        {
            string sql = "select * from dbo.GetHandymanAreas(@Id)";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Id",id}
            };
            return _db.ExecReader(sql, p);
        }

        internal static object GetHandymanBusinesses(int id)
        {
            string sql = "select * from dbo.GetHandymanBusinesses(@Id)";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@Id",id}
            };
            return _db.ExecReader(sql, p);
        }
    }
}