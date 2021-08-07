function showAlertMessage(message, messageState) {
    if (messageState) {
        $('#alert_message').css({ "background": "#C5F3D7", "border-left": "8px solid #2BD971" });
        $("#icon-alert-message").html('<i class="fas fa-check-circle"></i>');
        $("#icon-alert-message").find('i').css({ "color": "#2BD971" });
        $(".msg").css({ "color": "#24AD5F" });
        $(".close-btn-alert").css({ "background": "#2BD971", "color": "#24AD5F" });
        $(".close-btn-alert").find('.fas').css({ "color": "#24AD5F" });
        $(".close-btn-alert").hover(function (e) {
            $(this).css("background-color", e.type === "mouseenter" ? "#38F5A3" : "#2BD971")
        })
    } else {
        $('#alert_message').css({ "background": "#FFE1E3", "border-left": "8px solid #FF4456" });
        $("#icon-alert-message").html('<i class="fas fa-exclamation-circle"></i>');
        $("#icon-alert-message").find('i').css({ "color": "#FE4950" });
        $(".msg").css({ "color": "#F694A9" });
        $(".close-btn-alert").css({ "background": "#FF9CA4", "color": "#FD4653" });
        $(".close-btn-alert").find('.fas').css({ "color": "#FD4653" });
        $(".close-btn-alert").hover(function (e) {
            $(this).css("background-color", e.type === "mouseenter" ? "#FFBDC2" : "#FF9CA4")
        })
    }

    $('.msg').text(message);
    $('.alert').addClass("show");
    $('.alert').removeClass("hide");
    $('.alert').addClass("showAlert");
    setTimeout(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    }, 3000);
};

function detail(id_product) {
    window.location.href = '/Product/Detail?id_product=' + id_product;
};

function addProductToCart(id_product, id_account) {
    if (id_account == null) {
        window.location.href = '/Login/Index?statusRequest="LoginToCart"';
    } else {
        $.ajax({
            url: "/cart/addcart",
            type: "post",
            data: { id_product: id_product, id_account: id_account },
            datatype: "json",
            contenttype: "application/json;charset=utf-8",
            success: function (result) {
                showAlertMessage(result.data, true);
                updateCartIcon();
            },
            error: (error) => {
                showAlertMessage("Không thể thêm vào giỏ hàng sản phẩm này!", false);
            }
        });
    }
}

$("#orderBy").change(function () {
    /* $('.table-categoty').find('.selected-category').removeClass('selected-category');*/
    console.log("Chạy vào!!!!!");
    var txtSearch = $("#searchStr").val();
    var orderType = $("#orderBy").val();
    var id_category = $('.table-categoty').find('.chosed').attr('id');
    if (orderType != 0) {
        loadData(txtSearch, 1, id_category, orderType);
    } else {
        loadData(txtSearch, 1, id_category, null);
    }
});

$('.row-left-sidebar').click(function () {
    $("#orderBy").val("0");
    $('#searchStr').val("");
    $('.table-categoty').find('.selected-category').removeClass('selected-category');
    $('.table-categoty').find('.chosed').removeClass('chosed');
    var id_category = $(this).attr('id');
    loadData(null, 1, id_category, null);
    $(this).addClass('chosed');
    $(this).addClass('selected-category');
    var title = $(this).children('td:nth-child(2)').text();
    $('#title-banner').find('h2').html("Danh mục sản phẩm");
    $('#title-banner').find('p').html("Trang chủ > " + title);
});

$("body").on("click", ".pagination li a", function (event) {
    event.preventDefault();
    var page = $(this).attr('data-page');
    var id_category = $('.table-categoty').find('.chosed').attr('id');
    //load event pagination
    var txtSearch = $("#searchStr").val();
    if (txtSearch != "") {
        loadData(txtSearch, page, id_category, $("#orderBy").val());
    }
    else {
        loadData(null, page, id_category, $("#orderBy").val());
    }

});

$("#search").click(function () {
    $("#orderBy").val("0");
    $('.table-categoty').find('.selected-category').removeClass('selected-category');
    var txtSearch = $("#searchStr").val();
    if (txtSearch != "") {
        loadData(txtSearch, 1, null, null);
    }
    else {
        loadData(null, 1, null, null);
    }
});

$("#searchStr").keyup(function (event) {
    $("#orderBy").val("0");
    $('#search').click();
});

