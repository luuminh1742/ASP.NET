using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class BillDTO
    {
         public int ID_Bill { get; set; }

        public int ID_Account { get; set; }
        public string ReceiverName { get; set; }
        public string ReceiverAddress { get; set; }
        public string ReceiverEmail { get; set; }
        public string ReceiverPhone { get; set; }
        public string Note { get; set; }
        public string PayType { get; set; }
        public int Status { get; set; }
        public String CreatedDate { get; set; }
        public String ModifiedDate { get; set; }
        //public DateTime? CreatedDate { get; set; }
        //public DateTime? ModifiedDate { get; set; }
        public int ID_Product { get; set; }
        public int Amount { get; set; }
        public decimal CurrentlyPrice { get; set; }
        public decimal SumPrice { get; set; }

    }
}