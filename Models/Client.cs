using System;
using System.Data;
using System.Collections.Generic;
using API.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace API.Models
{
    public class Client
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int City { get; set; }
        public string Street { get; set; }
        public int StreetNumber { get; set; }
        public int Appartment { get; set; }
        public string Entrance { get; set; }
        public string Phone { get; set; }
        public string CellPhone { get; set; }
        public bool IsSameAddress { get; set; }
        public int OrderId { get; set; }
    }

    public static class ClientData
    {
        static readonly Database _db = new Database();

        internal static object GetClientDetails(Client c)
        {
            string sql = $"select * from ClientDetails where Id = '{c.Id}'";
            return _db.ExecReader(sql);
        }

        internal static object UpdateClientAddress(Client client)
        {
            string sql = "UpdateClientAddress";
            Dictionary<string, object> p = new Dictionary<string, object>(){
                {"@OrderId", client.OrderId},
                {"@ClientId",client.Id},
                {"@IsSameAddress",client.IsSameAddress},
                {"@City",client.City},
                {"@Street",client.Street},
                {"@StreetNumber",client.StreetNumber},
                {"@Appartment",client.Appartment},
                {"@Entrance",client.Entrance}
            };

            return _db.ExecNonQuery(sql, p);
        }
    }
}