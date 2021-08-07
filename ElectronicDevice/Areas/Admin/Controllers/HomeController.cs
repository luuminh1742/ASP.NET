using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElectronicDevice.Areas.Admin.Controllers
{
    //[Authorize(Roles = "ADMIN")]
    public class HomeController : Controller
    {
        // GET: Admin/Home
        public ActionResult Index(bool? access_permission = true)
        {
            if((bool)!access_permission)
            {
                ViewBag.ERROR_ACCESS = true;
            }
            else
            {
                ViewBag.ERROR_ACCESS = false;
            }
            return View();
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            return RedirectToAction("Index", "Login", new { area = "Admin" });
        }
    }
}