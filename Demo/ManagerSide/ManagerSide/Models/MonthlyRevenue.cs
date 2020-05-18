using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerSide.Models
{
    public class MonthlyRevenue
    {
        public int month;

        public double revenue;

        public MonthlyRevenue(int month, double revenue)
        {
            this.month = month;
            this.revenue = revenue;
        }
    }
}