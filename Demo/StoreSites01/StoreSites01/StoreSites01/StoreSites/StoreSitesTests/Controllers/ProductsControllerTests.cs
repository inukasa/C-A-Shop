using Microsoft.VisualStudio.TestTools.UnitTesting;
using StoreSites.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StoreSites.Controllers.Tests
{
    [TestClass()]
    public class ProductsControllerTests
    {
        ProductsController productsController = new ProductsController();

        [TestMethod()]
        public void quanValidTest()
        {
            Assert.AreEqual(true, productsController.quanValid("10", 12));
        }

        [TestMethod()]
        public void quanValidTest1()
        {
            Assert.AreEqual(false, productsController.quanValid("-1", 12));
        }
        
        [TestMethod()]
        public void quanValidTest2()
        {
            Assert.AreEqual(true, productsController.quanValid("1", 12));
        }

        [TestMethod()]
        public void checkStockTest()
        {
            Assert.AreEqual(true, productsController.checkStock(1, 12));
        }

        [TestMethod()]
        public void checkStockTest2()
        {
            Assert.AreEqual(false, productsController.checkStock(13, 12));
        }
    }
}