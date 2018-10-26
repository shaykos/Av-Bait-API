using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using BCr = BCrypt.Net.BCrypt;

namespace API.Helpers
{
    public class Crypt
    {
        private static Random random = new Random();
        
        public static string Hash(string password)
        {
            return BCr.EnhancedHashPassword(password);
            //return BCr.HashPassword(pass, enhancedEntropy: true);
        }

        public static bool Validate(string password, string passwordHash)
        {
            return BCr.EnhancedVerify(password, passwordHash);
        }

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}