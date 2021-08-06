using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using ElectronicDevice.Utilities;
using PagedList;
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
        public ActionResult Index(string status = "none")
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
                                                         a.Role.Code.Equals(SystemConstants.ROLE_ADMIN)).OrderBy(a=>a.UserName).ToList());
            }
            //
            if (status.Equals("update_success"))
            {
                ViewBag.Success = true;
            }
            else if (status.Equals("update_fail"))
            {
                ViewBag.Error = true;
            }

            return View(accounts);
        }


        public ActionResult CreateEmployee()
        {
            ViewBag.UserNameInvalid = false;
            return View();
        }
        public ActionResult EditEmployee(int id, string status = "none")
        {
            if (status.Equals("add_success"))
            {
                ViewBag.AddSuccess = true;
            }
            else if (status.Equals("update_fail"))
            {
                ViewBag.Error = true;
            }
            Account account = db.Accounts.Where(a => a.ID_Account == id).SingleOrDefault();
            return View(account);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateEmployee([Bind(Include = "UserName,Password,FullName,Phone,Address,Email,Avatar")] Account account)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra tên đăng nhập có tồn tại trong database không
                var count = db.Accounts.Count(a => a.UserName.Equals(account.UserName));
                if (count != 0)
                {
                    ViewBag.UserNameInvalid = true;
                    return View();
                }


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
                return RedirectToAction("EditEmployee", new { id = newAccount.ID_Account, status = "add_success" });
            }
            ViewBag.UserNameInvalid = false;
            return View();
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
                return RedirectToAction("Index", new { status = "update_success" });
            }
            return View(new { status = "update_success" });
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

        /// <summary>
        /// Cập nhật trạng thái permission của user
        /// 
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
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
                return RedirectToAction("Index", new { status = "update_success" });
            }
            return RedirectToAction("Index", new { status = "update_fail" });
        }


        public ActionResult UpdatePassword(string OldPassword, string NewPassword, int Id_Account)
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

        public ActionResult Trash(int? page)
        {
            var accounts = db.Accounts.Where(a => a.Role.Code.Equals(SystemConstants.ROLE_ADMIN) && !a.Status).ToList();
            int pageSize = 8;  //Kích  thước  trang 
            int pageNumber = (page ?? 1);
            return View(accounts.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult ChangeStatusAccount(int id_account, bool status)
        {
            Account acc = db.Accounts.Where(a => a.ID_Account == id_account).SingleOrDefault();
            acc.Status = status;
            db.Entry(acc).State = EntityState.Modified;
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult RemoveAccountEmployee(List<int> ids)
        {
            foreach (int id in ids)
            {
                RemovePermission(id);
                Account account = db.Accounts.Where(a => a.ID_Account == id).SingleOrDefault();
                db.Accounts.Remove(account);
            }
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        private void RemovePermission(int id)
        {
            //ElectronicDeviceDbContext electronicDeviceDbContext = new ElectronicDeviceDbContext();
            var perDetails = db.PermissionDetails.Where(p => p.ID_Account == id).ToList();
            foreach (PermissionDetail permissionDetail in perDetails)
            {
                db.PermissionDetails.Remove(permissionDetail);
            }
            //electronicDeviceDbContext.SaveChanges();
        }
    }
}