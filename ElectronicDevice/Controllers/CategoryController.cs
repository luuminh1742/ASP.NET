using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Controllers
{
    public class CategoryController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        // GET: CategoryController
        [ChildActionOnly]
        public ActionResult _LeftSidebar()
        {
            var listCategory = db.Categories.Select(c => c);
            return PartialView(listCategory);
        }
        

    }
}