using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ManagerSide.Models;

namespace ManagerSide.Controllers
{
    public class ErrorController : Controller
    {

        // GET: Index/Index
        public ActionResult Error()
        {
            return View();
        }
    }
}
