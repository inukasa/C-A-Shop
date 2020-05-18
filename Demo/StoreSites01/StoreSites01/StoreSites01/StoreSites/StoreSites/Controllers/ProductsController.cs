using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using StoreSites.Models;
using PagedList.Mvc;
using PagedList;

namespace StoreSites.Controllers
{
    public class ProductsController : Controller
    {
        // GET: Products
        public ActionResult Index(int page = 1, int pagesize = 12)
        {
            using (Entities1 db = new Entities1())
            {
                if (Session["username"] == null)
                {

                    FormsAuthentication.SignOut();
                }
                List<Product> listP = db.Products.Where(x => x.productStatus.Equals("Active") && x.exportPrice != null).ToList();
                List<Product> listP2 = new List<Product>();
                foreach (Product pr in listP)
                {
                    var contain = false;
                    foreach (Product pr2 in listP2)
                    {
                        if (pr2.productName.ToLower().Equals(pr.productName.ToLower()) && pr2.supplierID == pr.supplierID)
                        {
                            contain = true;
                        }
                    }
                    if (contain == false)
                    {
                        listP2.Add(pr);
                    }
                }
                return View(listP2.OrderByDescending(x => x.subcategoryID).ToPagedList(page, pagesize));
            }

        }

        public ActionResult Contact()
        {
            return View();

        }

        [Authorize]
        public ActionResult CartList(int id)
        {
            using (Entities1 db = new Entities1())
            {
                var errMes = TempData["ErrorMes"] as string;
                ViewBag.ErrorMessege = errMes;
                return View(db.ShoppingCarts.Where(x => x.userID == id).ToList());
            }

        }

        // GET: Products/Details/5
        public ActionResult Details(String id)
        {
            using (Entities1 db = new Entities1())
            {
                ViewBag.ID = id;
                ViewBag.ProName = db.Products.Where(y => y.productID.Equals(id)).FirstOrDefault().productName;
                List<ColorModels> listC = new List<ColorModels>();
                ColorAndSizeModel casm = new ColorAndSizeModel();

                List<Product> listPro = db.Products.Where(x => x.productName.ToLower().Equals(db.Products.Where(y => y.productID.Equals(id)).FirstOrDefault().productName.ToLower()) && x.supplierID == db.Products.Where(z => z.productID.Equals(id) && x.productStatus.Equals("Active")).FirstOrDefault().supplierID).ToList();
                bool flagC = true;
                foreach (Product pro in listPro)
                {
                    if (listC.Count == 0)
                    {
                        ColorModels col = new ColorModels();
                        col.color = pro.productColor;
                        List<Product> listProC = db.Products.Where(x => x.productName.ToLower().Equals(db.Products.Where(y => y.productID.Equals(id)).FirstOrDefault().productName.ToLower()) && x.productColor.Equals(pro.productColor) && x.supplierID == db.Products.Where(z => z.productID.Equals(id) && x.productStatus.Equals("Active")).FirstOrDefault().supplierID).ToList();
                        foreach (Product pr in listProC)
                        {
                            SizeAndInvenModel sai = new SizeAndInvenModel();
                            sai.size = pr.productSize;
                            sai.inven = db.Inventories.Where(x => x.productID.Equals(db.Products.Where(y => y.productName.Equals(pr.productName) && y.productColor.Equals(pro.productColor) && y.productSize.Equals(pr.productSize)).FirstOrDefault().productID)).FirstOrDefault().productQuantity;
                            col.sizeinven.Add(sai);
                        }
                        listC.Add(col);
                    }
                    else
                    {
                        foreach (ColorModels c in listC)
                        {
                            if (pro.productColor.Equals(c.color))
                            {
                                flagC = false;
                            }
                        }
                        if (flagC == true)
                        {
                            ColorModels col = new ColorModels();
                            col.color = pro.productColor;
                            List<Product> listProC = db.Products.Where(x => x.productName.ToLower().Equals(db.Products.Where(y => y.productID.Equals(id)).FirstOrDefault().productName.ToLower()) && x.productColor.Equals(pro.productColor) && x.supplierID == db.Products.Where(z => z.productID.Equals(id) && x.productStatus.Equals("Active")).FirstOrDefault().supplierID).ToList();
                            foreach (Product pr in listProC)
                            {
                                SizeAndInvenModel sai = new SizeAndInvenModel();
                                sai.size = pr.productSize;
                                sai.inven = db.Inventories.Where(x => x.productID.Equals(db.Products.Where(y => y.productColor.Equals(pro.productColor) && y.productSize.Equals(pr.productSize)).FirstOrDefault().productID)).FirstOrDefault().productQuantity;
                                col.sizeinven.Add(sai);
                            }
                            listC.Add(col);
                        }
                    }
                }
                foreach (ColorModels cm in listC)
                {
                    casm.listColorASize.Add(cm);
                }
                ViewBag.lC = listC;
                ViewBag.price = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault().exportPrice;
                ViewBag.linkImg = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault().productIcon;
                ViewBag.Feedback = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault().productFeedback;
                ViewBag.Des = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault().productDescription;
                ViewBag.Rate = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault().productRate;
                Session["pname"] = db.Products.Where(y => y.productID.Equals(id)).FirstOrDefault().productName;
                Session["pid"] = id;
                var errMes = TempData["ErrorMes"] as string;
                ViewBag.ErrorMessege = errMes;
                return View(casm);
            }
        }
        [Authorize]
        [HttpPost]
        public ActionResult AddCart()
        {
            using (Entities1 db = new Entities1())
            {
                var uid = 1;
                var color = Request["grb1"].ToString();
                var size = Request["fs" + color].ToString();
                string getQuan = Request["quantitybox"].ToString();

                if (Session["username"] != null)
                {
                    var pname = Session["pname"].ToString();
                    var pid = db.Products.Where(y => y.productName.Equals(pname) && y.productColor.Equals(color) && y.productSize.Equals(size)).FirstOrDefault().productID;
                    bool validQuan = quanValid(getQuan, db.Inventories.Where(x => x.productID.Equals(pid)).FirstOrDefault().productQuantity);
                    if (validQuan == true)
                    {
                        var sesUser = Session["username"].ToString();
                        uid = db.Users.Where(x => x.username.Equals(sesUser)).FirstOrDefault().userID;
                        var quantity = Convert.ToInt32(getQuan);
                        int stock = db.Inventories.Where(x => x.productID.Equals(pid)).FirstOrDefault().productQuantity;
                        List<ShoppingCart> listCart = db.ShoppingCarts.Where(x => x.userID.Equals(uid)).ToList();
                        bool cartExistProduct = false;
                        foreach (ShoppingCart sc in listCart)
                        {
                            if (sc.productID.Equals(pid))
                            {
                                cartExistProduct = true;
                            }
                        }
                        if (cartExistProduct == false)
                        {
                            if (checkStock(quantity, stock) == true)
                            {
                                List<ShoppingCart> spCart = db.ShoppingCarts.ToList();
                                if (spCart.Count > 0)
                                {
                                    ShoppingCart sp = new ShoppingCart();
                                    sp.cartID = spCart[spCart.Count - 1].cartID + 1;
                                    sp.userID = uid;
                                    sp.productID = pid;
                                    sp.productQuantityOrder = quantity;
                                    sp.productPrice = (float)db.Products.Where(x => x.productName.ToLower().Equals(pname.ToLower())).FirstOrDefault().exportPrice;
                                    sp.productTotalPrice = sp.productQuantityOrder * sp.productPrice;
                                    db.ShoppingCarts.Add(sp);
                                    db.SaveChanges();
                                }
                                else
                                {
                                    ShoppingCart sp = new ShoppingCart();
                                    sp.cartID = 1;
                                    sp.userID = uid;
                                    sp.productID = pid;
                                    sp.productQuantityOrder = quantity;
                                    sp.productPrice = (float)db.Products.Where(x => x.productName.ToLower().Equals(pname.ToLower())).FirstOrDefault().exportPrice;
                                    sp.productTotalPrice = sp.productQuantityOrder * sp.productPrice;
                                    db.ShoppingCarts.Add(sp);
                                    db.SaveChanges();
                                }
                                return RedirectToAction("CartList", "Products", new { id = uid });
                            }
                            else
                            {
                                string pid1 = db.Products.Where(x => x.productName.Equals(pname)).FirstOrDefault().productID;
                                TempData["ErrorMes"] = "<script>alert('Số lượng nhập vào phải bé hơn hoặc bằng số lượng hàng còn lại trong kho');</script>";
                                return RedirectToAction("Details", "Products", new { id = pid });
                            }
                        }
                        else
                        {
                            if (checkStock(quantity, stock) == true)
                            {
                                List<ShoppingCart> spCart = db.ShoppingCarts.Where(x => x.userID == uid).ToList();
                                ShoppingCart sp1 = new ShoppingCart();
                                sp1.productQuantityOrder = quantity;
                                foreach (ShoppingCart sc in spCart)
                                {
                                    if (sc.productID.Equals(pid))
                                    {
                                        sc.productQuantityOrder += sp1.productQuantityOrder;
                                        if (quanValid(sc.productQuantityOrder.ToString(), db.Inventories.Where(x => x.productID.Equals(pid)).FirstOrDefault().productQuantity))
                                        {
                                            sc.productTotalPrice = sc.productQuantityOrder * sc.productPrice;
                                            var local = db.Set<ShoppingCart>().Local.FirstOrDefault(f => f.cartID == sc.cartID);
                                            if (local != null)
                                            {
                                                db.Entry(local).State = EntityState.Detached;
                                            }
                                            db.Entry(sc).State = EntityState.Modified;
                                            db.SaveChanges();
                                        }
                                        else
                                        {
                                            TempData["ErrorMes"] = "<script>alert('Số lượng sản phẩm đã vượt quá số hàng còn trong kho');</script>";
                                            return RedirectToAction("Details", "Products", new { id = pid });
                                        }
                                        

                                    }
                                }
                                return RedirectToAction("CartList", "Products", new { id = uid });
                            }
                            else
                            {
                                string pid1 = db.Products.Where(x => x.productName.Equals(pname)).FirstOrDefault().productID;
                                TempData["ErrorMes"] = "<script>alert('Số lượng nhập vào phải bé hơn hoặc bằng số lượng hàng còn lại trong kho');</script>";
                                return RedirectToAction("Details", "Products", new { id = pid });
                            }
                        }

                    }
                    else
                    {
                        pname = Session["pname"].ToString();
                        using (Entities1 db2 = new Entities1())
                        {
                            pid = db2.Products.Where(x => x.productName.Equals(pname)).FirstOrDefault().productID;
                            TempData["ErrorMes"] = "<script>alert('Số lượng nhập vào là số tự nhiên lớn hơn 0 và nhỏ hơn hoặc bằng số lượng hàng còn lại trong kho');</script>";
                            return RedirectToAction("Details", "Products", new { id = pid });
                        }
                    }
                }
                else
                {
                    return RedirectToAction("LoginA", "Login");
                }
            }
        }
        [Authorize]
        public ActionResult Decrease(int id, ShoppingCart cart)
        {
            using (Entities1 db = new Entities1())
            {
                if (db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productQuantityOrder == 1)
                {
                    TempData["ErrorMes"] = "<script>alert('Số lượng mặt hàng không thể bé hơn 1');</script>";
                    return RedirectToAction("CartList", "Products", new { id = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().userID });
                }
                else if (db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productQuantityOrder > 1  )
                {
                    cart.cartID = id;
                    cart.userID = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().userID;
                    cart.productID = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productID;
                    cart.productQuantityOrder = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productQuantityOrder - 1;
                    cart.productPrice = (float)db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productPrice;
                    cart.productTotalPrice = cart.productQuantityOrder * cart.productPrice;
                    var local = db.Set<ShoppingCart>()
                             .Local
                             .FirstOrDefault(f => f.cartID == id);
                    if (local != null)
                    {
                        db.Entry(local).State = EntityState.Detached;
                    }
                    db.Entry(cart).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("CartList", "Products", new { id = cart.userID });
                }
                else
                {
                    TempData["ErrorMes"] = "<script>alert('Số lượng mặt hàng không thể bé hơn 1 ');</script>";
                    return RedirectToAction("CartList", "Products", new { id = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().userID });
                }

            }
        }
        [Authorize]
        public ActionResult Increase(int id, ShoppingCart cart) 
        {
            using (Entities1 db = new Entities1())
            {
                if ( db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productQuantityOrder < db.Inventories.Where(x => x.productID.Equals(db.ShoppingCarts.Where(y => y.cartID == id).FirstOrDefault().productID)).FirstOrDefault().productQuantity)
                {
                    cart.cartID = id;
                    cart.userID = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().userID;
                    cart.productID = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productID;
                    cart.productQuantityOrder = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productQuantityOrder + 1;
                    cart.productPrice = (float)db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().productPrice;
                    cart.productTotalPrice = cart.productQuantityOrder * cart.productPrice;
                    var local = db.Set<ShoppingCart>()
                            .Local
                            .FirstOrDefault(f => f.cartID == id);
                    if (local != null)
                    {
                        db.Entry(local).State = EntityState.Detached;
                    }
                    db.Entry(cart).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("CartList", "Products", new { id = cart.userID });
                }
                else
                {
                    TempData["ErrorMes"] = "<script>alert('Số lượng mặt hàng không thể bé hơn 1 hoặc lớn hơn số lượng còn dư trong cửa hàng đoạn này');</script>";
                    return RedirectToAction("CartList", "Products", new { id = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault().userID });
                }

            }
        }
        [Authorize]
        public ActionResult Delete(int id, ShoppingCart cart)
        {
            using (Entities1 db = new Entities1())
            {

                cart = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault();
                var uid = cart.userID;
                db.ShoppingCarts.Remove(cart);
                db.SaveChanges();
                return RedirectToAction("CartList", "Products", new { id = uid });
            }
        }
        [Authorize]
        public ActionResult Rate(string id)
        {

            try
            {
                using (Entities1 db = new Entities1())
                {
                    string user = Session["username"].ToString();
                    List<Rating> listRate1 = db.Ratings.ToList();
                    if (listRate1.Count > 0)
                    {
                        Rating arate = new Rating();
                        arate.rateID = listRate1[listRate1.Count - 1].rateID + 1;
                        arate.productID = id;
                        arate.userID = db.Users.Where(x => x.username.Equals(user)).FirstOrDefault().userID;
                        db.Ratings.Add(arate);
                        db.SaveChanges();
                        var count = 0;
                        List<Rating> listRate = db.Ratings.ToList();
                        foreach (Rating rate in listRate)
                        {
                            if (rate.productID.Equals(id))
                            {
                                count += 1;
                            }
                        }
                        Product pro = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault();
                        pro.productRate = count;
                        var local = db.Set<Product>()
                                .Local
                                .FirstOrDefault(f => f.productID == id);
                        if (local != null)
                        {
                            db.Entry(local).State = EntityState.Detached;
                        }
                        db.Entry(pro).State = EntityState.Modified;
                        db.SaveChanges();
                        ViewBag.ID = id;
                        return RedirectToAction("Details", "Products", new { id = id });
                    }
                    else
                    {
                        Rating arate = new Rating();
                        arate.rateID = 1;
                        arate.productID = id;
                        arate.userID = db.Users.Where(x => x.username.Equals(user)).FirstOrDefault().userID;
                        db.Ratings.Add(arate);
                        db.SaveChanges();
                        var count = 0;
                        List<Rating> listRate = db.Ratings.ToList();
                        foreach (Rating rate in listRate)
                        {
                            if (rate.productID.Equals(id))
                            {
                                count += 1;
                            }
                        }
                        Product pro = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault();
                        pro.productRate = count;
                        var local = db.Set<Product>()
                                .Local
                                .FirstOrDefault(f => f.productID == id);
                        if (local != null)
                        {
                            db.Entry(local).State = EntityState.Detached;
                        }
                        db.Entry(pro).State = EntityState.Modified;
                        db.SaveChanges();
                        ViewBag.ID = id;
                        return RedirectToAction("Details", "Products", new { id = id });
                    }

                }
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Exeption');</script>";
                return RedirectToAction("Details", "Products", new { id = id });
            }

        }
        [Authorize]
        public ActionResult Unrate(string id)
        {

            try
            {
                using (Entities1 db = new Entities1())
                {
                    string user = Session["username"].ToString();
                    Rating arate = db.Ratings.Where(x => x.productID.Equals(id) && x.userID == db.Users.Where(y => y.username.Equals(user)).FirstOrDefault().userID).FirstOrDefault();
                    db.Ratings.Remove(arate);
                    db.SaveChanges();
                    var count = 0;
                    List<Rating> listRate = db.Ratings.ToList();
                    foreach (Rating rate in listRate)
                    {
                        if (rate.productID.Equals(id))
                        {
                            count += 1;
                        }
                    }
                    Product pro = db.Products.Where(x => x.productID.Equals(id)).FirstOrDefault();
                    pro.productRate = count;
                    var local = db.Set<Product>()
                            .Local
                            .FirstOrDefault(f => f.productID == id);
                    if (local != null)
                    {
                        db.Entry(local).State = EntityState.Detached;
                    }
                    db.Entry(pro).State = EntityState.Modified;
                    db.SaveChanges();
                    ViewBag.ID = id;
                    return RedirectToAction("Details", "Products", new { id = id });
                }
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Exeption');</script>";
                return RedirectToAction("Details", "Products", new { id = id });
            }

        }
        public ActionResult Cate(int id, int page = 1, int pagesize = 12)
        {
            using (Entities1 db = new Entities1())
            {
                if (Session["username"] == null)
                {

                    FormsAuthentication.SignOut();
                }
                List<Product> listP = db.Products.Where(x => x.subcategoryID == id && x.productStatus.Equals("Active") && x.exportPrice != null).ToList();
                List<Product> listP2 = new List<Product>();
                foreach (Product pr in listP)
                {
                    var contain = false;
                    foreach (Product pr2 in listP2)
                    {
                        if (pr2.productName.ToLower().Equals(pr.productName.ToLower()) && pr2.supplierID == pr.supplierID)
                        {
                            contain = true;
                        }
                    }
                    if (contain == false)
                    {
                        listP2.Add(pr);
                    }
                }
                return View(listP2.OrderByDescending(x => x.productName).ToPagedList(page, pagesize));
            }

        }
        public ActionResult Feedback()
        {
            var feedback = Request["feedback"].ToString();
            using (Entities1 db = new Entities1())
            {
                var pname = Session["pname"].ToString();
                var pid = Session["pid"].ToString();
                List<Product> listPr = db.Products.Where(x => x.productName.ToLower().Equals(pname.ToLower())).ToList();
                foreach (Product prd in listPr)
                {
                    prd.productFeedback = prd.productFeedback + ", " + feedback;
                    var local = db.Set<Product>().Local.FirstOrDefault(f => f.productID == prd.productID);
                    if (local != null)
                    {
                        db.Entry(local).State = EntityState.Detached;
                    }
                    db.Entry(prd).State = EntityState.Modified;
                    db.SaveChanges();
                }

                return RedirectToAction("Details", "Products", new { id = pid });
            }
        }
        public ActionResult Search()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Search(int page = 1, int pagesize = 12)
        {
            string strS = Request["search"].ToString();
            using (Entities1 db = new Entities1())
            {
                List<Product> listP = db.Products.Where(x => x.productName.ToLower().Contains(strS.ToLower()) && x.productStatus.Equals("Active")).ToList();
                List<Product> listP2 = new List<Product>();
                foreach (Product pr in listP)
                {
                    var contain = false;
                    foreach (Product pr2 in listP2)
                    {
                        if (pr2.productName.ToLower().Equals(pr.productName.ToLower()) && pr2.supplierID == pr.supplierID)
                        {
                            contain = true;
                        }
                    }
                    if (contain == false)
                    {
                        listP2.Add(pr);
                    }
                }
                if (listP2.Count > 0)
                {
                    return View(listP2.OrderByDescending(x => x.productName).ToPagedList(page, pagesize));
                }
                else
                {
                    TempData["msg"] = "<script>alert('Không tìm thấy sản phẩm phù hợp');</script>";
                    return RedirectToAction("Index", "Products");
                }
            }
        }

        public bool quanValid(string quan, int stock)
        {
            bool valid;
            if (int.TryParse(quan, out int n) == true)
            {
                int pQuan = Convert.ToInt32(quan);
                if (pQuan > 0 && pQuan < stock + 1)
                {
                    valid = true;
                }
                else
                {
                    valid = false;
                }

            }
            else
            {
                valid = false;
            }
            return valid;
        }

        public bool checkStock(int quan, int stock)
        {
            if (quan > stock)
            {
                return false;
            }
            else
            {
                return true;
            }
        }


    }
}
