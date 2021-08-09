$('#ID_Product').hide();
var detail = "";
$(document).ready(function () {
    detail = CKEDITOR.replace('Detail');
});

//======= Bat loi san pham _ Start ================================
// Bat loi ten san pham
let checkErrorProduct = false;
const errorName = () => {
    if ($('#Name').val() == '') {
        $('#error_name').show();
        $('#error_name').text("Tên sản phẩm không được để trống");
        checkErrorProduct = true;
    } else {
        $('#error_name').hide();
        checkErrorProduct = false;
    }
}

$('#Name').keyup(() => {
    errorName();
});
$('#Name').keydown(() => {
    errorName();
});

// Bat loi gia

const errorPrie = () => {

    if ($('#Price').val() === '' || Number($('#Price').val()) < 0) {
        $('#error_price').show();
        $('#error_price').text("Đơn giá không được để trống hoặc nhỏ hơn 0");
        checkErrorProduct = true;
    } else {
        $('#error_price').hide();
        checkErrorProduct = false;
    }
}

$('#Price').keyup(() => {
    errorPrie();
});
$('#Price').keydown(() => {
    errorPrie();
});

//

const errorModel = () => {
    if ($('#Model').val() === '') {
        $('#error_model').show();
        $('#error_model').text("Model không được để trống");
        checkErrorProduct = true;
    } else {
        $('#error_model').hide();
        checkErrorProduct = false;
    }
}

$('#Model').keyup(() => {
    errorModel();
});
$('#Model').keydown(() => {
    errorModel();
});
//
const errorOrigin = () => {
    if ($('#Origin').val() == '') {
        $('#error_origin').show();
        $('#error_origin').text("Xuất xứ sản phẩm không được để trống");
        checkErrorProduct = true;
    } else {
        $('#error_origin').hide();
        checkErrorProduct = false;
    }
}

$('#Origin').keyup(() => {
    errorOrigin();
});
$('#Origin').keydown(() => {
    errorOrigin();
});
// 
const errorAmount = () => {
    if ($('#Amount').val() === '' || Number($('#Amount').val()) < 0) {
        $('#error_amount').show();
        $('#error_amount').text("Số lượng không được để trống hoặc nhỏ hơn 0");
        checkErrorProduct = true;
    } else {
        $('#error_amount').hide();
        checkErrorProduct = false;
    }
}
$('#Amount').keyup(() => {
    errorAmount();
});
$('#Amount').keydown(() => {
    errorAmount();
});
// 

const errorGuarantee = () => {
    if ($('#Guarantee').val() === '' || Number($('#Guarantee').val()) < 0) {
        $('#error_guarantee').show();
        $('#error_guarantee').text("Bảo hành không được để trống hoặc nhỏ hơn 0");
        checkErrorProduct = true;
    } else {
        $('#error_guarantee').hide();
        checkErrorProduct = false;
    }
}
$('#Guarantee').keyup(() => {
    errorGuarantee();
});
$('#Guarantee').keydown(() => {
    errorGuarantee();
});

//
const errorImage = () => {
    let fileCheck = $('#inputFile')[0].files[0];
    if ($('#ID_Product').val() == '' && fileCheck == null) {
        $('#error_image').show();
        $('#error_image').text("Ảnh không được để trống");
        checkErrorProduct = true;
    } else {
        $('#error_image').hide();
        checkErrorProduct = false;
    }
}


$("#inputFile").change(() => {
    errorImage();
});

//======= Bat loi san pham _ End ================================


function clickSaveProduct() {
    let data = {};
    data["Name"] = $('#Name').val();
    data["ID_Category"] = Number($('#Category').val());
    data["Price"] = $('#Price').val();
    data["Model"] = $('#Model').val();
    data["Amount"] = $('#Amount').val();
    data["Guarantee"] = $('#Guarantee').val();
    data["Origin"] = $('#Origin').val();
    data["Discount"] = $('#Discount').val();
    data["ShortDescription"] = $('#ShortDescription').val();
    data["Detail"] = detail.getData();
    data["Status"] = $("#show").is(":checked") ? true : false;
    data["ID_Product"] = Number($('#ID_Product').val());

    errorName();
    errorPrie();
    errorModel();
    errorAmount();
    errorGuarantee();
    errorOrigin();
    errorImage();

    if (checkErrorProduct) return;

    let file = $('#inputFile')[0].files[0];
    if (file != undefined) {
        var reader = new FileReader();
        reader.onload = function (e) {
            data["Base64"] = e.target.result;
            data["Image"] = file.name;
            if (data["ID_Product"] == 0) {
                addData(data);
            } else {
                editData(data);
            }
        };
        reader.readAsDataURL(file);
    }
    else {
        data["Image"] = $('#imagename').val();
        if (data["ID_Product"] == 0) {
            addData(data);
        } else {
            editData(data);
        }
    }
}
function addData(data) {
    $.ajax({
        url: '/Admin/Product/AddProducts',
        data: JSON.stringify(data),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: (result) => {
            //alert("Thêm sản phẩm thành công.");
            window.location = "/Admin/Product?mess=create_success";
        },
        error: (error) => {
            //alert("Thêm sản phẩm thất bại!");
            showAlertMessage("Thêm sản phẩm thất bại!", false);
        }
    });
}
function editData(data) {
    $.ajax({
        url: '/Admin/Product/AddProducts',
        data: JSON.stringify(data),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: (result) => {
            //alert("Cập nhật sản phẩm thành công.");
            window.location = "/Admin/Product?mess=edit_success";
        },
        error: (error) => {
            //alert("Cập nhật sản phẩm thành công.");
            window.location = "/Admin/Product?mess=edit_success";
        }
    });
}

const showAlertMessage = (message, messageState) => {
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
    setTimeout(() => {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    }, 3000);
};
