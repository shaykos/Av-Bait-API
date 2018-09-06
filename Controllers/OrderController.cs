using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using API.Helpers;
using API.Models;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        //private readonly OrderData _orderdata = new OrderData();

        [HttpPost]
        public IActionResult Create([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Inserted", OrderData.Create(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Get([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Orders", OrderData.Search(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult GetAvaliableHandymen([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Handymen", OrderData.GetAvaliableHandymen(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult UpdateOrderStatus([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Updated", OrderData.UpdateOrderStatus(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult GetCategoryQuestions([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Questions", OrderData.GetCategoryQuestions(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult SaveOrderAnswers([FromBody]List<Question> answers)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Inserted", OrderData.SaveOrderAnswers(answers));
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
