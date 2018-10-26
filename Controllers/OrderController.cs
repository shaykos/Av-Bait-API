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
    public class OrderController : ControllerBase
    {
        //private readonly OrderData _orderdata = new OrderData();
        private readonly IHostingEnvironment _appEnvironment;

        public OrderController(IHostingEnvironment appEnvironment)
        {
            _appEnvironment = appEnvironment;
        }

        [HttpPost]
        public IActionResult Create([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Orders", OrderData.Create(order));
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
                if (order.Id != 0)
                {
                    res.Add("OrderNotes", OrderData.GetOrderNotes(order.Id));
                    res.Add("Files", OrderData.GetFiles(order.Id, _appEnvironment));
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
        public IActionResult SetHandymanToOrder([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Inserted", OrderData.SetHandymanToOrder(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult Update([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Updated", OrderData.Update(order));
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

        [HttpPost]
        public IActionResult SaveHandymanUpdate([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Updated", OrderData.saveHandymanUpdate(order));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult SaveNotes([FromBody]OrderNotes notes)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Inserted", OrderData.SaveNotes(notes));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult GetFiles([FromBody]Order order)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Files", OrderData.GetFiles(order.Id, _appEnvironment));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }

        [HttpPost]
        public IActionResult SaveFiles([FromBody]OrderFiles orderFiles)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Saved", OrderData.SaveFiles(orderFiles, _appEnvironment));
                return Ok(res);
            }
            catch (System.Exception ex)
            {
                res = Service.createErrorRes(ex.Message);
                return BadRequest(res);
            }
        }
        
        [HttpPost]
        public IActionResult RemoveFile([FromBody]OrderFiles files)
        {
            Dictionary<string, object> res;
            try
            {
                res = Service.createSuccessRes();
                res.Add("Removed", OrderData.RemoveFile(files.Src, _appEnvironment));
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
