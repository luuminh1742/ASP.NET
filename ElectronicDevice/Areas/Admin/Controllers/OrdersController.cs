using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using ElectronicDevice.Utilities;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Areas.Admin.Controllers
{
    //[Authorize(Roles = "ADMIN")]
    public class OrdersController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        //string iDate = "05/05/2005";
        //DateTime oDate = Convert.ToDateTime(iDate);
        // GET: Admin/Orders
        public ActionResult Index()
        {
            // Phân quyền cho quản lý sản phẩm
            var idAccount = (int)Session["ID"];
            PermissionDetail permissionDetail = db.PermissionDetails.Where(pd => pd.ID_Account == idAccount
            && pd.Permission.Code.Equals(SystemConstants.PERMISSION_ORDERS)).SingleOrDefault();

            if ((bool)!permissionDetail.View)
            {
                return RedirectToAction("Index", "Home", new { access_permission = false });
            }
            ViewBag.CREATE = (bool)permissionDetail.Create;
            ViewBag.EDIT = (bool)permissionDetail.Edit;
            ViewBag.DELETE = (bool)permissionDetail.Delete;
            //---------------------------------------------------

            return View();
        }

        [HttpGet]
        public JsonResult NewBill(int kt, int page)//danh sách đơn hàng theo status
        {
            var pageSize = 8;//Số đơn hàng trong một trang
            var stt1 = (page - 1) * pageSize;
            var listBill = db.Bills.Join(db.BillDetails, a => a.ID_Bill, b => b.ID_Bill, (a, b) => new { a, b })
                .GroupBy(x => new
                {
                    x.a.ID_Bill,
                    //x.a.ID_Account,
                    x.a.ReceiverName,
                    x.a.ReceiverAddress,
                    x.a.ReceiverEmail,
                    x.a.ReceiverPhone,
                    //x.a.Note,
                    x.a.PayType,
                    x.a.Status,
                    x.a.CreatedDate,
                    x.a.ModifiedDate
                })
                .Select(g => new BillDTO
                {
                    ID_Bill = g.Key.ID_Bill,
                    //ID_Account = g.Key.ID_Account,
                    ReceiverName = g.Key.ReceiverName,
                    ReceiverAddress = g.Key.ReceiverAddress,
                    ReceiverEmail = g.Key.ReceiverEmail,
                    ReceiverPhone = g.Key.ReceiverPhone,
                    //Note = g.Key.Note,
                    PayType = g.Key.PayType,
                    Status = g.Key.Status,
                    //CreatedDate = g.Key.CreatedDate.ToString(),
                    //ModifiedDate = g.Key.ModifiedDate.ToString(),
                    CreatedDate = g.Key.CreatedDate,
                    ModifiedDate = g.Key.ModifiedDate,
                    //SumPrice = g.Sum(z => z.b.CurrentlyPrice),
                    SumPrice = g.Sum(z => z.b.CurrentlyPrice * z.b.Amount)
                });
            listBill = listBill.OrderBy(b => b.ID_Bill);
            int totalPage = 0;
            if (kt == 0)//đơn mới tiếp nhận
            {
                listBill = listBill.Where(b => b.Status == 0);
                var row = listBill.Count();
                if (row > 0)
                {
                    totalPage = (int)Math.Ceiling(row / (float)pageSize);
                    listBill = listBill.Where(b => b.Status == 0).Skip((page - 1) * pageSize).Take(pageSize);
                }
            }
            if (kt == 1)//đơn đang xử lý
            {
                listBill = listBill.Where(b => b.Status == 1 || b.Status == 2);
                var row = listBill.Count();
                if (row > 0)
                {
                    totalPage = (int)Math.Ceiling(row / (float)pageSize);
                    listBill = listBill.Where(b => b.Status == 1 || b.Status == 2).Skip((page - 1) * pageSize).Take(pageSize);
                }
            }
            if (kt == 3)//đơn đang xử lý
            {
                listBill = listBill.Where(b => b.Status == 3);
                var row = listBill.Count();
                if (row > 0)
                {
                    totalPage = (int)Math.Ceiling(row / (float)pageSize);
                    listBill = listBill.Where(b => b.Status == 3).Skip((page - 1) * pageSize).Take(pageSize);
                }
            }
            if (kt == 4)//đơn đã hủy
            {
                listBill = listBill.Where(b => b.Status == 4);
                var row = listBill.Count();
                if (row > 0)
                {
                    totalPage = (int)Math.Ceiling(row / (float)pageSize);
                    listBill = listBill.Where(b => b.Status == 4).Skip((page - 1) * pageSize).Take(pageSize);
                }
            }
            return Json(new { data = listBill, stt = stt1, currentPage = page, totalPageCount = totalPage }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult OrdersDetail(int ID_Bill)//danh sách sản phẩm trong đơn hàng
        {
            var product = (from a in db.BillDetails
                           from b in db.Products
                           where a.ID_Product == b.ID_Product && a.ID_Bill == ID_Bill
                           select new ProductBillDTO
                           {
                               Name = b.Name,
                               Image = b.Image,
                               Amount = a.Amount,
                               CurrentlyPrice = a.CurrentlyPrice
                           }).ToList();
            return Json(product, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Receive_Bill(int ID_Bill, int kt)//Thay đổi trạng thái đơn hàng (Nhận đơn hàng, hủy đơn hàng)
        {

            // Phân quyền cho quản lý sản phẩm
            var idAccount = (int)Session["ID"];
            PermissionDetail permissionDetail = db.PermissionDetails.Where(pd => pd.ID_Account == idAccount
            && pd.Permission.Code.Equals(SystemConstants.PERMISSION_ORDERS)).SingleOrDefault();

            if ((bool)!permissionDetail.View)
            {
                return RedirectToAction("Index", "Home", new { access_permission = false });
            }
            //----------------------

            if(!(bool)permissionDetail.Edit || !(bool)permissionDetail.Delete)
            {
                return Json(false, JsonRequestBehavior.AllowGet);
            }

            Bill bill = db.Bills.Where(b => b.ID_Bill == ID_Bill).FirstOrDefault();
            bill.ModifiedDate = DateTime.Now;
            if (kt == 1)
                bill.Status = 1;
            if (kt == 2)
                bill.Status = 2;
            if (kt == 3)
                bill.Status = 3;
            if (kt == 4)
                bill.Status = 4;
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}