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

namespace ElectronicDevice.Areas.Admin.Controllers
{
    public class CategoryController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();

        // GET: Admin/Category
        public ActionResult Index()
        {
            var listCategory = db.Categories.Select(c => c);
            return View(listCategory);
        }

        

        [HttpPost]
        public ActionResult AddProductCategory(CategoryDTO category)
        {
            
            Category cate = new Category();
            if (category.Base64 != null) {
                string path = HttpContext.Server.MapPath("~/wwwroot/imageUpload/");
                //string filename = DateTime.Now.ToString("yyyyMMddTHHmmss") + ".jpg";
                if(!UploadFileUtil.SaveFile(category.Base64, category.Icon, path))
                {
                    return null;
                }
            }
            cate.Name = category.Name;
            cate.Icon = category.Icon;
            cate.Status = category.Status;
            if (category.ID_Category == 0)
            {
                db.Categories.Add(cate);
            }
            else
            {
                cate.ID_Category = category.ID_Category;
                db.Entry(cate).State = EntityState.Modified;
            }
            
            db.SaveChanges();

            return Json(cate, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteProductCategory(int id)
        {
            Category category = db.Categories.Find(id);
            db.Categories.Remove(category);
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }


    }
}