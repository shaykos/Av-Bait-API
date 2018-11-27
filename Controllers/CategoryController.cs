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
    public class CategoryController : ControllerBase
    {
        private readonly IHostingEnvironment _appEnvironment;

        public CategoryController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

       [HttpPost]
        public IActionResult Create([FromBody]Category category)
        {
            Dictionary<string, object> res;
            try
            {
                res = CategoryData.Create(category);
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

         [HttpPost]
        public IActionResult AddProblem([FromBody]Problem problem)
        {
            Dictionary<string, object> res;
            try
            {
                res = CategoryData.AddProblem(problem);
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
