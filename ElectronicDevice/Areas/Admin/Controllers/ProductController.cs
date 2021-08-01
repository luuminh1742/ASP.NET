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
            listProduct = listProduct.OrderByDescending(p => p.ID_Product);

            ViewBag.Category = new SelectList(db.Categories, "ID_Category", "Name");

            int pageSize = 8;  //Kích  thước  trang 
            int pageNumber = (page ?? 1);

            return View(listProduct.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Edit(int? ProductId)
        {
            
            if (ProductId != null)
            {
                ViewBag.MyAction = "Update";
                ViewBag.MyTitle = "Cập nhật sản phẩm";
                Product product = db.Products.Where(p => p.ID_Product == ProductId).SingleOrDefault();

                ViewBag.Category = new SelectList(db.Categories, "ID_Category", "Name",product.ID_Category);
                return View(product);
            }
            ViewBag.Category = new SelectList(db.Categories, "ID_Category", "Name");
            ViewBag.MyTitle = "Thêm sản phẩm";
            ViewBag.MyAction = "Create";
            return View();
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
            
            if (product.ID_Product == 0)
            {
                mapDataProduct(product, pro);
                pro.CreatedDate = DateTime.Now;
                pro.CreatedBy = Session["FullName"].ToString();
                db.Products.Add(pro);
            }
            else
            {
                pro = db.Products.Where(p => p.ID_Product == product.ID_Product).SingleOrDefault();
                mapDataProduct(product, pro);
                pro.ModifiedDate = DateTime.Now;
                pro.ModifiedBy = Session["FullName"].ToString();
                db.Entry(pro).State = EntityState.Modified;
            }
            db.SaveChanges();

            return Json(pro, JsonRequestBehavior.AllowGet);
        }

        private void mapDataProduct(ProductDTO productDTO,Product product)
        {
            product.ID_Category = productDTO.ID_Category;
            product.Name = productDTO.Name;
            product.Image = productDTO.Image;
            product.Price = productDTO.Price;
            product.Model = productDTO.Model;
            product.Amount = productDTO.Amount;
            product.Guarantee = productDTO.Guarantee;
            product.Origin = productDTO.Origin;
            product.Discount = productDTO.Discount;
            product.ShortDescription = productDTO.ShortDescription;
            product.Detail = productDTO.Detail;
            product.Status = productDTO.Status;
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