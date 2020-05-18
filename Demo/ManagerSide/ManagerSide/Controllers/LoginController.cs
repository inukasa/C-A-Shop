using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using ManagerSide.Models;

namespace ManagerSide.Controllers
{
    public class LoginController : Controller
    {
        private Entities db = new Entities();

        // GET: Login/Login
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(UserLogin user)
        {
            if (IsValid(user))
            {

                User user1 = db.Users.Where(b => b.username.Equals(user.username)).FirstOrDefault();
                FormsAuthentication.SetAuthCookie(user.username, false);
                Session["user"] = user1.fullname;
                Session["username"] = user.username;
                Session["role"] = user1.typeID;
                Session["id"] = user1.userID;
                //if (user1.avatar != null)
                //{
                //    Session["image"] = user1.avatar;
                //} else
                //{
                //    Session["image"] = "unknown-512.png";
                //}
                

                return RedirectToAction("Index", "Index");
            }
            else
            {
                ViewBag.ErrorMessege = "<script>alert('Tài khoản không hợp lệ');</script>";
                return View(user);
            }

        }

        [HttpPost]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session["user"] = null;
            return Redirect("/Index/Index");
        }
        private bool IsValid(UserLogin user)
        {
                bool flag = false;
                List<User> listU = db.Users.ToList();
                var uLogin = new User();
                bool isUsername = false;
                foreach (User us in listU)
                {
                    if (us.username.Equals(user.username))
                    {
                        isUsername = true;
                    }
                }
                if (isUsername == true)
                {
                    uLogin = db.Users
                    .Where(b => b.username.Equals(user.username) && b.password.Equals(user.password))
                    .FirstOrDefault();
                }
                else if (isUsername == false)
                {
                    uLogin = db.Users
                    .Where(b => b.phone.Equals(user.username) && b.password.Equals(user.password))
                    .FirstOrDefault();
                }
                if (uLogin != null)
                {
                    if (uLogin.status.Equals("Active") && uLogin.typeID != 3)
                    {
                        flag = true;
                    }
                    else
                    {
                        flag = false;
                    }

                }           
            return flag;
        }
    }
}
