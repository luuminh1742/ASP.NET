using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class ProductBillDTO
    {
        public string Image { get; set; }
        public string Name { get; set; }

        public decimal CurrentlyPrice { get; set; }

        public int Amount { get; set; }
    }
}