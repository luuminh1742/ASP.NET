using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Areas.Admin.Controllers
{
    [Authorize(Roles = "ADMIN")]

    public class OrdersController : Controller
    {
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        // GET: Admin/Orders
        [HttpGet]
        //public ActionResult Index()
        //{
        //    //var listBill = db.Bills.Where(b => b.Status).ToList();

        //    //var listBill = db.Bills.Join(db.BillDetails,
        //    //    a => a.ID_Bill,
        //    //    b => b.ID_Bill,
        //    //    (a, b) => new BillDTO
        //    //    {
        //    //        ID_Bill = a.ID_Bill,
        //    //        ID_Account = a.ID_Account,
        //    //        ReceiverName = a.ReceiverName,
        //    //        ReceiverAddress = a.ReceiverAddress,
        //    //        ReceiverEmail = a.ReceiverEmail,
        //    //        ReceiverPhone = a.ReceiverPhone,
        //    //        Note = a.Note,
        //    //        PayType = a.PayType,
        //    //        Status = a.Status,
        //    //        CreatedDate = a.CreatedDate,
        //    //        ModifiedDate = a.ModifiedDate,
        //    //        ID_Product = b.ID_Product,
        //    //        Amount = b.Amount,
        //    //        CurrentlyPrice = b.CurrentlyPrice
        //    //    }).ToList();
        //    var listBill = db.Bills.Join(db.BillDetails, a => a.ID_Bill, b => b.ID_Bill, (a, b) => new { a, b })
        //        .GroupBy(x => new
        //        {
        //            x.a.ID_Bill,
        //            //x.a.ID_Account,
        //            x.a.ReceiverName,
        //            x.a.ReceiverAddress,
        //            x.a.ReceiverEmail,
        //            x.a.ReceiverPhone,
        //            //x.a.Note,
        //            x.a.PayType,
        //            x.a.Status,
        //            x.a.CreatedDate,
        //            x.a.ModifiedDate
        //        })
        //        .Select(g => new BillDTO
        //        {
        //            ID_Bill = g.Key.ID_Bill,
        //            //ID_Account = g.Key.ID_Account,
        //            ReceiverName = g.Key.ReceiverName,
        //            ReceiverAddress = g.Key.ReceiverAddress,
        //            ReceiverEmail = g.Key.ReceiverEmail,
        //            ReceiverPhone = g.Key.ReceiverPhone,
        //            //Note = g.Key.Note,
        //            PayType = g.Key.PayType,
        //            Status = g.Key.Status,
        //            CreatedDate = g.Key.CreatedDate,
        //            ModifiedDate = g.Key.ModifiedDate,
        //            SumPrice = g.Sum(z => z.b.CurrentlyPrice)
        //        }).ToList();

        //    return View(listBill);
        //}

        public ActionResult Index()
        {
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
                    CreatedDate = g.Key.CreatedDate.ToString(),
                    ModifiedDate = g.Key.ModifiedDate.ToString(),
                    SumPrice = g.Sum(z => z.b.CurrentlyPrice)
                });
            listBill = listBill.OrderBy(b => b.ID_Bill);
            return View(listBill);
        }
        [HttpPost]
        public ActionResult NewBill(int kt)
        {
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
                    CreatedDate = g.Key.CreatedDate.ToString(),
                    ModifiedDate = g.Key.ModifiedDate.ToString(),
                    SumPrice = g.Sum(z => z.b.CurrentlyPrice)
                });
            if (kt == 0)
                listBill = listBill.Where(b => b.Status == 0);
            if (kt == 1)
                listBill = listBill.Where(b => b.Status == 1 || b.Status == 2);
            if (kt == 3)
                listBill = listBill.Where(b => b.Status == 3);
            return Json(listBill, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult OrdersDetail(int ID_Bill)
        {
            var product = (from a in db.BillDetails
                           from b in db.Products
                           where a.ID_Product == b.ID_Product && a.ID_Bill == ID_Bill
                           select new ProductBillDTO
                           {
                               Name = b.Name,
                               Image = b.Image,
                               Amount = a.Amount,
                               Price = b.Price
                           }).ToList();
            return Json(product, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Receive_Bill(int ID_Bill, int kt)
        {
            Bill bill = db.Bills.Where(b => b.ID_Bill == ID_Bill).FirstOrDefault();
            bill.ModifiedDate = DateTime.Now;
            if (kt == 1)
                bill.Status = 1;
            if (kt == 2)
                bill.Status = 2;
            if (kt == 3)
                bill.Status = 3;
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}