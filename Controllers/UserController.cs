using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using API.Helpers;
using API.Models;
using Microsoft.AspNetCore.Hosting;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IHostingEnvironment _appEnvironment;

        public UserController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

        [HttpPost]
        public IActionResult Login([FromBody]User u)
        {
            try
            {
                Dictionary<string, object> res = UserData.Login(u);
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                Dictionary<string, object> res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Logout([FromBody]User u)
        {
            Dictionary<string, object> res;
            try
            {
               res = Service.createSuccessRes();
               res.Add("Logout",UserData.Logout(u));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }
    }
}
