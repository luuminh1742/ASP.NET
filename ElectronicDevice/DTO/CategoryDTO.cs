using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class CategoryDTO
    {
        public int ID_Category { get; set; }

        public string Name { get; set; }

        public string Icon { get; set; }

        public string Base64 { get; set; }

        public bool Status { get; set; }

    }
}