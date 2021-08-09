//------------------------------------------------
// LỌC DỮ LIỆU - START

$('#Category').change(() => {
    let status = $('#status_tmp').val().toLowerCase();
    let search = $('#search_tmp').val();
    let parameter = 'id_category=' + $('#Category').val();
    if (status != '') {
        parameter += '&status=' + status;
    }
    if (search != '') {
        parameter += '&search=' + search;
    }
    window.location = "/Admin/Product?" + parameter;
});

$('#status').change(() => {
    let id_category = $('#id_category_tmp').val();
    let search = $('#search_tmp').val();
    let parameter = 'status=' + $('#status').val();
    if (id_category != -1) {
        parameter += '&id_category=' + id_category;
    }
    if (search != '') {
        parameter += '&search=' + search;
    }
    window.location = "/Admin/Product?" + parameter;

});

// LỌC DỮ LIỆU - END
//-------------------------------------------
const clickPer = () => {
    showAlertMessage('Bạn không có quyền truy cập tính năng này!', false);
}

function deleteProduct(id) {

    let checkDelete = confirm("Xác nhận xóa sản phẩm này!");
    if (checkDelete == false)
        return;

    $.ajax({
        url: '/Admin/Product/DeleteProduct',
        data: { id: id },
        type: "GET",
        success: (result) => {
            //alert("Xóa sản phẩm thành công.");
            showAlertMessage('Xóa sản phẩm thành công!', true);
            $('#' + id).remove();
            $('#spacer-' + id).remove();
        },
        error: (error) => {
            //alert("Xóa sản phẩm thất bại!");
            showAlertMessage('Xóa sản phẩm thất bại!', false);
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