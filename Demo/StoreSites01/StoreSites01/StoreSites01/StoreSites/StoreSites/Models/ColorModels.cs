using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StoreSites.Models
{
    public class ColorModels
    {
        public string color { get; set; }
        public List<SizeAndInvenModel> sizeinven { get; set; }
        public ColorModels()
        {
            sizeinven = new List<SizeAndInvenModel>();
        }
    }
}