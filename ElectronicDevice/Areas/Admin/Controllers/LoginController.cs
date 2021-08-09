using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ElectronicDevice.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        // GET: Admin/Login
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        // GET: Login
        public ActionResult Index()
        {
            return View(new Account());
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string UserName, string Password)
        {
            if (ModelState.IsValid)
            {
                Account user = db.Accounts.Where(u => u.UserName.Equals(UserName)
                                                        && u.Password.Equals(Password)
                                                        && u.Status).SingleOrDefault();
                if (user != null)
                {
                    Session["FullName"] = user.FullName;
                    Session["UserName"] = user.UserName;
                    Session["Email"] = user.Email;
                    Session["Avatar"] = user.Avatar;
                    Session["ID"] = user.ID_Account;
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
                        return RedirectToAction("Index", "Home");
                    }
                }
            }
            ViewBag.LoginError = "Đăng nhập thất bại!";
            return View("Index");
        }
        public ActionResult logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            return View("Index");
        }
    }
}