using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class PermissionDetailDTO
    {

        public int Id_Permission { get; set; }

        public int ID_Account { get; set; }

        public bool Status { get; set; }

        public string Type { get; set; }
    }
}