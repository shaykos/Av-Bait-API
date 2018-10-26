using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Order
    {
        public int Id { get; set; }
        public string ClientId { get; set; }
        public string PolicyNumber { get; set; }
        public string ClaimNumber { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
        public bool IsSameAddress { get; set; }
        public float Deductible { get; set; }
        public float Price { get; set; }
        public int City { get; set; }
        public string Street { get; set; }
        public int StreetNumber { get; set; }
        public int Appartment { get; set; }
        public string Entrance { get; set; }
        public string Phone { get; set; }
        public string CellPhone { get; set; }
        public int CategoryId { get; set; }
        public int ProblemId { get; set; }
        public DateTime? ETADate { get; set; }
        public int ETATime { get; set; }
        public int HandymanId { get; set; }
        public int BusinessId { get; set; }
        public string Note { get; set; }
        public int CreatedBy { get; set; }
        public string DateCreated { get; set; }
        public bool PTest { get; set; }
        public bool BTest { get; set; }
        public bool TTest { get; set; }
        public bool OTest { get; set; }
        public string OtherTestNote { get; set; }
    }

    public class Question
    {
        public int OrderId { get; set; }
        public int QuestionId { get; set; }
        public string Answer { get; set; }

    }

    public class OrderNotes
    {
        public int OrderId { get; set; }
        public string Results { get; set; }
        public DateTime DateCreated { get; set; }
        public string Actions { get; set; }
        public string Summary { get; set; }
        public string Others { get; set; }
    }

    public class OrderFiles
    {
        public int OrderId { get; set; }
        public string Src { get; set; }
        public string Name { get; set; }
    }

    public static class OrderData
    {
        static readonly Database _db = new Database();

        internal static object Create(Order order)
        {
            string sql = "AddOrder";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@ClaimNumber", order.ClaimNumber},
                {"@PolicyNumber",order.PolicyNumber},
                {"@ClientId",order.ClientId},
                {"@Type", order.Type},
                {"@IsSameAddress", order.IsSameAddress},
                {"@City", order.City},
                {"@Street", order.Street},
                {"@StreetNumber", order.StreetNumber},
                {"@Appartment", order.Appartment},
                {"@Entrance", order.Entrance},
                {"@Deductible", order.Deductible},
                {"@ProblemId", order.ProblemId},
                {"@ETADate", order.ETADate},
                {"@ETATime", order.ETATime},
                {"@BusinessId",order.BusinessId},
                {"@Note", order.Note},
                {"@CreatedBy",order.CreatedBy}
            };

            return _db.ExecReader(sql, p, "proc");
        }

        internal static object SetHandymanToOrder(Order order)
        {
            string sql = "setHandymanToOrder";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId", order.Id},
                {"@HandymanId",order.HandymanId}
            };

            return _db.ExecNonQuery(sql, p);
        }

        internal static object Update(Order order)
        {
            string sql = "updateOrder";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId", order.Id},
                {"@OrderType", order.Type},
                {"@OrderStatus", order.Status},
                {"@ProblemId", order.ProblemId},
                {"@ETADate", order.ETADate},
                {"@ETATime", order.ETATime},
                {"@BusinessId", order.BusinessId},
                {"@Deductible", order.Deductible}
            };

            return _db.ExecNonQuery(sql, p);
        }

        internal static object GetAvaliableHandymen(Order order)
        {
            string sql = "select * from GetHandymen (@OrderId) order by [IsEmployee], [Id]";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId",order.Id}
            };
            return _db.ExecReader(sql, p);
        }

        internal static object UpdateOrderStatus(Order order)
        {
            string sql = "UpdateOrderStatus";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId",order.Id},
                {"@OrderStatus", order.Status},
                {"@CategoryId", order.CategoryId}
            };
            return _db.ExecNonQuery(sql, p);
        }

        internal static object GetCategoryQuestions(Order order)
        {
            string sql = $"select * from QuestionsForCategory where CategoryId = {order.CategoryId}";
            return _db.ExecReader(sql);
        }

        internal static object Search(Order order)
        {
            string sql = "select * from OrdersView where ";
            if (order.Id != 0)
            {
                sql += $"Id = {order.Id}";
            }
            else if (order.ClaimNumber != "")
            {
                sql += $"ClaimNumber = N'{order.ClaimNumber}'";
            }
            else
            {
                sql += (order.DateCreated != "") ? $"(cast(DateCreated as Date) = '{order.DateCreated}') and " : "";
                sql += (order.PolicyNumber != "") ? $"(PolicyNumber = '{order.PolicyNumber}') and " : "";
                sql += (order.ClientId != "") ? $"(ClientId = '{order.ClientId}') and " : "";
                sql += (order.BusinessId != 0) ? $"(BusinessId = {order.BusinessId}) and " : "";
                sql += (order.Type != 0) ? $"(Type = {order.Type}) and " : "";
                sql += (order.Status != 0) ? $"(Status= {order.Status}) and " : "";
                sql += (order.HandymanId != 0) ? $"(HandymanId = {order.HandymanId}) and " : "";
                sql = (sql.Contains("and")) ? sql.Remove(sql.Length - 4) : sql.Remove(sql.Length - 6);
                sql += " order by Status, Id";
            }
            return _db.ExecReader(sql);
        }

        internal static object saveHandymanUpdate(Order order)
        {
            string sql = "saveHandymanUpdate";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId",order.Id},
                {"@PTest",order.PTest},
                {"@BTest",order.BTest},
                {"@TTest",order.TTest},
                {"@OTest",order.OTest},
                {"@OtherTestNote",order.OtherTestNote},
                {"@Price",order.Price}

            };
            return _db.ExecNonQuery(sql, p);
        }

        internal static object SaveFiles(OrderFiles orderFiles, IHostingEnvironment appEnvironment)
        {
            List<object> res = new List<object>();
            try
            {
                string type = orderFiles.Src.Split(";")[0].Split("/")[1];
                string dir = $"orders/{orderFiles.OrderId}/";
                return Files.SaveImage(orderFiles.Src, orderFiles.Name, type, appEnvironment, dir);
            }
            catch (Exception)
            {
                return false;
            }
        }

        internal static object RemoveFile(string path, IHostingEnvironment appEnvironment)
        {
            return Files.DeleteFile(path, appEnvironment);
        }

        internal static object SaveNotes(OrderNotes notes)
        {
            string sql = "addOrderNotes";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId",notes.OrderId},
                {"@DateCreated", notes.DateCreated},
                {"@Results", notes.Results},
                {"@Actions", notes.Actions},
                {"@Summary", notes.Summary}
            };
            return _db.ExecNonQuery(sql, p);
        }

        internal static object GetFiles(int id, IHostingEnvironment appEnvironment)
        {
            List<string> res = new List<string>();
            try
            {
                res = (List<string>)Files.GetFiles(appEnvironment, $"orders/{id}/");
            }
            catch (Exception)
            {
                return null;
            }
            return res;
        }

        internal static object SaveOrderAnswers(List<Question> questions)
        {
            int total = 0;
            foreach (var question in questions)
            {
                string sql = "AnswerQuestion";
                Dictionary<string, object> p = new Dictionary<string, object>(){
                    {"@OrderId",question.OrderId},
                    {"@QuestionId",question.QuestionId},
                    {"@Answer",question.Answer}
                };
                total += _db.ExecNonQuery(sql, p);
            }
            return total;
        }

        internal static object GetOrderNotes(int id)
        {
            string sql = $"select * from OrderNotes where OrderId = {id}";
            return _db.ExecReader(sql);
        }
    }
}