using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
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
            return View(new Account());
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
            ViewBag.LoginError = "Đăng nhập thất bại!";
            return View("Index",new Account());
        }

        public ActionResult ForgetPass()
        {
            return View();
        }
        [NonAction]
        public void SendVerificationLinkEmail(string email, string activationCode, string emailfor = "VerifyAccount")
        {
            var verifyUrl = "/Login/ResetPassword/" + activationCode;
            var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, verifyUrl);

            var fromEmail = new MailAddress("nhom6aspnet@gmail.com", "Nhóm 6 ASP.NET");
            var toEmail = new MailAddress(email);
            var fromEmailPassword = "duykhanh2611";

            string subject = "";
            string body = "";
            if (emailfor == "VerifyAccount")
            {
                subject = "Tạo tài khoản thành công !";

                body = "<br/><br/>we are tell you is" + "Bấm vào link" + "<br/><br/><a href='" + link + "'>" + link + "<a/>";
            }
            else if (emailfor == "Resetpassword")
            {
                subject = "Đặt lại mật khẩu";
                body = "<br/><br/>Chúng tôi nhận được yêu cầu đặt lại mật khẩu. Bấm vào link " + "<br/><br/><a href='" + link + "'>Đặt lại mật khẩu<a/>";
            }
            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromEmail.Address.Trim(), fromEmailPassword.Trim())
            };
            smtp.EnableSsl = true;
            using (var message = new MailMessage(fromEmail, toEmail)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true,
            })
                smtp.Send(message);
        }

        [HttpPost]
        public ActionResult ForgetPass(string Email)
        {
            //Xác minh email
            //Gửi liên kết đặt lại mật khẩu
            //Gửi email

            var account = db.Accounts.Where(a => a.Email == Email).FirstOrDefault();
            if (account != null)
            {
                //Gửi email đặt lại mật khẩu
                string resetCode = Guid.NewGuid().ToString();
                SendVerificationLinkEmail(account.Email, resetCode, "Resetpassword");
                account.ResetPasswordCode = resetCode;
                // avoid comfirm password
                db.Configuration.ValidateOnSaveEnabled = false;
                db.SaveChanges();

                ViewBag.ForgetOk = "Link đặt lại mật khẩu đã gửi đến Email của bạn !";
            }
            else
            {

                ViewBag.ForgetError = "Không tìm thấy email !";
            }
            return View();
        }

        public ActionResult ResetPassword(string id)
        {
            //Xác minh link đặt lại mật khẩu
            //Tìm tài khoản link gửi đến
            //Chuyển tới trang đặt lại mật khẩu
            var user = db.Accounts.Where(a => a.ResetPasswordCode == id).FirstOrDefault();
            if (user != null)
            {
                ResetPasswordModel model = new ResetPasswordModel();
                model.ResetCode = id;
                return View(model);
            }
            else
            {
                return HttpNotFound();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordModel model)
        {
            if (ModelState.IsValid)
            {
                var user = db.Accounts.Where(a => a.ResetPasswordCode == model.ResetCode).FirstOrDefault();
                if (user != null)
                {
                    //user.Password = Crypto.Hash(model.NewPassword);
                    user.Password = model.NewPassword;
                    user.ResetPasswordCode = "";
                    db.Configuration.ValidateOnSaveEnabled = false;
                    db.SaveChanges();

                    ViewBag.ResetOk = "Cập nhật mật khẩu mới thành công !";
                }
            }
            else
            {
                ViewBag.ResetError = "Mật khẩu không trùng khớp !";
            }
            return View(model);
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            return RedirectToAction("Index", "Product", new { });
        }
    }
}