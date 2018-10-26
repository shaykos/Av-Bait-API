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
    public class CalendarController : ControllerBase
    {
        private readonly IHostingEnvironment _appEnvironment;

        public CalendarController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

        [HttpPost]
        public IActionResult Get([FromBody]Calendar c)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Events", CalendarData.GetAllEvents(c));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult GetHandymen([FromBody]Calendar c)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Handymen", CalendarData.GetHandymen(c));
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
