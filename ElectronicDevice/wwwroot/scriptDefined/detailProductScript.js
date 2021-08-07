
$(document).ready(function () {

    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

    var id_product = window.location.href.split("=")[1];
    var load = function (id_product) {
        $.ajax({
            url: "/Product/GetDetail?id_product=" + id_product,
            type: "GET",
            data: { id_product: id_product },
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                var imgPath = '/wwwroot/imageUpload/' + result.data.Image;
                $("#image-product").attr("src", imgPath);
                $("#name-product").html(result.data.Name);
                $("#price-product").html(result.data.Price.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
                $("#model-product").html(result.data.Model);
                $("#guarantee-product").html(result.data.Guarantee + ' tháng');
                $("#origin-product").html(result.data.Origin);
                var status = result.data.Status > 0 ? "Còn hàng" : "Hết hàng";
                $("#status-product").html(status);
                $("#short-description-product").html(result.data.ShortDescription);
                $("#detail-product").html(result.data.Detail);

                $('#numberProductOrder').attr("data-id-product", result.data.ID_Product);
                $('#numberProductOrder').attr("data-amount-product", result.data.Amount);
                $('#numberProductOrder').attr("max", result.data.Amount);
                document.title = result.data.Name;
            }
        });
    }
    load(id_product);
});

function addProductToCart(id_product, id_account) {

    if (id_account == null) {
        window.location.href = '/Login/Index?statusRequest="LoginToCart"';
    } else {
        var amount = $("#numberProductOrder").val();
        
        $.ajax({
            url: "/cart/addcart",
            type: "post",
            data: { id_product: id_product, id_account: id_account, amount: amount },
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

function buyNow(id_product, id_account) {
    if (id_account == null) {
        window.location.href = '/Login/Index?statusRequest="LoginToCart"';
    } else {
        var currentAmount = $("#numberProductOrder").attr("data-amount-product");
        var amount = $("#numberProductOrder").val();
        if (currentAmount == 0) {
            showAlertMessage("Sản phẩm tạm thời hết hàng!", true);
        } else if (amount > currentAmount) {
            showAlertMessage("Số lượng mua vượt quá số lượng hiện có!", true);
        }
        else {
            $.ajax({
                url: "/cart/addcartBuyNow",
                type: "post",
                data: { id_product: id_product, id_account: id_account, amount: amount },
                datatype: "json",
                contenttype: "application/json;charset=utf-8",
                success: function (result) {
                    showAlertMessage(result.data, true);
                    updateCartIcon();
                    var url = '/Bill/BuyNow?id_product=' + id_product + '&&id_account=' + id_account;
                    window.location.href = url;
                },
                error: (error) => {
                    showAlertMessage("Không thể mua sản phẩm này!", false);
                }
            });
        }
    }
}


function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function checkValidAmount(status) {
    var numberOrder = parseInt($('#numberProductOrder').val());
    if (status == 'decrease') {
        if (numberOrder == 1) {
            showAlertMessage("Số lượng không được nhỏ hơn 1!", false);
            $('#numberProductOrder').val('1');
        }
    } else {
        var maxOrder = parseInt($('#numberProductOrder').attr('data-amount-product'));
        if (numberOrder == maxOrder) {
            showAlertMessage("Số lượng sản phẩm chỉ còn lại " + maxOrder, false);
            $('#numberProductOrder').val(maxOrder);
        }
    }
}

function checkValidAmountInput() {
    var numberOrder = parseInt($('#numberProductOrder').val());
    var maxOrder = parseInt($('#numberProductOrder').attr('data-amount-product'));
    console.log(numberOrder);
    console.log(maxOrder);
    if (numberOrder == "" || numberOrder == null || numberOrder < 1) {
        showAlertMessage("Số lượng không được nhỏ hơn 1!", false);
        $('#numberProductOrder').val(1);
    }
    if (numberOrder > maxOrder) {
        showAlertMessage("Số lượng sản phẩm chỉ còn lại " + maxOrder, false);
        $('#numberProductOrder').val(maxOrder);
    }
}
