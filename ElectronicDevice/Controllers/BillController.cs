using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Controllers
{
    public class BillController : Controller
    {
        // GET: Bill
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Buy(int? id_product, int? id_account)
        {
            ViewBag.cart = db.Carts.Where(c => c.ID_Product == (int)id_product && c.ID_Account == (int)id_account).FirstOrDefault();
            ViewBag.status = "BuyNow";
            return View();
        }

        public ActionResult Buy(List<int> list_id_product, int? id_account)
        {
            //ViewBag.cart = db.Carts.Where(c => c.ID_Product == (int)id_product && c.ID_Account == (int)id_account).FirstOrDefault();
            ViewBag.status = "BuyFromCart";
            return View();
        }
    }
}