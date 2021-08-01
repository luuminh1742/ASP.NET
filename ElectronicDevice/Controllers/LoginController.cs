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
        public ActionResult Index(string statusRequest)
        {
            ViewBag.statusRequest = statusRequest;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string UserName, string Password, string statusRequest)
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
                        return RedirectToAction("Index", "Home", new { area = "Admin" });
                    }
                    else
                    {
                        if (statusRequest != null)
                        {
                            return RedirectToAction("Index", "Cart", new { id_account = user.ID_Account });
                        }
                        else
                        {
                            return RedirectToAction("Index", "Product", new { });
                        }
                    }
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