$(document).ready(function () {
    $('#checkAll').change(function () {
        var checkItem = $('.checkAllItem');
        if ($(this).prop("checked") == true) {
            for (var i = 0; i < checkItem.length; i++) {
                checkItem[i].checked = true;
            }
        }
        else if ($(this).prop("checked") == false) {
            for (var i = 0; i < checkItem.length; i++) {
                checkItem[i].checked = false;
            }
        }
    });
})


$("#btnDelete").click(function () {
    var data = {};
    var ids = $('tbody input[type=checkbox]:checked').map(function () {
        return Number($(this).val());
    }).get();
    data['ids'] = ids;
    if (ids.length == 0) {
        showAlertMessage('Bạn chưa chọn tài khoản muốn xóa!!', false);
        return;
    }
    var confirmDelete = confirm("Xác nhận xóa vĩnh viễn các tài khoản này");
    if (confirmDelete) {
        deleteEmployee(data);
    }
});
function deleteEmployee(data) {
    $.ajax({
        url: '/Admin/Account/RemoveAccountEmployee',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success:  (result) => {
            showAlertMessage('Xóa thông tin tài khoản thành công!!', true);
            location.reload();
        },
        error:  (error) => {
            showAlertMessage('Xóa thông tin tài khoản thất bại!!', false);
        }
    });
}


const clickRestoreAccount = (id_account) => {
    let checkRestore = confirm("Xác nhận khôi phục tài khoản này!");
    if (checkRestore == false)
        return;

    $.ajax({
        url: '/Admin/Account/ChangeStatusAccount',
        data: { id_account: id_account, status: true },
        type: "GET",
        success: (result) => {
            if (result) {
                showAlertMessage('Đã khôi phục tài khoản nhân viên!', true);
                location.reload();
            } else {
                showAlertMessage('Khôi phục tài khoản nhân viên thất bại!', false);
            }


        },
        error: (error) => {
            //alert("Xãy ra lỗi trong quá trình xóa tài khoản!");
            showAlertMessage('Xãy ra lỗi trong quá trình khôi phục tài khoản!', false);
        }
    });
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
    setTimeout(() => {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    }, 3000);
};