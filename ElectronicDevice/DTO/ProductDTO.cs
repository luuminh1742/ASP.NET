using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class ProductDTO
    {
        public int ID_Product { get; set; }

        public int ID_Category { get; set; }

        public string Name { get; set; }

        public string Image { get; set; }

        public decimal Price { get; set; }

        public string Model { get; set; }

        public int Amount { get; set; }

        public int Guarantee { get; set; }

        public string Origin { get; set; }

        public short? Discount { get; set; }

        public string ShortDescription { get; set; }

        public string Detail { get; set; }

        public bool Status { get; set; }

        public DateTime? CreatedDate { get; set; }

        public string CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public string ModifiedBy { get; set; }

        public string Base64 { get; set; }

    }
}