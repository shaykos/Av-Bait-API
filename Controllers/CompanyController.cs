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
    public class CompanyController : ControllerBase
    {
        //private readonly OrderData _orderdata = new OrderData();
        private readonly IHostingEnvironment _appEnvironment;

        public CompanyController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

        [HttpPost]
        public IActionResult Create([FromBody]Company company)
        {
            Dictionary<string, object> res;
            try
            {
                res = CompanyData.Create(company, _appEnvironment);
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }


        [HttpPost]
        public IActionResult UpdateCompanyLogo([FromBody]CompanyFiles companyFiles)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Updated", CompanyData.UpdateCompanyLogo(companyFiles, _appEnvironment));
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
