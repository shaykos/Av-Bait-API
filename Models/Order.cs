using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using FastMember;

namespace API.Models
{
    public class Order
    {
        public int Id { get; set; }
        public string ClaimNumber { get; set; }
        public int Type { get; set; }
        public int Status { get; set; }
        public string Name { get; set; }
        public float Deductible { get; set; }
        public int City { get; set; }
        public string Street { get; set; }
        public int Appartment { get; set; }
        public string Phone { get; set; }
        public string CellPhone { get; set; }
        public int CategoryId { get; set; }
        public int ProblemId { get; set; }
        public DateTime? ETADate { get; set; }
        public int ETATime { get; set; }
        public int HandymanId { get; set; }
        public string Note { get; set; }
    }

    public class Question
    {
        public int OrderId { get; set; }
        public int QuestionId { get; set; }
        public string Answer { get; set; }

    }

    public static class OrderData
    {
        static readonly Database _db = new Database();

        internal static object Create(Order order)
        {
            string sql = "AddOrder";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@ClaimNumber", order.ClaimNumber},
                {"@Type", order.Type},
                {"@Status", order.Status},
                {"@Name", order.Name},
                {"@Deductible", order.Deductible},
                {"@City", order.City},
                {"@Street", order.Street},
                {"@Appartment", order.Appartment},
                {"@Phone", order.Phone},
                {"@CellPhone", order.CellPhone},
                {"@ProblemId", order.ProblemId},
                {"@ETADate", order.ETADate},
                {"@ETATime", order.ETATime},
                {"@HandymanId",order.HandymanId},
                {"@Note", order.Note}
            };

            return _db.ExecNonQuery(sql, p);
        }

        internal static object GetAvaliableHandymen(Order order)
        {
            string sql = "select * from GetHandymen (@City, @ProblemId, @ETADate, @ETATime)";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@City",order.City},
                {"@ProblemId", order.ProblemId},
                {"@ETADate", order.ETADate},
                {"@ETATime", order.ETATime}
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
            sql += (order.Type != 0) ? $"(TypeId = ${order.Type}) and " : "";
            sql += (order.Status != 0) ? $"(StatusId = ${order.Status}) and " : "(StatusId = 10) and "; // 10 -> new orders
            sql += (order.HandymanId != 0) ? $"(HandymanId = ${order.HandymanId}) and " : "";
            sql = (sql.Contains("and")) ? sql.Remove(sql.Length - 4) : sql.Remove(sql.Length - 6);
            return _db.ExecReader(sql);
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
    }
}