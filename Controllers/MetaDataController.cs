using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using API.Helpers;
using API.Models;
using Microsoft.AspNetCore.Hosting;
using System.Net.Http;
using Newtonsoft.Json.Linq;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class MetaDataController : ControllerBase
    {
        private readonly IHostingEnvironment _appEnvironment;

        public MetaDataController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

        [HttpPost]
        public IActionResult Write()
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("res", MetaData.Write(_appEnvironment));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Get()
        {
            Dictionary<string, object> res;
            try
            {
                res = MetaData.Get();
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
