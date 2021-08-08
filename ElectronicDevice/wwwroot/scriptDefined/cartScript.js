$(document).ready(function () {
    $('#totalPay').text((0).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
    $('tr').each(function () {
        totalMoney($(this).attr('id'));
    });

    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });

});

function deleteRecord(id_product, id_account) {
    console.log(id_product);
    console.log(id_account);
    $('#btn_save').attr("onclick", "deleteRecordConfirmed(" + id_product + "," + id_account + ")");
    $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm này?");
    $('#btn_close').text("Không");
    $('#btn_save').show();
    $('#btn_save').text("Xóa");
    $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
    $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
    jQuery.noConflict();
    $('#modalConfirmOder').modal("show");
}

function deleteRecordConfirmed(id_product, id_account) {
    console.log(id_product);
    console.log(id_account);
    $.ajax({
        url: "/Cart/DeleteCart?id_product=" + id_product + "&&id_account=" + id_account,
        type: "POST",
        /* data: { id_product: id_product, id_account: id_account},*/
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (result) {
            jQuery.noConflict();
            $('#modalConfirmOder').modal("hide");
            showAlertMessage(result.data, true);
            $('#' + id_product).remove();
            loadTotalMustPay();
            updateCartIcon();
        },
        error: (error) => {
            jQuery.noConflict();
            $('#modalConfirmOder').modal("hide");
            showAlertMessage("Xóa thất bại", false);
        }
    });
}

function focusOut(id) {

    if ($('#' + id).find('#number_order').val() == '' || $('#' + id).find('#number_order').val() == null) {
        showAlertMessage("Số lượng không được trống!", false);
        $('#' + id).find('#number_order').val(1);
        totalMoney(id);
        var element = $('#' + id).find('input[type="checkbox"]');
        if (element.prop("checked")) {
            var numberOrder = parseInt($('#' + id).find('#number_order').val());
            var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney + price * numberOrder));
        }
        $('#' + id).find('#number_order').data('val', $('#' + id).find('#number_order').val());
        var id_account = window.location.href.split("=")[1];
        addProductToCart(id, id_account, parseInt($('#' + id).find('#number_order').val()));
    }
}

/*function to change status selected of record when click ckeck box for all record */
function selectAllRecord() {
    if ($('#selectAll').prop("checked")) {
        $('#totalPay').text((0).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
        $('tr[class="data-table"]').each(function () {
            $(this).find('input[type="checkbox"]').prop("checked", true);
            changeStatus($(this).attr('id'));
        });
    } else {
        $('#totalPay').text((0).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
        $('tr[class="data-table"]').each(function () {
            $(this).find('input[type="checkbox"]').prop("checked", false);
        });
    }
}


function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function getOldValue(id) {
    var element = $('#' + id).find('#number_order');
    element.data('val', element.val());
}

/* function to check value order number when typping*/
function checkValid(maxOrder, id, id_account) {

    var oldNumberOrder = $('#' + id).find('#number_order').data('val');
    var numberOrder = parseInt($('#' + id).find('#number_order').val());
    var element = $('#' + id).find('input[type="checkbox"]');
    var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
    var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);


    if ($('#' + id).find('#number_order').val() == '' || $('#' + id).find('#number_order').val() == null) {
        if (element.prop("checked") && parseInt($('#' + id).find('#totalProductItem').text().trim().replace(/([,.€])+/g, '').split(' ')[0]) != 0) {
            $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney - price * oldNumberOrder));
        }
        $('#' + id).find('#totalProductItem').text(new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(0));
        $('#' + id).find('#number_order').data('val', 0);
        return;
    }

    if (numberOrder > maxOrder) {
        showAlertMessage("Số lượng mua tối đa cho sản phẩm này là " + maxOrder, false);

        $('#' + id).find('#number_order').val(maxOrder);
    } else if (numberOrder < 1) {
        $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm này?");
        $('#btn_close').text("Không");
        $('#btn_save').show();
        $('#btn_save').text("Xóa");
        $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
        $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
        $('#btn_save').attr("onclick", "deleteRecordConfirmed(" + id + "," + id_account + ")");
        //$('#btn_save').data('id_product', id);
        //$('#btn_save').data('id_account', id_account);

        jQuery.noConflict();
        $('#modalConfirmOder').modal("show");
        $('#' + id).find('#number_order').val(1);
    }
    numberOrder = parseInt($('#' + id).find('#number_order').val());
    totalMoney(id);
    addProductToCart(id, id_account, numberOrder);
    if (element.prop("checked")) {
        console.log(oldNumberOrder);
        $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney + price * (numberOrder - oldNumberOrder)));
    }
    $('#' + id).find('#number_order').data('val', $('#' + id).find('#number_order').val());
}

/*function to alter value order number when click up or down*/
function alterProductOrder(status, maxOrder, id, id_account) {
    var numberOrder = parseInt($('#' + id).find('#number_order').val());
    var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
    var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
    var element = $('#' + id).find('input[type="checkbox"]');
    if (status == 'decrease') {
        if (numberOrder > 1) {
            $('#' + id).find('#number_order').val(numberOrder - 1);
            if (element.prop("checked")) {
                $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney - price));
            }
        }
        else {
            $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm này?");
            $('#btn_close').text("Không");
            $('#btn_save').show();
            $('#btn_save').text("Xóa");
            $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
            $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });

            $('#btn_save').attr("onclick", "deleteRecordConfirmed(" + id + "," + id_account + ")");
            //$('#btn_save').data('id_product', id);
            //$('#btn_save').data('id_account', id_account);

            jQuery.noConflict();
            $('#modalConfirmOder').modal("show");
            $('#' + id).find('#number_order').val(1);

        }
    } else {
        if (numberOrder < maxOrder) {
            $('#' + id).find('#number_order').val(numberOrder + 1);
            if (element.prop("checked")) {
                $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney + price));
            }
        }
        else {
            showAlertMessage("Số lượng mua tối đa cho sản phẩm này là " + maxOrder, false);
            $('#' + id).find('#number_order').val(maxOrder);
        }
    }
    totalMoney(id);
    addProductToCart(id, id_account, parseInt($('#' + id).find('#number_order').val()));
}

/*function to change status selected of record when click ckeck box*/
function changeStatus(id) {
    var element = $('#' + id).find('input[type="checkbox"]');
    var oldMoney = parseFloat($('#totalPay').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
    var elementMoney = parseFloat($('#' + id).find('#totalProductItem').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
    if (element.prop("checked")) {
        if (checkAllRecordChecked()) {
            $('.table').find('thead').find('input[type="checkbox"]').prop("checked", true);
        }
        $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney + elementMoney));
    } else {
        $('#selectAll').prop("checked", false);
        $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(oldMoney - elementMoney));
    }
}

/*function to set value of total price of a record*/
function totalMoney(id) {
    var numberOrder = parseInt($('#' + id).find('#number_order').val());
    var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
    //$('#' + id).find('#totalProductItem').text((numberOrder * price).toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
    $('#' + id).find('#totalProductItem').text(new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(numberOrder * price));
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

/*check all record is checked*/
function checkAllRecordChecked() {
    var result = true;;
    $('#cart-container>tr').each(function () {
        if ($(this).find('input[type="checkbox"]').prop("checked") == false) {
            result = false;
            return;
        }
    });
    return result;
};

function deleteRecordSelected() {
    $('#modalConfirmOderContent').text("Bạn muốn xóa sản phẩm đang chọn?");
    $('#btn_close').text("Không");
    $('#btn_save').show();
    $('#btn_save').text("Xóa");
    $('#btn_close').css({ "background-color": "#007bff", "border": "1px solid #007bff", "width": "200px" })
    $('#btn_save').css({ "background-color": "rgb(255, 66, 78)", "border": "1px solid rgb(255, 66, 78)", "width": "200px" });
    $("#btn_save").attr("onclick", "deleteAllRecordConfirmed()");
    jQuery.noConflict();
    $('#modalConfirmOder').modal('show');
};

function deleteAllRecordConfirmed() {

    var arrIdProduct = new Array();
    $('#cart-container>tr').each(function () {
        if ($(this).find('input[type="checkbox"]').prop("checked") == true) {
            arrIdProduct.push($(this).attr('id'));
        }
    })

    var id_account = window.location.href.split("=")[1];
    /*?id_product = " + arrIdProduct + " && id_account=" + id_account,*/
    $.ajax({
        url: "/Cart/DeleteSelectedCart",
        type: "POST",
        dataType: 'json',
        data: { id_product: arrIdProduct, id_account: id_account },
        /* contentType: "application/json;charset=utf-8",*/
        traditional: true,
        success: function (result) {
            jQuery.noConflict();
            $('#modalConfirmOder').modal('hide');
            showAlertMessage(result.data, true);
            for (var i = 0; i <= arrIdProduct.length; i++) {
                $('#' + arrIdProduct[i]).remove();
            }
            loadTotalMustPay();
            updateCartIcon();
        },
        error: (error) => {
            jQuery.noConflict();
            $('#modalConfirmOder').modal('hide');
            showAlertMessage("Xóa thất bại", false);
        }
    });
};

function addProductToCart(id_product, id_account, amount) {
    /*var amount = $("#numberProductOrder").val();*/
    $.ajax({
        url: "/cart/addcartBuyNow",
        type: "post",
        data: { id_product: id_product, id_account: id_account, amount: amount },
        datatype: "json",
        contenttype: "application/json;charset=utf-8",
        success: function (result) {
            loadTotalMustPay();
            updateCartIcon();
        },
        error: (error) => {

        }
    });
}

function loadTotalMustPay() {
    var total = 0;
    $('#cart-container>tr').each(function () {
        if ($(this).find('input[type="checkbox"]').prop("checked") == true) {
            var id = $(this).attr("id");
            var numberOrder = parseInt($('#' + id).find('#number_order').val());
            var price = parseFloat($('#' + id).find('#price').text().trim().replace(/([,.€])+/g, '').split(' ')[0]);
            total += numberOrder * price;
        }
    });
    $('#totalPay').text(new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(total));

    if ($('#cart-container>tr').length <= 1) {
        var html = '';
        var href_a = '/Product/Index';
        html += '<div style="text-align:center">';
        html += '<img src="wwwroot/imageUpload/shopping_cart.png" alt="Chưa có sản phẩm nào trong giỏ!" style="width:200px;height:auto" />';
        html += ' <p style="margin: 15px 0px 30px; ">Không có sản phẩm nào trong giỏ hàng của bạn.</p>';
        html += ' <a class="btn_1" href="' + href_a + '">Tiếp tục mua hàng</a>';
        html += '</div>';
        $('#content-cart-page').html(html);
    }
}

function payNow() {
    var id_account = window.location.href.split("=")[1];
    var arrIdProduct = new Array();
    $('#cart-container>tr').each(function () {
        if ($(this).find('input[type="checkbox"]').prop("checked") == true) {
            arrIdProduct.push($(this).attr('id'));
        }
    });

    if (arrIdProduct.length > 0) {
        var listIdProduct = '';
        for (var i = 0; i < arrIdProduct.length; i++) {
            if (i == 0) {
                listIdProduct += arrIdProduct[i];
            } else {
                listIdProduct += ',' + arrIdProduct[i];
            }
        }
        console.log(listIdProduct);
        window.location.href = '/Bill/Buy?strIdProduct=' + listIdProduct + '&&id_account=' + id_account;
    }
    else {
        showAlertMessage("Chưa có sản phẩm nào được chọn mua!", false);
    }
}