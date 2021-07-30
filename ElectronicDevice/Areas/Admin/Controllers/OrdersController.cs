using ElectronicDevice.DTO;
using ElectronicDevice.Models;
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
        public ActionResult Index()
        {
            //var listBill = db.Bills.Where(b => b.Status).ToList();

            //var listBill = db.Bills.Join(db.BillDetails,
            //    a => a.ID_Bill,
            //    b => b.ID_Bill,
            //    (a, b) => new BillDTO
            //    {
            //        ID_Bill = a.ID_Bill,
            //        ID_Account = a.ID_Account,
            //        ReceiverName = a.ReceiverName,
            //        ReceiverAddress = a.ReceiverAddress,
            //        ReceiverEmail = a.ReceiverEmail,
            //        ReceiverPhone = a.ReceiverPhone,
            //        Note = a.Note,
            //        PayType = a.PayType,
            //        Status = a.Status,
            //        CreatedDate = a.CreatedDate,
            //        ModifiedDate = a.ModifiedDate,
            //        ID_Product = b.ID_Product,
            //        Amount = b.Amount,
            //        CurrentlyPrice = b.CurrentlyPrice
            //    }).ToList();
            var listBill = db.Bills.Join(db.BillDetails, a => a.ID_Bill, b => b.ID_Bill, (a, b) => new { a, b })
                .GroupBy(x => new
                {
                    x.a.ID_Bill,
                    //x.a.ID_Account,
                    x.a.ReceiverName,
                    x.a.ReceiverAddress,
                    x.a.ReceiverEmail,
                    //x.a.ReceiverPhone,
                    //x.a.Note,
                    //x.a.PayType,
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
                    //ReceiverPhone = g.Key.ReceiverPhone,
                    //Note = g.Key.Note,
                    //PayType = g.Key.PayType,
                    Status = g.Key.Status,
                    CreatedDate = g.Key.CreatedDate,
                    ModifiedDate = g.Key.ModifiedDate,
                    SumPrice = g.Sum(z => z.b.CurrentlyPrice)
                }).ToList();
    
            return View(listBill);
        }
        public ActionResult Orders(int ID_Bill)
        {

            return View();
        }



    }
}