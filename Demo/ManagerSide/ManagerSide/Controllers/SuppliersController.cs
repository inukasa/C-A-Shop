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
    public class SuppliersController : Controller
    {
        private Entities db = new Entities();

        [Authorize]
        // GET: Suppliers
        public ActionResult Index()
        {
            int role = Convert.ToInt32(Session["role"]);
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Staff không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View(db.Suppliers.ToList());
            }
            return View(db.Suppliers.ToList());
        }

        // GET: Suppliers/Search
        public ActionResult Search(string search)
        {
            if (search.Trim().Length > 0)
            {
                return View(db.Suppliers.Where(x => x.supplierName.Contains(search)).ToList());
            }
            return View(db.Suppliers.Where(x => x.supplierName.Contains(null)));

        }

        [Authorize]
        // GET: Suppliers/Create
        public ActionResult Create()
        {
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

        // POST: Suppliers/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Create")]
        public ActionResult Create([Bind(Include = "supplierID,supplierName,email,phone,address")] Supplier supplier)
        {
            //try
            //{
                if (ModelState.IsValid)
                {
                    if (db.Suppliers.Where(s => s.supplierName.Equals(supplier.supplierName)).FirstOrDefault() == null)
                    {
                    supplier.supplierName = supplier.supplierName.ToUpper();
                    db.Suppliers.Add(supplier);
                        db.SaveChanges();
                        ViewBag.ErrorMessege = "<script>" +
    "alert('Tạo thành công');" +
    "window.location.href = '../Suppliers/Index'" +
    "</script>";
                        return View();
                    } else
                    {
                        ViewBag.ErrorMessege = "<script>alert('Tên nhà cung cấp đã trùng');</script>";
                        return View();
                    }

                }

                return View(supplier);
            //}
            //catch (Exception)
            //{
            //    ViewBag.ErrorMessege = "<script>alert('Tạo thất bại');</script>";
            //    return View(supplier);
            //}

        }

        [HttpPost]
        [MultipleButton(Name = "action", Argument = "Back")]
        public ActionResult Back()
        {
            return RedirectToAction("Index");
        }

        [Authorize]
        // GET: Suppliers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Supplier supplier = db.Suppliers.Find(id);
            if (supplier == null)
            {
                return HttpNotFound();
            }
            int role = Convert.ToInt32(Session["role"]);
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Staff không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View(supplier);
            }
            return View(supplier);
        }

        // POST: Suppliers/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Edit")]
        public ActionResult Edit([Bind(Include = "supplierID,supplierName,email,phone,address")] Supplier supplier)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    supplier.supplierName = supplier.supplierName.ToUpper();
                    db.Entry(supplier).State = EntityState.Modified;
                    db.SaveChanges();
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Sửa thành công');" +
                        "window.location.href = '../Index'" +
                        "</script>";
                    return View();
                }
                return View(supplier);
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Sửa thất bại');</script>";
                return View(supplier);
            }
        }

        // GET: Suppliers/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Supplier supplier = db.Suppliers.Find(id);
            if (supplier == null)
            {
                return HttpNotFound();
            }
            return View(supplier);
        }

        // POST: Suppliers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
                Supplier supplier = db.Suppliers.Find(id);
                db.Suppliers.Remove(supplier);
                db.SaveChanges();
                ViewBag.ErrorMessege = "<script>" +
    "alert('Xóa thành công');" +
    "window.location.href = '../Index'" +
    "</script>";
                return View();
            }
            catch (Exception)
            {
                Supplier supplier = db.Suppliers.Find(id);
                ViewBag.ErrorMessege = "<script>alert('Xóa thất bại');</script>";
                return View(supplier);
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
    }
}
