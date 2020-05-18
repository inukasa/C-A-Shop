using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ManagerSide.Models;

namespace ManagerSide.Controllers
{
    public class OrdersController : Controller
    {
        private Entities db = new Entities();

        [Authorize]
        // GET: Orders
        public ActionResult Index()
        {
            CommonModel myOrder = new CommonModel();
            myOrder.orderByDateCreated = db.ShippingInfors.Where(x => x.Order.orderStatus.Equals("Đang chờ xử lý")).ToList();
            myOrder.orderByDateConfirm = db.Orders.Where(x => !x.orderStatus.Equals("Đang chờ xử lý")).ToList();
            myOrder.orderDetailList = db.Orders.Include(u => u.User).ToList();
            return View(myOrder);
        }

        public ActionResult EditStatus(int? id, string status)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            if (order != null)
            {
                bool result = Update(order, status);
                if (result)
                {
                    return RedirectToAction("Index");
                }
            }
            return View("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public bool Update(Order entity, string status)
        {
            try
            {
                var order = db.Orders.Find(entity.orderID);
                order.dateConfirm = DateTime.Now.ToString();
                order.dateCreate = entity.dateCreate;
                order.orderStatus = status;
                order.orderTotalPrice = entity.orderTotalPrice;
                order.userID = entity.userID;
                db.SaveChanges();
                return true;
            }                
            catch(Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Đổi trạng thái thất bại');</script>";
                return false;
            }

        }
        [HttpPost]
        public JsonResult GetOrderProduct()
        {
            ((IObjectContextAdapter)db).ObjectContext.ContextOptions.ProxyCreationEnabled = false;
            var id = Request.Form["ID"];
            var index = Convert.ToInt32(id);
            var products = db.OrderDetails.Where(p => p.orderID == index).ToList();
            return Json(new { data = products });
        }
    }
}
