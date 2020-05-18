using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ManagerSide.Models;
using System.Data.Entity.Infrastructure;
using System.IO;

namespace ManagerSide.Controllers
{
    public class ProductsController : Controller
    {
        private Entities db = new Entities();

        [Authorize]
        // GET: Products
        public ActionResult Index()
        {
            CommonModel product = new CommonModel();
            product.activeProduct = db.Products.Where(p => p.productStatus.Equals("Active")).ToList();
            product.inactiveProduct = db.Products.Where(p => p.productStatus.Equals("Inactive")).ToList();
            //product.maleProducts = db.Products.Where(p => p.categoryID == 1).ToList();
            //product.femaleProducts = db.Products.Where(p => p.categoryID == 2).ToList();
            //product.otherProducts = db.Products.Where(p => p.categoryID != 2 && p.categoryID != 1).ToList();
            //product.allProducts = db.Products.ToList();
            return View(product);
        }

        // GET: Products/Search
        public ActionResult Search(string search)
        {
            if (search.Trim().Length > 0)
            {
                return View(db.Products.Where(x => x.productName.Contains(search)).ToList());
            }
            return View(db.Products.Where(x => x.productName.Contains(null)));

        }

        [Authorize]
        // GET: Products/Create
        public ActionResult Create()
        {
            ViewBag.categoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName");
            ViewBag.productID = new SelectList(db.Inventories, "productID", "productQuantity");
            ViewBag.supplierID = new SelectList(db.Suppliers, "supplierID", "supplierName");
            return View();
        }

        // POST: Products/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Create")]
        public ActionResult Create(Product product)
        {

            try
            {
                List<Supplier> suppliers = db.Suppliers.Where(s => s.supplierID == product.supplierID).ToList();
                string supplierName = getSupplierName(suppliers, product.supplierID);
                product.productID = codeGenerate(product, supplierName);
                Product p = db.Products.Where(pr => pr.productName.Equals(product.productName) && pr.supplierID == product.supplierID).FirstOrDefault();
                if (p == null)
                {
                    if (product.ImageFile == null)
                    {
                        product.productIcon = "pi7.jpg";
                    } else
                    {
                        string fileName = Path.GetFileNameWithoutExtension(product.ImageFile.FileName);
                        string extension = Path.GetExtension(product.ImageFile.FileName);
                        fileName = fileName  + extension;
                        product.productIcon = fileName;
                        fileName = Path.Combine(Server.MapPath("~/Images/"), fileName);
                        product.ImageFile.SaveAs(fileName);
                    }
                }
                else
                {
                    product.productIcon = p.productIcon;
                }
                product.productName = product.productName.ToUpper();
                product.productColor = product.productColor.ToUpper();
                product.productSize = product.productSize.ToUpper();
                db.Products.Add(product);
                        db.SaveChanges();
                        ViewBag.ErrorMessege = "<script>" +
                            "alert('Tạo thành công');" +
                            "window.location.href = '../Products/Index'"+
                            "</script>";
                        ViewBag.categoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName", product.subcategoryID);
                        ViewBag.productID = new SelectList(db.Inventories, "productID", "productQuantity", product.productID);
                        ViewBag.supplierID = new SelectList(db.Suppliers, "supplierID", "supplierName", product.supplierID);
                return View();
                }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Tạo thất bại');</script>";
                ViewBag.categoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName", product.subcategoryID);
                ViewBag.productID = new SelectList(db.Inventories, "productID", "productQuantity", product.productID);
                ViewBag.supplierID = new SelectList(db.Suppliers, "supplierID", "supplierName", product.supplierID);
                return View(product);
            }

}


        [HttpPost]
        [MultipleButton(Name = "action", Argument = "Back")]
        public ActionResult Back()
        {
            return RedirectToAction("Index");
        }

        [Authorize]
        // GET: Products/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.categoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName", product.subcategoryID);
            ViewBag.productID = new SelectList(db.Inventories, "productID", "productQuantity", product.productID);
            ViewBag.supplierID = new SelectList(db.Suppliers, "supplierID", "supplierName", product.supplierID);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "Edit")]
        public ActionResult Edit([Bind(Include = "productID,supplierID,productName,importPrice,exportPrice,productIcon,productSize,ImageFile,productColor,productRate,importDate,subcategoryID,productDescription")] Product product)
        {
            try
            {
                if (product.ImageFile != null)
                {
                    string fileName = Path.GetFileNameWithoutExtension(product.ImageFile.FileName);
                    string extension = Path.GetExtension(product.ImageFile.FileName);
                    fileName = fileName  + extension;
                    product.productIcon = fileName;
                    fileName = Path.Combine(Server.MapPath("~/Images/"), fileName);
                    product.ImageFile.SaveAs(fileName);
                }
                db.Entry(product).State = EntityState.Modified;
                var productsWithSupAndName = db.Products.Where(p => p.productName.Equals(product.productName) && p.supplierID == product.supplierID).ToList();
                foreach (var item in productsWithSupAndName)
                {
                    item.exportPrice = product.exportPrice;
                }
                product.productName = product.productName.ToUpper();
                product.productColor = product.productColor.ToUpper();
                product.productSize = product.productSize.ToUpper();
                db.SaveChanges();
                    ViewBag.ErrorMessege = "<script>" +
                        "alert('Sửa thành công');" +
                        "window.location.href = '../Index'" +
                        "</script>";
                    ViewBag.categoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName", product.subcategoryID);
                    ViewBag.productID = new SelectList(db.Inventories, "productID", "productQuantity", product.productID);
                    ViewBag.supplierID = new SelectList(db.Suppliers, "supplierID", "supplierName", product.supplierID);
                    return RedirectToAction("Index");
            }

            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Sửa thất bại');</script>";
                ViewBag.categoryID = new SelectList(db.SubCategories, "subcategoryID", "subcategoryName", product.subcategoryID);
                ViewBag.productID = new SelectList(db.Inventories, "productID", "productQuantity", product.productID);
                ViewBag.supplierID = new SelectList(db.Suppliers, "supplierID", "supplierName", product.supplierID);
                return View(product);
    }
}

        // GET: Products/Delete/5
        [Authorize]
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Product product = db.Products.Find(id);
            try
            {
                db.Products.Remove(product);
                db.SaveChanges();
                ViewBag.ErrorMessege = "<script>" +
                "alert('Xóa thành công');" +
                "window.location.href = '../Index'" +
                "</script>";
                return View();
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Xóa thất bại');</script>";
                return View(product);
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

        public JsonResult GetSearchValue(string search)
        {
            ((IObjectContextAdapter)db).ObjectContext.ContextOptions.ProxyCreationEnabled = false;
            List<string> allsearch = new List<string>();
            allsearch = db.Products.Where(x => x.productName.Contains(search)).Select(x => x.productName).ToList();
            allsearch.AddRange(db.Suppliers.Where(x => x.supplierName.Contains(search)).Select(x => x.supplierName).ToList());
            allsearch.AddRange(db.Users.Where(x => x.username.Contains(search)).Select(x => x.username).ToList());
            return new JsonResult { Data = allsearch, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public string codeGenerate(Product product, string supplierName)
        {
            string result = "";
            for (int i = 0; i < product.productName.Length; i++)
            {
                if (i == 0 && product.productName[i].ToString() != " ")
                {
                    result += product.productName[i];
                    continue;
                }

                if (product.productName[i - 1].ToString() == " " && product.productName[i].ToString() != " ")
                {
                    result += product.productName[i];
                }
            }
            result += "_";
            for (int i = 0; i < product.productColor.Length; i++)
            {
                if (i == 0 && product.productColor[i].ToString() != " ")
                {
                    result += product.productColor;
                    continue;
                }

                if (product.productColor[i - 1].ToString() == " " && product.productColor[i].ToString() != " ")
                {
                    result += product.productColor;
                }
            }
            result += "_" + product.productSize;
            result += "_" + supplierName;
            return result.ToUpper();
        }

        public string getSupplierName(List<Supplier> suppliers, int id)
        {
            string name = "";
            foreach (var item in suppliers)
            {
                if (id == item.supplierID)
                {
                    name = item.supplierName;
                }
            }
            return name;
        }

        public ActionResult Active(string id, string status)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product != null)
            {
                bool result = Update(product, status);
                if (result)
                {
                    return RedirectToAction("Index");
                }
            }
            return View("Index");
        }

        public bool Update(Product entity, string status)
        {
            try
            {
                var product = db.Products.Find(entity.productID);
                product.productStatus = status;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Đổi trạng thái thất bại');</script>";
                return false;
            }

        }

        [Authorize]
        public ActionResult EditProductPrice()
        {
            var product = db.Products.ToList();
            return View(product);
        }

        [HttpPost]
        public String EditProductPrice(List<String> products, double exportPrice)
        {
            if (ModelState.IsValid)
            {
                if (products.Count() == 0)
                {
                    return "Update lỗi";
                }
                else
                {
                    foreach (var i in products)
                    {
                        var c = db.Products.Where(a => a.productID.Equals(i)).FirstOrDefault();
                        if (c != null)
                        {
                            c.exportPrice = exportPrice;
                        }
                        db.SaveChanges();
                    }
                    return "Update thành công";
                }
            }
            return "Update lỗi";
        }

        public ActionResult EditProductImage()
        {
            var product = db.Products.ToList();
            return View(product);
        }

        [HttpPost]
        public String EditProductImage(List<String> products, string productIcon)
        {
            if (ModelState.IsValid)
            {
                if (products.Count() == 0)
                {
                    return "Update lỗi";
                }
                else
                {
                    foreach (var i in products)
                    {
                        var c = db.Products.Where(a => a.productID.Equals(i)).FirstOrDefault();
                        if (c != null)
                        {
                            string fileName = Path.GetFileNameWithoutExtension(c.ImageFile.FileName);
                            string extension = Path.GetExtension(c.ImageFile.FileName);
                            fileName = fileName  + extension;
                            c.productIcon = fileName;
                            fileName = Path.Combine(Server.MapPath("~/Img/"), fileName);
                            c.ImageFile.SaveAs(fileName);
                        }
                        db.SaveChanges();
                    }
                    return "Update thành công";
                }
            }
            return "Update lỗi";
        }
    }
}
