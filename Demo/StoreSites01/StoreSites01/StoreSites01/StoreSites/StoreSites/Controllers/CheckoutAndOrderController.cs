﻿using StoreSites.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace StoreSites.Controllers
{
    public class CheckoutAndOrderController : Controller
    {
        // GET: CheckoutAndOrder
        [Authorize]
        public ActionResult Checkout()
        {
            var username = Session["username"].ToString();

            using (Entities1 db = new Entities1())
            {
                var uid = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID;
                return View(db.ShoppingCarts.Where(x => x.userID == uid).ToList());
            }
        }
        [Authorize]
        public ActionResult Delete(int id, ShoppingCart cart)
        {
            using (Entities1 db = new Entities1())
            {

                cart = db.ShoppingCarts.Where(x => x.cartID == id).FirstOrDefault();
                db.ShoppingCarts.Remove(cart);
                db.SaveChanges();
                return RedirectToAction("Checkout", "CheckoutAndOrder");
            }
        }
        [Authorize]
        [HttpPost]
        public ActionResult Order(FormCollection form)
        {
            string address = form["Address"].ToString();
            string email = form["Email"].ToString();
            string phone = form["Phone"].ToString();
            string checkValid = checkOrderInfor(email, phone);
            if (checkValid == "Succeed")
            {
                Order od = new Order();
                ShippingInfor si = new ShippingInfor();
                string username = Session["username"].ToString();
                using (Entities1 db = new Entities1())
                {

                    List<Order> listOrder = db.Orders.ToList();
                    List<OrderDetail> listOrderDetails = db.OrderDetails.ToList();
                    List<ShoppingCart> listCart = db.ShoppingCarts.ToList();
                    List<ShippingInfor> listShipping = db.ShippingInfors.ToList();
                    float totalPrice = 0;
                    foreach (ShoppingCart sc in listCart)
                    {
                        if (sc.userID == db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID)
                        {
                            totalPrice += (float)sc.productTotalPrice;
                        }
                    }
                    if (listOrder.Count == 0)
                    {
                        od.orderID = 1;
                        od.userID = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID;
                        od.orderTotalPrice = totalPrice;
                        od.dateCreate = DateTime.Now.ToString();
                        od.dateConfirm = "Chưa xác nhận";
                        od.orderStatus = "Đang chờ xử lý";
                        db.Orders.Add(od);
                        db.SaveChanges();
                    }
                    else
                    {
                        od.orderID = listOrder[listOrder.Count - 1].orderID + 1;
                        od.userID = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID;
                        od.orderTotalPrice = totalPrice;
                        od.dateCreate = DateTime.Now.ToString();
                        od.dateConfirm = "Chưa xác nhận";
                        od.orderStatus = "Đang chờ xử lý";
                        db.Orders.Add(od);
                        db.SaveChanges();
                    }

                    foreach (ShoppingCart sc in listCart)
                    {
                        List<OrderDetail> lodt = db.OrderDetails.ToList();
                        if (sc.userID == db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID)
                        {
                            if (lodt.Count > 0)
                            {
                                OrderDetail odt = new OrderDetail()
                                {
                                    orderDetailID = lodt[lodt.Count - 1].orderDetailID + 1,
                                    orderID = od.orderID,
                                    productName = db.Products.Where(x => x.productID.Equals(sc.productID)).FirstOrDefault().productName,
                                    productQuantityOrder = sc.productQuantityOrder,
                                    productTotalPrice = sc.productTotalPrice,
                                    productID = sc.productID
                                };
                                Inventory iv = db.Inventories.Where(x => x.productID.Equals(sc.productID)).FirstOrDefault();
                                iv.productQuantity = iv.productQuantity - sc.productQuantityOrder;
                                var local = db.Set<Inventory>()
                             .Local
                             .FirstOrDefault(f => f.productID == sc.productID);
                                if (local != null)
                                {
                                    db.Entry(local).State = EntityState.Detached;
                                }
                                db.Entry(iv).State = EntityState.Modified;
                                db.SaveChanges();
                                db.OrderDetails.Add(odt);
                                db.SaveChanges();
                            }
                            else
                            {
                                OrderDetail odt = new OrderDetail()
                                {
                                    orderDetailID = 1,
                                    orderID = od.orderID,
                                    productName = db.Products.Where(x => x.productID.Equals(sc.productID)).FirstOrDefault().productName,
                                    productQuantityOrder = sc.productQuantityOrder,
                                    productTotalPrice = sc.productTotalPrice,
                                    productID = sc.productID
                                };
                                Inventory iv = db.Inventories.Where(x => x.productID.Equals(sc.productID)).FirstOrDefault();
                                iv.productQuantity = iv.productQuantity - sc.productQuantityOrder;
                                var local = db.Set<Inventory>()
                             .Local
                             .FirstOrDefault(f => f.productID == sc.productID);
                                if (local != null)
                                {
                                    db.Entry(local).State = EntityState.Detached;
                                }
                                db.Entry(iv).State = EntityState.Modified;
                                db.SaveChanges();
                                db.OrderDetails.Add(odt);
                                db.SaveChanges();
                            }
                        }
                    }
                    if (listShipping.Count == 0)
                    {
                        si.shipID = 1;
                        si.orderID = od.orderID;
                        si.shipPhone = phone;
                        si.address = address;
                        si.shipName = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().fullname;
                        si.dateShip = null;
                        db.ShippingInfors.Add(si);
                        db.SaveChanges();
                    }
                    else
                    {
                        si.shipID = listShipping[listShipping.Count - 1].shipID + 1;
                        si.orderID = od.orderID;
                        si.shipPhone = phone;
                        si.address = address;
                        si.shipName = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().fullname;
                        si.dateShip = null;
                        db.ShippingInfors.Add(si);
                        db.SaveChanges();
                    }
                    foreach (ShoppingCart sc in listCart)
                    {
                        if (sc.userID == db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID)
                        {
                            db.ShoppingCarts.Remove(sc);
                            db.SaveChanges();
                        }

                    }
                    return RedirectToAction("ListOrder", "CheckoutAndOrder", new { id = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID });
                }
            }
            else
            {
                TempData["msg"] = "<script>alert('" + checkValid + "');</script>";
                return RedirectToAction("Checkout", "CheckoutAndOrder");
            }

        }
        public string checkOrderInfor(string email, string phone)
        {
            string notice;
            string strRegexEmail = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
         @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
         @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            string strRegexPhone = @"0(\d{9})";
            Regex rgEmail = new Regex(strRegexEmail);
            Regex rgPhone = new Regex(strRegexPhone);
            if (rgEmail.IsMatch(email))
            {
                if (rgPhone.IsMatch(phone))
                {
                    notice = "Succeed";
                }
                else
                {
                    notice = "Phone không hợp lệ !";
                }

            }
            else
            {
                notice = "Email không hợp lệ !";
            }
            return notice;
        }
        [Authorize]
        public ActionResult ListOrder(int id)
        {
            using (Entities1 db = new Entities1())
            {

                return View(db.Orders.Where(x => x.userID == id).ToList());
            }
        }
        [Authorize]
        public ActionResult CancelOrder(int id)
        {
            using (Entities1 db = new Entities1())
            {
                string username = Session["username"].ToString();
                var uid = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID;
                Order od = db.Orders.Where(x => x.orderID == id).FirstOrDefault();
                List<OrderDetail> listODT = db.OrderDetails.Where(x => x.orderID == id).ToList();
                ShippingInfor si = db.ShippingInfors.Where(x => x.orderID == id).FirstOrDefault();
                db.ShippingInfors.Remove(si);
                db.SaveChanges();
                foreach (OrderDetail odt in listODT)
                {
                    db.OrderDetails.Remove(odt);
                    db.SaveChanges();
                }
                db.Orders.Remove(od);
                db.SaveChanges();
                return RedirectToAction("ListOrder", "CheckoutAndOrder", new { id = db.Users.Where(x => x.username.Equals(username)).FirstOrDefault().userID });
            }
        }
    }
}