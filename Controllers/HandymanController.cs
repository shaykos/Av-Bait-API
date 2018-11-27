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
    public class HandymanController : ControllerBase
    {
        private readonly IHostingEnvironment _appEnvironment;

        public HandymanController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

        [HttpPost]
        public IActionResult Get([FromBody]Handyman handyman)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                if (handyman.Id != 0)
                {
                    res.Add("Handyman", HandymanData.GetHandyman(handyman));
                    res.Add("Businesses", HandymanData.GetHandymanBusinesses(handyman.Id));
                    res.Add("Categories", HandymanData.GetHandymanCategories(handyman.Id));
                    res.Add("Areas", HandymanData.GetHandymanAreas(handyman.Id));
                }
                else{
                    res.Add("Handymen", HandymanData.GetAll());
                }
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Create([FromBody]Handyman handyman)
        {
            Dictionary<string, object> res;
            try
            {
                res = HandymanData.Create(handyman);
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Update([FromBody]Handyman handyman)
        {
            Dictionary<string, object> res;
            try
            {
                res = HandymanData.Update(handyman);
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Delete([FromBody]Handyman handyman)
        {
            Dictionary<string, object> res;
            try
            {
                res = HandymanData.Delete(handyman);
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
