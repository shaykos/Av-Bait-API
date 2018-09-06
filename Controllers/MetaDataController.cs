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
    public class MetaDataController : ControllerBase
    {
         private readonly IHostingEnvironment _appEnvironment;

        public MetaDataController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        } 

        [HttpPost]
        public IActionResult Get()
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("res", MetaData.Get(_appEnvironment));
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
