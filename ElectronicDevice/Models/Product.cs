namespace ElectronicDevice.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            BillDetails = new HashSet<BillDetail>();
            Carts = new HashSet<Cart>();
        }

        [Key]
        public int ID_Product { get; set; }

        public int ID_Category { get; set; }

        [DisplayName("Tên sản phẩm")]
        [Required(ErrorMessage ="Demo")]
        [StringLength(255)]
        public string Name { get; set; }

        [DisplayName("")]
        [Column(TypeName = "money")]
        //[DisplayFormat(DataFormatString = "{0:#,###}")]
        public decimal Price { get; set; }

        [Required]
        [StringLength(255)]
        public string Model { get; set; }

        [DisplayName("Số lượng sản phẩm")]
        public int Amount { get; set; }

        [DisplayName("Bảo hành")]
        public int Guarantee { get; set; }

        [DisplayName("Xuất xứ")]
        [StringLength(255)]
        public string Origin { get; set; }

        [DisplayName("Giảm giá")]
        public short? Discount { get; set; }

        [DisplayName("Mô tả ngắn")]
        [StringLength(255)]
        public string ShortDescription { get; set; }

        [DisplayName("Chi tiết sản phẩm")]
        [Column(TypeName = "ntext")]
        public string Detail { get; set; }

        [DisplayName("Ảnh sản phẩm")]
        [Required]
        [StringLength(255)]
        public string Image { get; set; }

        [DisplayName("Ngày tạo")]
        [Column(TypeName = "date")]
        public DateTime? CreatedDate { get; set; }

        [DisplayName("Trạng thái")]
        public bool Status { get; set; }

        [DisplayName("Người tạo")]
        [StringLength(100)]
        public string CreatedBy { get; set; }

        [DisplayName("Ngày sửa")]
        [Column(TypeName = "date")]
        public DateTime? ModifiedDate { get; set; }

        [DisplayName("Người sửa")]
        [StringLength(100)]
        public string ModifiedBy { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BillDetail> BillDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cart> Carts { get; set; }

        public virtual Category Category { get; set; }
    }
}
