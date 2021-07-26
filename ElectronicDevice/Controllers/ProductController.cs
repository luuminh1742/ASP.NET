using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Controllers
{
    public class ProductController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        // GET: Product
        public ActionResult Index()
        {
            var listProduct = db.Products.Select(p => p);
            return View(listProduct);
        }
        public ActionResult Detail ()
        {
            return View();
        }
    }
}