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
    public class UsersController : Controller
    {
        private Entities db = new Entities();

        [Authorize]
        // GET: Users
        public ActionResult Index()
        {
            CommonModel commonModel = new CommonModel();
            commonModel.banUserCustomer = db.Users.Where(u => u.status.Equals("Inactive") && u.typeID == 3).ToList();
            commonModel.notBanUserCustomer = db.Users.Where(u => u.status.Equals("Active") && u.typeID == 3).ToList();
            commonModel.banUserStaff = db.Users.Where(u => u.status.Equals("Inactive") && u.typeID != 3).ToList();
            commonModel.notBanUserStaff = db.Users.Where(u => u.status.Equals("Active") && u.typeID != 3).ToList();
            int role = Convert.ToInt32(Session["role"]);
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Staff không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View(commonModel);
            }
            return View(commonModel);
        }

        // GET: Users/Create
        [Authorize]
        public ActionResult Create()
        {
            ViewBag.typeID = new SelectList(db.UserTypes, "typeID", "typeName").Where(u => u.Text.CompareTo("customer") != 0);
            int role = Convert.ToInt32(Session["role"]);
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Staff không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View();
            }
            return View();
        }

        // POST: Users/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Create")]
        public ActionResult Create([Bind(Include = "userID,typeID,username,password,fullname,address,phone,email,gender,birthday,registerDate,status")] User user)
        {
            try
            {
                    if (db.Users.Where(u => u.username.Equals(user.username)).FirstOrDefault() == null)
                    {
                        db.Users.Add(user);
                        db.SaveChanges();
                        ViewBag.typeID = new SelectList(db.UserTypes, "typeID", "typeName", user.typeID);
                        ViewBag.ErrorMessege = "<script>" +
                            "alert('Tạo thành công');" +
                            "window.location.href = '../Users/Index'" +
                            "</script>";
                        return View();
                    }
                    else
                    {
                        ViewBag.typeID = new SelectList(db.UserTypes, "typeID", "typeName").Where(u => u.Text.CompareTo("customer") != 0);
                        ViewBag.ErrorMessege = "<script>alert('Tên đăng nhập đã bị trùng');</script>";
                        return View();

                    }
        }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Tạo thất bại');</script>";
                ViewBag.typeID = new SelectList(db.UserTypes, "typeID", "typeName").Where(u => u.Text.CompareTo("customer") != 0);
                return View(user);
    }
}

        [HttpPost]
        [MultipleButton(Name = "action", Argument = "Back")]
        public ActionResult Back()
        {
            return RedirectToAction("Index");
        }

        // GET: Users/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            User user = db.Users.Find(id);
            int idSession = Convert.ToInt32(Session["id"]);
            try
            {
                if (id != idSession)
                {
                    db.Users.Remove(user);
                    db.SaveChanges();
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Xóa thành công');" +
                        "window.location.href = '../Index'" +
                        "</script>";
                    return View();
                }
                else
                {
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Xóa không thành công do tài khoản này đang được log in');" +
                        "window.location.href = '../Index'" +
                        "</script>";
                }
                return View(user);
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Xóa thất bại');</script>";
                return View(user);
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public ActionResult Ban(int? id, string status)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user != null)
            {
                bool result = Update(user, status);
                if (result)
                {
                    return RedirectToAction("Index");
                }
            }

            return RedirectToAction("Index");
        }

        public bool Update(User entity, string status)
        {
            //try
            //{
                User user = db.Users.Find(entity.userID);
                user.status = status;
                db.SaveChanges();
                return true;
            //}
            //catch (Exception)
            //{
            //    ViewBag.ErrorMessege = "<script>alert('Đổi trạng thái thất bại');</script>";
            //    return false;
            //}

        }
    }
}
