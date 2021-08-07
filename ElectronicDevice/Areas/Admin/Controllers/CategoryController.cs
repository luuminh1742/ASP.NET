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
    //[Authorize(Roles = "ADMIN")]
    public class CategoryController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();

        // GET: Admin/Category
        public ActionResult Index()
        {
            // Phân quyền cho quản lý sản phẩm
            var idAccount = (int)Session["ID"];
            PermissionDetail permissionDetail = db.PermissionDetails.Where(pd => pd.ID_Account == idAccount
            && pd.Permission.Code.Equals(SystemConstants.PERMISSION_CATEGORIES)).SingleOrDefault();

            if ((bool)!permissionDetail.View)
            {
                return RedirectToAction("Index", "Home", new { access_permission = false });
            }
            ViewBag.CREATE = (bool)permissionDetail.Create;
            ViewBag.EDIT = (bool)permissionDetail.Edit;
            ViewBag.DELETE = (bool)permissionDetail.Delete;
            //---------------------------------------------------

            var listCategory = db.Categories.Select(c => c);
            return View(listCategory);
        }


        [HttpPost]
        public ActionResult AddProductCategory(CategoryDTO category)
        {

            Category cate = new Category();
            if (category.Base64 != null)
            {
                string path = HttpContext.Server.MapPath("~/wwwroot/imageUpload/");
                //string filename = DateTime.Now.ToString("yyyyMMddTHHmmss") + ".jpg";
                if (!UploadFileUtil.SaveFile(category.Base64, category.Icon, path))
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