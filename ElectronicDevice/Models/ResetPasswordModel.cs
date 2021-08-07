using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ElectronicDevice.Models
{
    public class ResetPasswordModel
    {
        [Key]
        [Required(ErrorMessage = "Không được để trống!")]
        [MinLength(6, ErrorMessage = "Mật khẩu ít nhất 6 ký tự")]
        [RegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_]).{6,}$", ErrorMessage = "Mật khẩu gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt")]
        [StringLength(255)]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [MinLength(6, ErrorMessage = "Mật khẩu ít nhất 6 ký tự")]
        [RegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_]).{6,}$", ErrorMessage = "Mật khẩu gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt")]
        [StringLength(255)]
        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessage = "Mật khẩu không trùng khớp !")]
        public string ConfirmPassword { get; set; }

        [Required]
        public string ResetCode { get; set; }
    }
}