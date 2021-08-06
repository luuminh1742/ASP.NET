namespace ElectronicDevice.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Account")]
    public partial class Account
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Account()
        {
            Bills = new HashSet<Bill>();
            Carts = new HashSet<Cart>();
            PermissionDetails = new HashSet<PermissionDetail>();
        }

        [Key]
        public int ID_Account { get; set; }

        public int ID_Role { get; set; }

        [Required(ErrorMessage ="Tên đăng nhập không được để trống")]
        [RegularExpression("^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$",ErrorMessage = "Tên đăng nhập không đúng định dạng")]
        [StringLength(255)]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [MinLength(6, ErrorMessage = "Mật khẩu ít nhất 6 ký tự")]
        [RegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_]).{6,}$", ErrorMessage = "Mật khẩu gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt")]
        [StringLength(255)]
        public string Password { get; set; }

        [Required(ErrorMessage = "Không được để trống!")]
        [StringLength(255)]
        public string FullName { get; set; }

        [StringLength(15)]
        [RegularExpression("^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$", ErrorMessage = "Sai định dạng số điện thoại!")]
        public string Phone { get; set; }

        [StringLength(255)]
        public string Address { get; set; }

        [StringLength(50)]
        [Required(ErrorMessage = "Không được để trống!")]
        [EmailAddress(ErrorMessage = "Địa chỉ email không hợp lệ")]
        public string Email { get; set; }

        public bool Status { get; set; }

        [StringLength(255)]
        public string Avatar { get; set; }

        public bool? IsManager { get; set; }

        public virtual Role Role { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Bill> Bills { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cart> Carts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PermissionDetail> PermissionDetails { get; set; }
    }
}
