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
    public class InventoriesController : Controller
    {
        private Entities db = new Entities();

        [Authorize]
        // GET: Inventories
        public ActionResult Index()
        {
                int role = Convert.ToInt32(Session["role"]);

                CommonModel inventoryModel = new CommonModel();
                var restOfProduct = db.Inventories.Include(i => i.Product);
                var productSold = db.OrderDetails
                .Where(a => a.Order.orderStatus.Equals("Đã xử lý"))
                .GroupBy(a => a.productName)
                .Select(a => new ProductSold<int, string> { Amount = a.Sum(b => b.productQuantityOrder), Key = a.Key })
                .OrderByDescending(a => a.Amount)
                .ToList();
                inventoryModel.subCategories = db.SubCategories.ToList();
                inventoryModel.restOfProduct = restOfProduct;
                inventoryModel.productSold = productSold;
                if (role == 2)
                {
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Nhân viên không có quyền truy cập vào mục này');" +
                        "window.location.href = '../Index/Index'" +
                        "</script>";
                    return View(inventoryModel);
                }
                return View(inventoryModel);

        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        [Authorize]
        // GET: Inventories/Create
        public ActionResult Create()
        {
            ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName");
            int role = Convert.ToInt32(Session["role"]);
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Nhân viên không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View();
            }
            return View();
        }

        // POST: Categories/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Create")]
        public ActionResult Create([Bind(Include = "subcategoryID,categoryID,subcategoryName")] SubCategory subCategory)
        {

            try
            {
                if (db.SubCategories.Where(c => c.subcategoryName.Equals(subCategory.subcategoryName)).FirstOrDefault() == null)
                {
                    db.SubCategories.Add(subCategory);
                    db.SaveChanges();
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Tạo thành công');" +
                        "window.location.href = '../Inventories/Index'" +
                        "</script>";
                    ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName");
                    return View(subCategory);
                }
                ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName");
                ViewBag.ErrorMessege = "<script>alert('Tên loại hàng đã bị trùng');</script>";
                return View(subCategory);
        }
            catch (Exception)
            {
                ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName");
                ViewBag.ErrorMessege = "<script>alert('Tạo thất bại');</script>";
                return View(subCategory);
    }

}

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Back")]
        public ActionResult Back()
        {
            return RedirectToAction("Index");
        }

        [Authorize]
        public ActionResult EditProductCategory()
        {
            int role = Convert.ToInt32(Session["role"]);
            var product = db.Products.ToList();
            ViewBag.subcategoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName");
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Nhân viên không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View(product);
            }
            return View(product);
        }

        [HttpPost]
        public String EditProductCategory(List<String> products, int cateId)
        {
            if (ModelState.IsValid)
            {
                if (products.Count() == 0)
                {
                    return "Thay đổi lỗi";
                }
                else
                {
                    foreach (var i in products)
                    {
                        var c = db.Products.Where(a => a.productID.Equals(i)).FirstOrDefault();
                        if (c != null)
                        {
                            c.subcategoryID = cateId;
                        }
                        db.SaveChanges();
                    }
                    return "Thay đổi thành công";
                }
            }
            return "Thay đổi lỗi";
        }

        [Authorize]
        // GET: Inventories/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Inventory inventory = db.Inventories.Find(id);
            if (inventory == null)
            {
                return HttpNotFound();
            }
            int role = Convert.ToInt32(Session["role"]);
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Nhân viên không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View(inventory);
            }
            return View(inventory);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Edit")]
        public ActionResult Edit([Bind(Include = "productID,productQuantity")] Inventory inventory)
        {
            try
            {

                if (ModelState.IsValid)
                {
                    db.Entry(inventory).State = EntityState.Modified;
                    db.SaveChanges();
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Sửa thành công');" +
                        "window.location.href = '../Index'" +
                        "</script>";
                }
                return View(inventory);
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Sửa thất bại');</script>";
                return View(inventory);
            }
        }

        // GET: SubCategories/Edit/5
        [Authorize]
        public ActionResult EditSubCategory(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SubCategory subCategory = db.SubCategories.Find(id);
            if (subCategory == null)
            {
                return HttpNotFound();
            }
            ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName", subCategory.categoryID);
            return View(subCategory);
        }

        // POST: SubCategories/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "EditSubCategory")]
        public ActionResult EditSubCategory([Bind(Include = "subcategoryID,categoryID,subcategoryName")] SubCategory subCategory)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (db.SubCategories.Where(c => c.subcategoryName.Equals(subCategory.subcategoryName)).FirstOrDefault() == null)
                    {
                        db.Entry(subCategory).State = EntityState.Modified;
                        db.SaveChanges();
                        ViewBag.ErrorMessege = "<script>" +
                            "alert('Sửa thành công');" +
                            "window.location.href = '../Index'" +
                            "</script>";
                        ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName", subCategory.categoryID);
                        return View(subCategory);
                    } else
                    {
                        ViewBag.ErrorMessege = "<script>" +
                            "alert('Tên loại hàng đã tồn tại');" +
                            "</script>";
                        ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName", subCategory.categoryID);
                        return View(subCategory);
                    }
                }
            } catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>" +
                        "alert('Sửa thất bại');" +
                        "window.location.href = '../Index'" +
                        "</script>";
                ViewBag.categoryID = new SelectList(db.Categories, "categoryID", "categoryName", subCategory.categoryID);
            }
            return View(subCategory);
        }

        [Authorize]
        public ActionResult ImportShipmentCreate()
        {
            int role = Convert.ToInt32(Session["role"]);
            ViewBag.productID = new SelectList(db.Products, "productID", "productName");
            if (role == 2)
            {
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Nhân viên không có quyền truy cập vào mục này');" +
                    "window.location.href = '../Index/Index'" +
                    "</script>";
                return View();
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "ImportShipmentCreate")]
        public ActionResult ImportShipmentCreate([Bind(Include = "ID,importDate,productID,importPrice,quantity")] ImportShipment importShipment)
        {
            if (ModelState.IsValid)
            {
                db.ImportShipments.Add(importShipment);
                var inventory = db.Inventories.Where(i => i.productID == importShipment.productID).FirstOrDefault();
                if (inventory == null)
                {
                    Inventory inven = new Inventory();
                    inven.productID = importShipment.productID;
                    inven.productQuantity = importShipment.quantity;
                    db.Inventories.Add(inven);
                }
                else
                {
                    inventory.productQuantity += importShipment.quantity;
                }
                ViewBag.ErrorMessege = "<script>" +
                    "alert('Thêm thành công');" +
                    "window.location.href = '../Inventories/Index'" +
                    "</script>";
                ViewBag.productID = new SelectList(db.Products, "productID", "productName");
                db.SaveChanges();
            }
            return View(importShipment);
        }
    }
}

