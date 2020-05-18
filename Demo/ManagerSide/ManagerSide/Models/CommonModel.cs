using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerSide.Models
{
    public class CommonModel
    {
        public IEnumerable<Inventory> restOfProduct { get; set; }
        public List<ProductSold<int, string>> productSold { get; set; }

        public int maleUser { get; set; }

        public int femaleUser { get; set; }

        public int otherUser { get; set; }

        public ProductSold<int, string> top1RateProduct { get; set; }

        public ProductSold<int, string> top2RateProduct { get; set; }

        public ProductSold<int, string> top3RateProduct { get; set; }

        public IEnumerable<Product> maleProducts { get; set; }

        public IEnumerable<Product> femaleProducts { get; set; }

        public IEnumerable<Product> otherProducts { get; set; }

        public IEnumerable<Product> allProducts { get; set; }

        public IEnumerable<Supplier> suppliers { get; set; }

        public IEnumerable<User> users { get; set; }
        public IEnumerable<User> usersCustomer { get; set; }

        public IEnumerable<ShippingInfor> orderByDateCreated { get; set; }
        public IEnumerable<Order> orderByDateConfirm { get; set; }
        public IEnumerable<Order> orderDetailList { get; set; }

        public IEnumerable<User> banUserCustomer { get; set; }
        public IEnumerable<User> notBanUserCustomer { get; set; }

        public IEnumerable<User> banUserStaff { get; set; }
        public IEnumerable<User> notBanUserStaff { get; set; }

        public IEnumerable<Product> activeProduct { get; set; }

        public IEnumerable<Product> inactiveProduct { get; set; }

        public IEnumerable<SubCategory> subCategories { get; set; }

        public List<MonthlyRevenue> revenue { get; set; }
    }
}