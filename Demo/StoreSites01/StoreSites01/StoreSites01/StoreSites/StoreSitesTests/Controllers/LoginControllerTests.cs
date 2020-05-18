using Microsoft.VisualStudio.TestTools.UnitTesting;
using StoreSites.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StoreSites.Models;

namespace StoreSites.Controllers.Tests
{
    [TestClass()]
    public class LoginControllerTests
    {
        private LoginController loginController = new LoginController();
        
        [TestMethod()]
        public void IsValidTest()
        {
            var user = new UserLoginModels()
            {
                username = "customer",
                password = "111111"
            };

            Assert.AreEqual(true, loginController.IsValid(user));
        }

        [TestMethod()]
        public void IsValidTest2()
        {
            var user = new UserLoginModels()
            {
                username = "manager",
                password = "111111"
            };

            Assert.AreEqual(true, loginController.IsValid(user));
        }

        [TestMethod()]
        public void IsValidTest3()
        {
            var user = new UserLoginModels()
            {
                username = "customerdemo123123",
                password = "123123"
            };

            Assert.AreEqual(false, loginController.IsValid(user));
        }

        [TestMethod()]
        public void IsValidTest4()
        {
            var user = new UserLoginModels()
            {
                username = "manager2",
                password = "111111"
            };

            Assert.AreEqual(false, loginController.Login(user, String.Empty));
        }


    }
}