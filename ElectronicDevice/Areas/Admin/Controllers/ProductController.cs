using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using ElectronicDevice.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace ElectronicDevice.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]
    public class ProductController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();

        // GET: Admin/Product
        public ActionResult Index(int? page)
        {
            var listProduct = db.Products.Select(p => p);
            listProduct = listProduct.OrderBy(p => p.ID_Product);

            ViewBag.Category = new SelectList(db.Categories, "ID_Category", "Name");

            int pageSize = 8;  //Kích  thước  trang 
            int pageNumber = (page ?? 1);

            return View(listProduct.ToPagedList(pageNumber, pageSize));
        }

        [HttpPost]
        public ActionResult AddProducts(ProductDTO product)
        {
            Product pro = new Product();

            if (product.Base64 != null)
            {
                string path = HttpContext.Server.MapPath("~/wwwroot/imageUpload/");
                //string filename = DateTime.Now.ToString("yyyyMMddTHHmmss") + ".jpg";
                if (!UploadFileUtil.SaveFile(product.Base64, product.Image, path))
                {
                    return null;
                }
            }
            pro.ID_Category = product.ID_Category;
            pro.Name = product.Name;
            pro.Image = product.Image;
            pro.Price = product.Price;
            pro.Model = product.Model;
            pro.Amount = product.Amount;
            pro.Guarantee = product.Guarantee;
            pro.Origin = product.Origin;
            pro.Discount = product.Discount;
            pro.ShortDescription = product.ShortDescription;
            pro.Detail = product.Detail;
            pro.Status = product.Status;

            //pro.CreatedDate = product.CreatedDate;
            //pro.CreatedBy = product.CreatedBy;
            //pro.ModifiedDate = product.ModifiedDate;
            //pro.ModifiedBy = product.ModifiedBy;
            if (product.ID_Product == 0)
            {
                db.Products.Add(pro);
            }
            else
            {
                pro.ID_Product = product.ID_Product;
                db.Entry(pro).State = EntityState.Modified;
            }

            db.SaveChanges();

            return Json(pro, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteProduct(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}