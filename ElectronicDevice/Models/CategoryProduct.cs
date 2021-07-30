using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElectronicDevice.Models
{
    public class CategoryProduct
    {
        public List<Product> product { get; set; }
        public List<Category> category { get; set; }
    }
}