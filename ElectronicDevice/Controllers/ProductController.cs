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
        private int pageSize = 9;
        // GET: Product
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Detail(int id_product)
        {
            return View();
        }

        [HttpGet]
        public JsonResult GetDetail(int id_product)
        {
            db.Configuration.ProxyCreationEnabled = false;
            var product = db.Products.Where(p => p.ID_Product == id_product).FirstOrDefault();
            return Json(new { data = product }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetAll(String searchStr, int? page, int? id_category, int? typeOrder)
        {
            db.Configuration.ProxyCreationEnabled = false;
            var listProduct = new List<Product>();
            if (!String.IsNullOrEmpty(searchStr))
            {
                ViewBag.searchStr = searchStr;
                listProduct = db.Products.Where(p => p.Name.Contains(searchStr) && p.Status).ToList();
            }
            else
            {
                listProduct = db.Products.Where(p => p.Status == true).ToList();
            }

            if (id_category!=null)
            {
                listProduct = listProduct.Where(p => p.ID_Category == id_category && p.Status).ToList();
            }

            page = page > 0 ? page : 1;

            int startRecord = (int)(page - 1) * pageSize;
            int totalPage = (int)Math.Ceiling(listProduct.Count() / (float)pageSize);

            ViewBag.currentPage = page;
            ViewBag.totalPage = totalPage;
            ViewBag.id_category = id_category;

            if (typeOrder == null)
            {
                listProduct = listProduct.OrderByDescending(p => p.ID_Product).Skip(startRecord).Take(pageSize).ToList();
            }
            else if (typeOrder == 1)
            {
                listProduct = listProduct.OrderBy(p => p.Price).Skip(startRecord).Take(pageSize).ToList();
            }
            else if (typeOrder == 2)
            {
                listProduct = listProduct.OrderByDescending(p => p.Price).Skip(startRecord).Take(pageSize).ToList();
            }
            else
            {
                listProduct = listProduct.OrderByDescending(p => p.ID_Product).Skip(startRecord).Take(pageSize).ToList();
            }

            return Json(new { data = listProduct, currentPage = page, totalPage = totalPage }, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        public ActionResult _NewProduct()
        {
            var listProduct = db.Products.Where(p => p.Status == true).OrderByDescending(p => p.CreatedDate).Take(6).ToList();
            return PartialView(listProduct);
        }
    }
}