using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class AccountDTO
    {
        [Required(ErrorMessage = "Không được để trống!")]
        [RegularExpression("^[a-zA-Z0-9_]*$", ErrorMessage ="Tên đăng nhập không được chứa dấu cách!")]
        [StringLength(255)]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [MinLength(6, ErrorMessage = "Mật khẩu phải có ít nhất 6 ký tự")]
        public string Password { get; set; }
        [Required(ErrorMessage = "Không được để trống!")]
        [Compare("Password", ErrorMessage = "Mật khẩu không trùng khớp")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [StringLength(255)]
        public string FullName { get; set; }
        [StringLength(50)]
        [EmailAddress(ErrorMessage = "Địa chỉ email không hợp lệ")]
        public string Email { get; set; }
        
       
        
        
    }
}