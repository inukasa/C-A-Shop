using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ManagerSide.Models;

namespace ManagerSide.Controllers
{
    public class IndexController : Controller
    {
        private Entities db = new Entities();

        [Authorize]
        // GET: Index/Index
        public ActionResult Index()
        {
            CommonModel modelForIndex = new CommonModel();
            var maleUser = db.Users.Where(u => u.gender.Equals("Nam") && u.typeID == 3).ToList();
            var femaleUser = db.Users.Where(u => u.gender.Equals("Nữ") && u.typeID == 3).ToList();
            var allUser = db.Users.Where(u => u.typeID == 3).ToList();
            var maleProduct = db.Products.OrderByDescending(p => p.productRate).ToList();
            modelForIndex.maleUser = maleUser.Count();
            modelForIndex.femaleUser = femaleUser.Count();
            modelForIndex.otherUser = allUser.Count() - maleUser.Count() - femaleUser.Count();

            //for (int i = 0; i < maleProduct.Count(); i++)
            //{
            //    if (i == 0)
            //    {
            //        ProductSold<int, string> product = new ProductSold<int, string>();
            //        product.Amount = maleProduct.ElementAt(i).productRate;
            //        product.Key = maleProduct.ElementAt(i).productName;
            //        modelForIndex.top1RateProduct = product;
            //    }
            //    if (i == 1)
            //    {
            //        ProductSold<int, string> product = new ProductSold<int, string>();
            //        product.Amount = maleProduct.ElementAt(i).productRate;
            //        product.Key = maleProduct.ElementAt(i).productName;
            //        modelForIndex.top2RateProduct = product;
            //    }
            //    if (i == 2)
            //    {
            //        ProductSold<int, string> product = new ProductSold<int, string>();
            //        product.Amount = maleProduct.ElementAt(i).productRate;
            //        product.Key = maleProduct.ElementAt(i).productName;
            //        modelForIndex.top3RateProduct = product;
            //    }
            //}
            modelForIndex.revenue = getRevenue();

            return View(modelForIndex);
        }

        public List<MonthlyRevenue> getRevenue()
        {
            List<MonthlyRevenue> revenue = new List<MonthlyRevenue>();
            double revenue1 = 0, revenue2 = 0, revenue3 = 0, revenue4 = 0, revenue5 = 0, revenue6 = 0, revenue7 = 0, revenue8 = 0, revenue9 = 0, revenue10 = 0, revenue11 = 0, revenue12 = 0;
            IEnumerable<OrderDetail> orderDetails = db.OrderDetails.Where(od => od.Order.orderStatus.Equals("Đã xử lý")).ToList();
            
            for (int i = 0; i < orderDetails.Count(); i++)
            {
                string productID = orderDetails.ElementAt(i).productID;
                DateTime dateCreate = DateTime.Parse(orderDetails.ElementAt(i).Order.dateCreate);
                IEnumerable<ImportShipment> importProduct = db.ImportShipments.Where(q => q.productID.Equals(productID)).ToList();
                if (dateCreate.Year == 2020)
                {
                    for (int x = 0; x < importProduct.Count(); x++)
                    {
                        if (dateCreate.Month < importProduct.ElementAt(x).importDate.Value.Month && dateCreate.Year == importProduct.ElementAt(x).importDate.Value.Year)
                        {
                            double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x - 1).importPrice) * orderDetails.ElementAt(i).productQuantityOrder;
                            double price = importProduct.ElementAt(x - 1).importPrice;
                            switch (dateCreate.Month)
                            {
                                case 1:
                                    {
                                        revenue1 += monthRevenue;
                                        break;
                                    }
                                case 2:
                                    {
                                        revenue2 += monthRevenue;
                                        break;
                                    }
                                case 3:
                                    {
                                        revenue3 += monthRevenue;
                                        break;
                                    }
                                case 4:
                                    {
                                        revenue4 += monthRevenue;
                                        break;
                                    }
                                case 5:
                                    {
                                        revenue5 += monthRevenue;
                                        break;
                                    }
                                case 6:
                                    {
                                        revenue6 += monthRevenue;
                                        break;
                                    }
                                case 7:
                                    {
                                        revenue7 += monthRevenue;
                                        break;
                                    }
                                case 8:
                                    {
                                        revenue8 += monthRevenue;
                                        break;
                                    }
                                case 9:
                                    {
                                        revenue9 += monthRevenue;
                                        break;
                                    }
                                case 10:
                                    {
                                        revenue10 += monthRevenue;
                                        break;
                                    }
                                case 11:
                                    {
                                        revenue11 += monthRevenue;
                                        break;
                                    }
                                case 12:
                                    {
                                        revenue12 += monthRevenue;
                                        break;
                                    }
                                default:
                                    {
                                        break;
                                    }
                            }
                        }
                        if (dateCreate.Month == importProduct.ElementAt(x).importDate.Value.Month && dateCreate.Year == importProduct.ElementAt(x).importDate.Value.Year)
                        {
                            double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x).importPrice) * orderDetails.ElementAt(i).productQuantityOrder;
                            switch (dateCreate.Month)
                            {
                                case 1:
                                    {
                                        revenue1 += monthRevenue;
                                        break;
                                    }
                                case 2:
                                    {
                                        revenue2 += monthRevenue;
                                        break;
                                    }
                                case 3:
                                    {
                                        revenue3 += monthRevenue;
                                        break;
                                    }
                                case 4:
                                    {
                                        revenue4 += monthRevenue;
                                        break;
                                    }
                                case 5:
                                    {
                                        revenue5 += monthRevenue;
                                        break;
                                    }
                                case 6:
                                    {
                                        revenue6 += monthRevenue;
                                        break;
                                    }
                                case 7:
                                    {
                                        revenue7 += monthRevenue;
                                        break;
                                    }
                                case 8:
                                    {
                                        revenue8 += monthRevenue;
                                        break;
                                    }
                                case 9:
                                    {
                                        revenue9 += monthRevenue;
                                        break;
                                    }
                                case 10:
                                    {
                                        revenue10 += monthRevenue;
                                        break;
                                    }
                                case 11:
                                    {
                                        revenue11 += monthRevenue;
                                        break;
                                    }
                                case 12:
                                    {
                                        revenue12 += monthRevenue;
                                        break;
                                    }
                                default:
                                    {
                                        break;
                                    }
                            }
                        }
                        if (dateCreate.Month > importProduct.ElementAt(x).importDate.Value.Month && dateCreate.Year == importProduct.ElementAt(x).importDate.Value.Year)
                        {
                            if (x == importProduct.Count() - 1)
                            {
                                double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x).importPrice) * orderDetails.ElementAt(i).productQuantityOrder;
                                switch (dateCreate.Month)
                                {
                                    case 1:
                                        {
                                            revenue1 += monthRevenue;
                                            break;
                                        }
                                    case 2:
                                        {
                                            revenue2 += monthRevenue;
                                            break;
                                        }
                                    case 3:
                                        {
                                            revenue3 += monthRevenue;
                                            break;
                                        }
                                    case 4:
                                        {
                                            revenue4 += monthRevenue;
                                            break;
                                        }
                                    case 5:
                                        {
                                            revenue5 += monthRevenue;
                                            break;
                                        }
                                    case 6:
                                        {
                                            revenue6 += monthRevenue;
                                            break;
                                        }
                                    case 7:
                                        {
                                            revenue7 += monthRevenue;
                                            break;
                                        }
                                    case 8:
                                        {
                                            revenue8 += monthRevenue;
                                            break;
                                        }
                                    case 9:
                                        {
                                            revenue9 += monthRevenue;
                                            break;
                                        }
                                    case 10:
                                        {
                                            revenue10 += monthRevenue;
                                            break;
                                        }
                                    case 11:
                                        {
                                            revenue11 += monthRevenue;
                                            break;
                                        }
                                    case 12:
                                        {
                                            revenue12 += monthRevenue;
                                            break;
                                        }
                                }
                            }
                        }
                    }
                }               
            }
            revenue.Add(new MonthlyRevenue(1, revenue1));
            revenue.Add(new MonthlyRevenue(2, revenue2));
            revenue.Add(new MonthlyRevenue(3, revenue3));
            revenue.Add(new MonthlyRevenue(4, revenue4));
            revenue.Add(new MonthlyRevenue(5, revenue5));
            revenue.Add(new MonthlyRevenue(6, revenue6));
            revenue.Add(new MonthlyRevenue(7, revenue7));
            revenue.Add(new MonthlyRevenue(8, revenue8));
            revenue.Add(new MonthlyRevenue(9, revenue9));
            revenue.Add(new MonthlyRevenue(10, revenue10));
            revenue.Add(new MonthlyRevenue(11, revenue11));
            revenue.Add(new MonthlyRevenue(12, revenue12));
            return revenue;

        }
        //public List<MonthlyRevenue> getRevenue()
        //{
        //    List<MonthlyRevenue> revenue = new List<MonthlyRevenue>();
        //    double revenue1 = 0, revenue2 = 0, revenue3 = 0, revenue4 = 0, revenue5 = 0, revenue6 = 0, revenue7 = 0, revenue8 = 0, revenue9 = 0, revenue10 = 0, revenue11 = 0, revenue12 = 0;
        //    IEnumerable<OrderDetail> orderDetails = db.OrderDetails.Where(od => od.Order.orderStatus.Equals("Đã xử lý")).ToList();
        //    for (int i = 0; i < orderDetails.Count(); i++)
        //    {
        //        //if (i < orderLength)
        //        //{
        //            string productID = orderDetails.ElementAt(i).productID;
        //            DateTime dateCreate = DateTime.Parse(orderDetails.ElementAt(i).Order.dateCreate);
        //            IEnumerable<ImportShipment> importProduct = db.ImportShipments.Where(q => q.productID.Equals(productID)).ToList();
        //            for (int x = 0; x < importProduct.Count(); x++)
        //            {
        //                if (x < importProduct.Count() - 1)
        //                {
        //                    if ((dateCreate.Month > importProduct.ElementAt(x).importDate.Value.Month && dateCreate.Month < importProduct.ElementAt(x + 1).importDate.Value.Month) || dateCreate.Month >= importProduct.ElementAt(x).importDate.Value.Month)
        //                    {
        //                        double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x).importPrice) * orderDetails.ElementAt(i).productQuantityOrder;
        //                        double price = importProduct.ElementAt(x).importPrice;
        //                        switch (dateCreate.Month)
        //                        {
        //                            case 1:
        //                                {
        //                                    revenue1 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 2:
        //                                {
        //                                    revenue2 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 3:
        //                                {
        //                                    revenue3 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 4:
        //                                {
        //                                    revenue4 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 5:
        //                                {
        //                                    revenue5 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 6:
        //                                {
        //                                    revenue6 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 7:
        //                                {
        //                                    revenue7 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 8:
        //                                {
        //                                    revenue8 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 9:
        //                                {
        //                                    revenue9 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 10:
        //                                {
        //                                    revenue10 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 11:
        //                                {
        //                                    revenue11 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 12:
        //                                {
        //                                    revenue12 += monthRevenue;
        //                                    break;
        //                                }
        //                            default:
        //                                {
        //                                    break;
        //                                }
        //                        }
        //                    }
        //                    //if (dateCreate.Month >= importProduct.ElementAt(x).importDate.Value.Month)
        //                    //{
        //                    //    double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x).importPrice) * orderDetails.ElementAt(x).productQuantityOrder;
        //                    //    switch (dateCreate.Month)
        //                    //    {
        //                    //        case 1:
        //                    //            {
        //                    //                revenue1 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 2:
        //                    //            {
        //                    //                revenue2 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 3:
        //                    //            {
        //                    //                revenue3 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 4:
        //                    //            {
        //                    //                revenue4 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 5:
        //                    //            {
        //                    //                revenue5 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 6:
        //                    //            {
        //                    //                revenue6 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 7:
        //                    //            {
        //                    //                revenue7 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 8:
        //                    //            {
        //                    //                revenue8 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 9:
        //                    //            {
        //                    //                revenue9 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 10:
        //                    //            {
        //                    //                revenue10 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 11:
        //                    //            {
        //                    //                revenue11 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        case 12:
        //                    //            {
        //                    //                revenue12 += monthRevenue;
        //                    //                break;
        //                    //            }
        //                    //        default:
        //                    //            {
        //                    //                break;
        //                    //            }
        //                    //}
        //                    //}
        //                    if (dateCreate.Month == importProduct.ElementAt(x + 1).importDate.Value.Month)
        //                    {
        //                        double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x + 1).importPrice) * orderDetails.ElementAt(i).productQuantityOrder;
        //                        switch (dateCreate.Month)
        //                        {
        //                            case 1:
        //                                {
        //                                    revenue1 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 2:
        //                                {
        //                                    revenue2 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 3:
        //                                {
        //                                    revenue3 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 4:
        //                                {
        //                                    revenue4 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 5:
        //                                {
        //                                    revenue5 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 6:
        //                                {
        //                                    revenue6 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 7:
        //                                {
        //                                    revenue7 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 8:
        //                                {
        //                                    revenue8 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 9:
        //                                {
        //                                    revenue9 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 10:
        //                                {
        //                                    revenue10 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 11:
        //                                {
        //                                    revenue11 += monthRevenue;
        //                                    break;
        //                                }
        //                            case 12:
        //                                {
        //                                    revenue12 += monthRevenue;
        //                                    break;
        //                                }
        //                        }
        //                    }
        //            }
        //            }
                        
                
        //        //else
        //        //{
        //        //    string productID = orderDetails.ElementAt(i).productID;
        //        //    DateTime dateCreate = DateTime.Parse(orderDetails.ElementAt(i).Order.dateCreate);
        //        //    IEnumerable<ImportShipment> importProduct = db.ImportShipments.Where(q => q.productID.Equals(productID)).ToList();
        //        //    for (int x = 0; x < importProduct.Count(); x++)
        //        //    {
        //        //        if (x < importProduct.Count() - 1)
        //        //        {
        //        //            if (dateCreate.Month > importProduct.ElementAt(x).importDate.Value.Month)
        //        //            {
        //        //                double monthRevenue = (orderDetails.ElementAt(i).productTotalPrice - importProduct.ElementAt(x).importPrice) * orderDetails.ElementAt(x).productQuantityOrder;
        //        //                switch (dateCreate.Month)
        //        //                {
        //        //                    case 1:
        //        //                        {
        //        //                            revenue1 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 2:
        //        //                        {
        //        //                            revenue2 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 3:
        //        //                        {
        //        //                            revenue3 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 4:
        //        //                        {
        //        //                            revenue4 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 5:
        //        //                        {
        //        //                            revenue5 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 6:
        //        //                        {
        //        //                            revenue6 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 7:
        //        //                        {
        //        //                            revenue7 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 8:
        //        //                        {
        //        //                            revenue8 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 9:
        //        //                        {
        //        //                            revenue9 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 10:
        //        //                        {
        //        //                            revenue10 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 11:
        //        //                        {
        //        //                            revenue11 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                    case 12:
        //        //                        {
        //        //                            revenue12 += monthRevenue;
        //        //                            break;
        //        //                        }
        //        //                }
        //        //            }
        //        //        }
        //        //    }

        //        //}
        //    }
        //    revenue.Add(new MonthlyRevenue(1, revenue1));
        //    revenue.Add(new MonthlyRevenue(2, revenue2));
        //    revenue.Add(new MonthlyRevenue(3, revenue3));
        //    revenue.Add(new MonthlyRevenue(4, revenue4));
        //    revenue.Add(new MonthlyRevenue(5, revenue5));
        //    revenue.Add(new MonthlyRevenue(6, revenue6));
        //    revenue.Add(new MonthlyRevenue(7, revenue7));
        //    revenue.Add(new MonthlyRevenue(8, revenue8));
        //    revenue.Add(new MonthlyRevenue(9, revenue9));
        //    revenue.Add(new MonthlyRevenue(10, revenue10));
        //    revenue.Add(new MonthlyRevenue(11, revenue11));
        //    revenue.Add(new MonthlyRevenue(12, revenue12));
        //    return revenue;
        
        //}
        public int getAmountOfProduct(List<OrderDetail> orderDetails)
        {
            int count = 0;
            foreach (var item in orderDetails)
            {
                count += item.productQuantityOrder;
            }
            return count;
        }

        [Authorize]
        // GET: Index/Search
        public ActionResult Search(string search)
        {
            CommonModel commonModel = new CommonModel();
            if (search.Trim().Length > 0)
            {
                commonModel.allProducts = db.Products.Where(p => p.productName.Contains(search)).ToList();
                commonModel.suppliers = db.Suppliers.Where(s => s.supplierName.Contains(search)).ToList();
                commonModel.users = db.Users.Where(s => s.username.Contains(search)).ToList();
            }
            return View(commonModel);

        }

        [HttpPost]
        [MultipleButton(Name = "action", Argument = "Back")]
        public ActionResult Back()
        {
            return RedirectToAction("Index");
        }

        [Authorize]
        // GET: Users/Edit/5
        public ActionResult EditProfile(int? id)
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

        // POST: Users/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        [MultipleButton(Name = "action", Argument = "EditProfile")]
        public ActionResult EditProfile([Bind(Include = "userID,typeID,username,password,fullname,avatar,ImageFile,address,phone,email,gender,birthday")]User user)
        {
            try
            {
                //if (user.ImageFile != null)
                //{
                //    string fileName = Path.GetFileNameWithoutExtension(user.ImageFile.FileName);
                //    string extension = Path.GetExtension(user.ImageFile.FileName);
                //    fileName = fileName + user.userID + extension;

                //    user.avatar = fileName;
                //    fileName = Path.Combine(Server.MapPath("~/Images/"), fileName);
                //    user.ImageFile.SaveAs(fileName);
                //}
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                ViewBag.ErrorMessege = "<script>" +
                        "alert('Sửa thành công');" +
                        "</script>";
                return View(user);
            }
            catch (Exception)
            {
                ViewBag.ErrorMessege = "<script>alert('Sửa thất bại');</script>";
                return View(user);
    }
}
    }
}

