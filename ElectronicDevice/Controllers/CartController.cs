using ElectronicDevice.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ElectronicDevice.Controllers
{
    [Authorize]
    public class CartController : Controller
    {
        // GET: Cart
        private ElectronicDeviceDbContext db = new ElectronicDeviceDbContext();
        // GET: Cart
        public ActionResult Index(int id_account)
        {
            //ViewBag.id_account = id_account;
            return View(db.Carts.Where(c => c.ID_Account == id_account).ToList());
        }

        public JsonResult DeleteCart(int id_product, int id_account)
        {
            var cart = db.Carts.Where(c => c.ID_Account == id_account && c.ID_Product == id_product).FirstOrDefault();
            db.Carts.Remove(cart);
            db.SaveChanges();
            var message = "Xóa thành công!";
            return Json(new { data = message }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteSelectedCart(List<int> id_product, int? id_account)
        {
            var message = "";
            if (id_product != null)
            {
                var listCart = new List<Cart>();
                foreach (var id in id_product)
                {
                    listCart.Add(db.Carts.Where(c => c.ID_Account == (int)id_account && c.ID_Product == id).FirstOrDefault());
                }
                foreach (var cart in listCart)
                {
                    db.Carts.Remove(cart);
                }
                db.SaveChanges();
                message = "Xóa thành công!";
            }
            else
            {
                message = "Không có mục nào được chọn!";

            }
            return Json(new { data = message }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddCart(int id_product, int id_account, int? amount)
        {
            Cart cart = new Cart();
            cart.ID_Product = id_product;
            cart.ID_Account = id_account;
            cart.Amount = amount == null ? 1 : (int)amount;

            if (db.Carts.Where(c => c.ID_Account == id_account && c.ID_Product == id_product).Count() <= 0)
            {
                db.Carts.Add(cart);
                db.SaveChanges();
            }
            else
            {
                var oldCart = db.Carts.Where(c => c.ID_Account == id_account && c.ID_Product == id_product).FirstOrDefault();
                cart.Amount += oldCart.Amount;
                var currentAmount = db.Products.Where(p => p.ID_Product == id_product).FirstOrDefault().Amount;
                cart.Amount = cart.Amount <= currentAmount ? cart.Amount : currentAmount;
                db.Carts.Remove(oldCart);
                db.Carts.Add(cart);
                db.SaveChanges();
            }
            var message = "Thêm thành công vào giỏ hàng!";

            return Json(new { data = message }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult addcartBuyNow(int id_product, int id_account, int? amount)
        {
            Cart cart = new Cart();
            cart.ID_Product = id_product;
            cart.ID_Account = id_account;
            cart.Amount = amount == null ? 1 : (int)amount;

            if (db.Carts.Where(c => c.ID_Account == id_account && c.ID_Product == id_product).Count() <= 0)
            {
                db.Carts.Add(cart);
                db.SaveChanges();
            }
            else
            {
                var oldCart = db.Carts.Where(c => c.ID_Account == id_account && c.ID_Product == id_product).FirstOrDefault();
                db.Carts.Remove(oldCart);
                db.Carts.Add(cart);
                db.SaveChanges();
            }
            var message = "Thêm thành công vào giỏ hàng!";

            return Json(new { data = message }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult countCartById(int id_account)
        {
            var cart = db.Carts.Where(c => c.ID_Account == id_account).Count();
            return Json(new { data = cart }, JsonRequestBehavior.AllowGet);
        }
    }
}