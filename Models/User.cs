using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Email { get; set; }
         public string UserName { get; set; }
        public string Password { get; set; }
        public int RoleId { get; set; }
        public int InsuraceCompanyId { get; set; }
        public string Name { get; set; }
    }

    public static class UserData
    {
        static readonly Database _db = new Database();

        internal static object GetDashData(User u)
        {
            // res = this._service.createSuccessRes();
            // string cmd = $"select dbo.getUserHashPassword('{email}')";
            // object hashPassword = this._db.ExeScalar(cmd);
            // if (hashPassword == DBNull.Value)
            //     res = this._service.createErrorRes("user doesn't exsits"); //TODO: get messages form DB
            // else if (!Crypt.Validate(password, (string)hashPassword))
            //     res = this._service.createErrorRes("oops..."); //TODO: get messages form DB
            // else
            //     res = GetUser(res, ln, email, true);


            // string sql = "select * from GetHandymen (@City, @ProblemId, @ETADate, @ETATime)";
            // Dictionary<string, object> p = new Dictionary<string, object>(){
            //     {"@City",order.City},
            //     {"@ProblemId", order.ProblemId},
            //     {"@ETADate", order.ETADate},
            //     {"@ETATime", order.ETATime}
            // };
            // return _db.ExecReader(sql, p);
            return 0;
        }

        internal static object Logout(User u)
        {
             string sql = "Logout";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@UserId",u.Id}
            };
            return _db.ExecNonQuery(sql, p);
        }

        internal static Dictionary<string, object> Login(User u)
        {
            Dictionary<string, object> res;
            
            string cmd = $"select dbo.GetUserHashPassword('{u.UserName}')";
            object hashPassword = _db.ExecScalar(cmd);
            if (hashPassword == DBNull.Value)
            {
                cmd = "select * from dbo.GetSystemMessage(1)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(cmd));
                return res;
            }
            else if (!Crypt.Validate(u.Password, (string)hashPassword))
            {
                cmd = "select * from dbo.GetSystemMessage(2)";
                res = Service.createErrorRes();
                res.Add("error", _db.ExecReader(cmd));
                return res;
            }
            else
            {
                cmd = $"exec GetUserDetails'{u.UserName}'";
                res = Service.createSuccessRes();
                res.Add("UserDetails", _db.ExecReader(cmd));
                return res;
            }
        }
    }
}