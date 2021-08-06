using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ElectronicDevice.DTO
{
    public class AccountDTO
    {
        public int ID_Account { get; set; }
        [Required(ErrorMessage = "Không được để trống!")]
        [RegularExpression("^[a-zA-Z0-9_]*$", ErrorMessage = "Tên đăng nhập không được chứa dấu cách!")]
        [StringLength(255)]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [MinLength(6, ErrorMessage = "Mật khẩu phải có ít nhất 6 ký tự")]
        [RegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_]).{6,}$", ErrorMessage = "Mật khẩu gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [Compare("Password", ErrorMessage = "Mật khẩu không trùng khớp")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [StringLength(255)]
        public string FullName { get; set; }

        [StringLength(50)]

        [Required(ErrorMessage = "Không được để trống!")]
        [EmailAddress(ErrorMessage = "Địa chỉ email không hợp lệ")]
        public string Email { get; set; }

        [StringLength(15)]
        [RegularExpression("^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$", ErrorMessage = "Sai định dạng số điện thoại!")]
        public string Phone { get; set; }

        
        [StringLength(255)]
        public string Address { get; set; }

        public List<PermissionDetailDTO> PermissionDetailDTOs { get; set; }




    }
}