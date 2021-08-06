using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using System.Linq;
using System.Web.Mvc;

namespace ElectronicDevice.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        [HttpGet]

        //Đăng ký thành viên
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(AccountDTO account)
        {
            Account userName = db.Accounts.Where(u => u.UserName.Equals(account.UserName.Trim())).SingleOrDefault();
            var email = db.Accounts.Where(u => u.Email.Equals(account.Email.Trim())).ToList();
            if (ModelState.IsValid)
            {
                if (userName!=null)
                {
                    ViewBag.ErrorRegis = "Tên đăng nhập đã tồn tại !";
                }
                else if (account.Email != null && email.Count() > 0)
                {
                    ViewBag.ErrorRegis = "Email đã tồn tại !";
                }
                else
                {
                    Account data = new Account();
                    data.UserName = account.UserName.Trim();
                    data.Password = account.Password.Trim();
                    data.Email = account.Email;
                    data.FullName = account.FullName.Trim();
                    data.ID_Role = 1;
                    data.Status = true;
                    db.Accounts.Add(data);
                    db.SaveChanges();
                    TempData["RegisterOk"] = "Đăng kí tài khoản thành công!";//Chuyển sang view login
                    return RedirectToAction("Index", "Login");
                }
            }
                return View(account);
        }

        //Sửa thông tin tài khoản khách hàng
        [HttpGet]
        public ActionResult Index()
        {
            var userName = Session["UserName"];
            Account account = db.Accounts.Where(u => u.UserName.Equals((string)userName)).FirstOrDefault();
            if(account.Phone!=null)
            account.Phone = account.Phone.Trim();
            return View(account);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index([Bind(Include = "UserName,Password,FullName,Phone,Address,Email,Avatar")] Account account)
        {
            var userName = Session["UserName"];
            Account acc = db.Accounts.Where(u => u.UserName.Equals((string)userName)).FirstOrDefault();
            var email1 = account.Email.Trim();
            var email = db.Accounts.Where(u => u.Email.Equals(email1) && !u.UserName.Equals((string)userName)).ToList();
            if (email.Count() > 0)
            {
                ViewBag.ErrorUpdate = "Email đã tồn tại !";
            }
            else
            {
                
                if (ModelState.IsValid)
                {
                    var f = Request.Files["ImageFile"];
                    if (f != null && f.ContentLength > 0)
                    {
                        //Use Namespace called : System.IO
                        string FileName = System.IO.Path.GetFileName(f.FileName);
                        //Lấy tên file upload
                        string UploadPath = Server.MapPath("~/wwwroot/imageUpload/" + FileName);
                        //Copy Và lưu file vào server. 
                        f.SaveAs(UploadPath);
                        //Lưu tên file vào db
                        account.Avatar = FileName;
                        acc.Avatar = account.Avatar;
                        Session["Avatar"] = account.Avatar;
                    }
                    //acc.Password = account.Password;
                    acc.Email = account.Email;
                    acc.FullName = account.FullName;
                    acc.Address = account.Address;
                    acc.Phone = account.Phone;
                    db.SaveChanges();
                    ViewBag.UpdateOk = "Cập nhật thành công !";
                    Session["FullName"] = account.FullName;
                    return View(acc);
                }
            }
            return View(acc);

        }
       


    }
}