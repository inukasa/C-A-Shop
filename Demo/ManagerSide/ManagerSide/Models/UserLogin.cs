using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ManagerSide.Models
{
    public class UserLogin
    {
        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "UserName")]
        public string username { get; set; }
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string password { get; set; }
        public UserLogin(string users, string pass)
        {
            username = users;
            password = pass;
        }
        public UserLogin()
        {

        }
    }
}