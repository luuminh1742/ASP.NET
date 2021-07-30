using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElectronicDevice.Controllers
{
    public class LoginController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string UserName, string Password)
        {
            if (ModelState.IsValid)
            {
                Account user = db.Accounts.Where(u => u.UserName.Equals(UserName)
                && u.Password.Equals(Password)).SingleOrDefault();
                if (user != null)
                {
                    Session["FullName"] = user.FullName;
                    Session["UserName"] = user.UserName;
                    Session["Email"] = user.Email;
                    Session["Avatar"] = user.Avatar;
                    FormsAuthentication.SetAuthCookie(user.UserName, false);
                    if (!Roles.RoleExists(user.Role.Code))
                    {
                        Roles.CreateRole(user.Role.Code);
                    }
                    if (!Roles.IsUserInRole(user.UserName, user.Role.Code))
                    {
                        Roles.AddUserToRole(user.UserName, user.Role.Code);
                    }
                    if (user.Role.Code.Equals("ADMIN"))
                    {
                        return RedirectToAction("Index", "Home", new { area = "Admin" });
                    }
                    return RedirectToAction("Index", "Product", new { });
                }
            }
            ViewBag.LoginError = "Đăng nhập thất bại!";
            return View("Index");
        }

        public ActionResult ForgetPass()
        {
            return View();
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            return RedirectToAction("Index", "Product", new { });
        }
    }
}