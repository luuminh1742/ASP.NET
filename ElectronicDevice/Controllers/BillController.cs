using ElectronicDevice.DTO;
using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Controllers
{
    public class BillController : Controller
    {
        // GET: Bill
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        private Bill billToGet;
        [HttpGet]
        public ActionResult Index()
        {
            if (billToGet != null)
            {
                ViewBag.bill = billToGet;
                ViewBag.billDetails = db.BillDetails.Where(bd => bd.ID_Bill == billToGet.ID_Bill).ToList();
                ViewBag.message = "Đặt hàng thành công";
                return View();
            }
            else return View("Index", "Product");
        }

        [HttpPost]
        public ActionResult Index(Bill bill, String listCart)
        {
            var listCartStr = listCart.Split(';');
            List<Cart> carts = new List<Cart>();
            var id_product = 0;
            var id_account = 0;
            foreach (var item in listCartStr)
            {
                if (!String.IsNullOrEmpty(item))
                {
                    id_product = int.Parse(item.Split('&')[0]);
                    id_account = int.Parse(item.Split('&')[1]);
                    carts.Add(db.Carts.Where(c => c.ID_Product == id_product && c.ID_Account == id_account).FirstOrDefault());
                }
            }
            try
            {

                if (carts.FirstOrDefault() == null)
                {
                    bill = db.Bills.Where(b => b.ID_Account == id_account).OrderByDescending(b => b.ID_Bill).FirstOrDefault();
                    ViewBag.billDetails = db.BillDetails.Where(bd => bd.ID_Bill == bill.ID_Bill).ToList();
                    ViewBag.bill = bill;
                    ViewBag.message = null;
                    return View();
                }

                bill.ID_Account = id_account;
                bill.Status = 0;
                bill.CreatedDate = DateTime.Now;
                bill.ModifiedDate = null;
                db.Bills.Add(bill);
                db.SaveChanges();



                bill = db.Bills.Where(b => b.ID_Account == id_account).OrderByDescending(b => b.ID_Bill).FirstOrDefault();
                foreach (var cart in carts)
                {
                    var billDetail = new BillDetail();
                    var product = new Product();
                    billDetail.ID_Product = cart.ID_Product;
                    billDetail.ID_Bill = bill.ID_Bill;
                    billDetail.Amount = cart.Amount;
                    billDetail.CurrentlyPrice = cart.Product.Price;
                    db.BillDetails.Add(billDetail);
                    db.SaveChanges();
                    product = db.Products.Where(p => p.ID_Product == cart.ID_Product).FirstOrDefault();
                    product.Amount -= cart.Amount;
                    db.Entry(product).State = EntityState.Modified;
                }
                foreach (var cart in carts)
                {
                    db.Carts.Remove(cart);
                }
                db.SaveChanges();

                ViewBag.bill = bill;
                billToGet = bill;
                ViewBag.billDetails = db.BillDetails.Where(bd => bd.ID_Bill == bill.ID_Bill).ToList();
                ViewBag.message = "Đặt hàng thành công";
                return View();
            }
            catch (Exception)
            {
                ViewBag.message = "Đặt hàng thất bại";
                ViewBag.status = "BuyFromCart";
                ViewBag.cart = null;
                ViewBag.listCart = carts;
                return View("Buy");
            }
        }

        [HttpGet]
        public ActionResult BuyNow(int? id_product, int? id_account)
        {
            var cartDb= db.Carts.Where(c => c.ID_Product == (int)id_product && c.ID_Account == (int)id_account).FirstOrDefault();
            if (cartDb.Account.Phone==null)
            {
                cartDb.Account.Phone = "";
            }
            if (cartDb.Account.Address==null)
            {
                cartDb.Account.Phone = "";
            }
            ViewBag.cart = cartDb; 
            ViewBag.status = "BuyNow";
            ViewBag.listCart = null;
            return View("Buy");
        }

        [HttpGet]
        public ActionResult Buy(string strIdProduct, int? id_account)
        {
            ViewBag.status = "BuyFromCart";
            ViewBag.cart = null;
            var listCart = new List<Cart>();
            var arrStrIdProduct = strIdProduct.Trim().Split(',');
            var listIdProduct = new List<int>();
            foreach (var item in arrStrIdProduct)
            {
                listIdProduct.Add(int.Parse(item));
            }

            foreach (var id in listIdProduct)
            {
                var cart = db.Carts.Where(c => c.ID_Product == id && c.ID_Account == id_account).FirstOrDefault();
                listCart.Add(cart);
            }
            var cartDb = listCart.FirstOrDefault();
            if (cartDb.Account.Phone == null)
            {
                foreach (var item in listCart)
                {
                    item.Account.Phone = "";
                }
            }
            if (cartDb.Account.Address == null)
            {
                foreach (var item in listCart)
                {
                    item.Account.Address = "";
                }
            }
            ViewBag.listCart = listCart.ToList();
            return View(new Bill());
        }
        [HttpGet]
        public ActionResult BillDetail(int ID_Bill)
        {
            db.Configuration.ProxyCreationEnabled = false;
            var product = (from a in db.BillDetails
                           from b in db.Products
                           where a.ID_Product == b.ID_Product && a.ID_Bill == ID_Bill
                           select new ProductBillDTO
                           {
                               Name = b.Name,
                               Image = b.Image,
                               Amount = a.Amount,
                               CurrentlyPrice = b.Price
                           }).ToList();
            return Json(new { data = product }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult CancelBill(int ID_Bill)
        {
            db.Configuration.ProxyCreationEnabled = false;
            Bill bill = db.Bills.Where(b => b.ID_Bill == ID_Bill).FirstOrDefault();
            bill.Status = 4;
            db.SaveChanges();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult LoadBill(int ID_Account)
        {
            db.Configuration.ProxyCreationEnabled = false;
            var bills = db.Bills.Where(b => b.ID_Account == ID_Account).ToList();

            return Json(new { data = bills }, JsonRequestBehavior.AllowGet);
        }

    }
}
