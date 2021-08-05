using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using ElectronicDevice.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]
    public class AccountController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();

        // GET: Admin/Account
        public ActionResult Index()
        {
            // Lấy thông tin tài khoản đăng nhập
            var username = Session["UserName"].ToString();
            Account acc = db.Accounts.Where(a => a.UserName.Equals(username)).SingleOrDefault();
            var accounts = new List<Account>();
            accounts.Add(acc);
            // Kiểm tra xem tài khoản này có phải là người quản lý không
            // Nếu là quản lý thì lấy tất các các nhân viên từ db lên
            if ((bool)acc.IsManager)
            {
                // Lấy các nhân viên trừ người quản lý "a.ID_Account != acc.ID_Account"
                // Nhân viên có vai trò là "ADMIN"
                // Và nhân viên có trạng thái đang hoạt động Status = true
                accounts.AddRange(db.Accounts.Where(a => a.Status && a.ID_Account != acc.ID_Account &&
                                                         a.Role.Code.Equals(SystemConstants.ROLE_ADMIN)).ToList());
            }
            //
            return View(accounts);
        }

        public ActionResult CreateEmployee()
        {
            return View();
        }
        public ActionResult EditEmployee(int id)
        {
            Account account = db.Accounts.Where(a => a.ID_Account == id).SingleOrDefault();
            return View(account);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateEmployee([Bind(Include = "UserName,Password,FullName,Phone,Address,Email,Avatar")] Account account)
        {
            if (ModelState.IsValid)
            {
                account.Avatar = "default-avatar.png";
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
                }
                Role role = db.Roles.Where(r => r.Code.Equals("ADMIN")).SingleOrDefault();
                account.ID_Role = role.ID_Role;
                account.Status = true;
                account.IsManager = false;
                db.Accounts.Add(account);
                db.SaveChanges();

                // Sau khi tạo thông tin nhân viên thành công
                // Tiến hành tạo quyền truy cập cho nhân viên đấy
                // Đặt mặc định tất cả các quyền bằng false
                Account newAccount = db.Accounts.Where(a => a.UserName.Equals(account.UserName)).SingleOrDefault();
                createPermission(newAccount.ID_Account);
                // Sau khi thêm quyền thành công thì chuyển đến trang chỉnh sửa thông tin nhân viên để phân quyền truy cập
                return RedirectToAction("EditEmployee", new { id = newAccount.ID_Account });
            }
            return View(account);
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditEmployee([Bind(Include = "UserName,Password,FullName,Phone,Address,Email,Avatar")] Account account)
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
                }
                Account acc = db.Accounts.Where(u => u.UserName.Equals(account.UserName)).FirstOrDefault();
                acc.Avatar = account.Avatar;
                acc.Password = account.Password;
                acc.Email = account.Email;
                acc.FullName = account.FullName;
                acc.Address = account.Address;
                acc.Phone = account.Phone;
                db.Entry(acc).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View();
        }


        /// <summary>
        /// Phương thúc đặt quyền mặc định cho nhân viên
        /// Tất các các quyền đều bằng false
        /// Phương thức này được gọi khi thêm thông tin nhân viên thành công
        /// </summary>
        /// <param name="Id_Account"></param>
        public void createPermission(int Id_Account)
        {
            var permissions = db.Permissions.Select(p => p);
            foreach (Permission per in permissions)
            {
                ElectronicDeviceDbContext dbElectronicDevice = new ElectronicDeviceDbContext();
                PermissionDetail permissionDetail = new PermissionDetail();
                permissionDetail.ID_Account = Id_Account;
                permissionDetail.Id_Permission = per.Id_Permission;
                permissionDetail.Code = per.Code;
                permissionDetail.View = false;
                permissionDetail.Create = false;
                permissionDetail.Edit = false;
                permissionDetail.Delete = false;
                dbElectronicDevice.PermissionDetails.Add(permissionDetail);
                dbElectronicDevice.SaveChanges();
            }


        }
        public ActionResult PermissionEdit()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UpdatePermission(PermissionDetailDTO dto)
        {
            PermissionDetail permissionDetail = db.PermissionDetails.Where(p => p.Id_Permission == dto.Id_Permission
                                                                            && p.ID_Account == dto.ID_Account).SingleOrDefault();
            switch (dto.Type)
            {
                case "VIEW":
                    permissionDetail.View = dto.Status;
                    break;
                case "CREATE":
                    permissionDetail.Create = dto.Status;
                    break;
                case "EDIT":
                    permissionDetail.Edit = dto.Status;
                    break;
                case "DELETE":
                    permissionDetail.Delete = dto.Status;
                    break;
            }
            db.Entry(permissionDetail).State = EntityState.Modified;
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }

       
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateInfoAccount([Bind(Include = "UserName,Password,FullName,Phone,Address,Email,Avatar")] Account account)
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
                }
                Account acc = db.Accounts.Where(u => u.UserName.Equals(account.UserName)).FirstOrDefault();
                acc.Avatar = account.Avatar;
                acc.Email = account.Email;
                acc.FullName = account.FullName;
                acc.Address = account.Address;
                acc.Phone = account.Phone;
                db.Entry(acc).State = EntityState.Modified;
                db.SaveChanges();
                Session["FullName"] = acc.FullName;
                Session["Email"] = acc.Email;
                Session["Avatar"] = acc.Avatar;
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        
        public ActionResult UpdatePassword(string OldPassword,string NewPassword,int Id_Account)
        {
            Account acc = db.Accounts.Where(a => a.ID_Account == Id_Account).SingleOrDefault();
            if (acc.Password.Equals(OldPassword))
            {
                acc.Password = NewPassword;
                db.Entry(acc).State = EntityState.Modified;
                db.SaveChanges();
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            return Json(false, JsonRequestBehavior.AllowGet);
        }


    }
}