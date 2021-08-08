const clickMoveEmployeeToTrash = (id_account) => {
    let checkDelete = confirm("Xác nhận vô hiệu hóa tài khoản này!");
    if (checkDelete == false)
        return;

    $.ajax({
        url: '/Admin/Account/ChangeStatusAccount',
        data: { id_account: id_account, status: false },
        type: "GET",
        success: (result) => {
            if (result) {
                showAlertMessage('Di chuyển tài khoản nhân viên vào thùng rác!', true);
                $('#' + id_account).remove();
            } else {
                showAlertMessage('Xóa tài khoản nhân viên vào thất bại!', false);
            }


        },
        error: (error) => {
            //alert("Xãy ra lỗi trong quá trình xóa tài khoản!");
            showAlertMessage('Xãy ra lỗi trong quá trình xóa tài khoản!', false);
        }
    });
}

const loadFile = (event) => {
    let image = document.getElementById('output');
    image.src = URL.createObjectURL(event.target.files[0]);
};

//========== Bat loi mat khau - Start ==================
let regexPassword = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*_]).{6,}$");
let checkErrorUpdatePassword = false;
//-------------------------------------------------------------
// Bat loi mat khau cu
const errorOldPassword = () => {
    if ($('#OldPassword').val() == '') {
        $('#error_old_password').show();
        $('#error_old_password').text("Mật khẩu cũ không được bỏ trống");
        checkErrorUpdatePassword = true;
    } else {
        $('#error_old_password').hide();
        checkErrorUpdatePassword = false;
    }
}
$('#OldPassword').keydown(() => {
    errorOldPassword();
});
$('#OldPassword').keyup(() => {
    errorOldPassword();
});
//------------------------------------------------------------------------
// Bat lo mat khau moi
const errorNewPassword = () => {
    let newPassowrd = $('#NewPassword').val();
    if (newPassowrd == '') {
        $('#error_new_password').show();
        $('#error_new_password').text("Mật khẩu mới không được bỏ trống!");
        checkErrorUpdatePassword = true;
    } else if (!regexPassword.test(newPassowrd)) {
        $('#error_new_password').show();
        $('#error_new_password').text("Mật khẩu ít nhất 6 ký tự và gồm các chữ cái hoa, thường, chữ số và ký tự đặc biệt!");
        checkErrorUpdatePassword = true;
    } else {
        $('#error_new_password').hide();
        checkErrorUpdatePassword = false;
    }
}
$('#NewPassword').keydown(() => {
    errorNewPassword();
});
$('#NewPassword').keyup(() => {
    errorNewPassword();
});
//------------------------------------------------------------
// Bat loi Confirm pasword 
const errorConfirmPassword = () => {
    let newPassowrd = $('#NewPassword').val();
    let confirmPassword = $('#ConfirmPassword').val();
    if (confirmPassword == '') {
        $('#error_confirm_password').show();
        $('#error_confirm_password').text("Nhập lại mật khẩu không được bỏ trống!");
        checkErrorUpdatePassword = true;
    }else if (newPassowrd != confirmPassword) {
        $('#error_confirm_password').show();
        $('#error_confirm_password').text("Nhập lại mật khẩu mới không trùng khớp!");
        checkErrorUpdatePassword = true;
    } else {
        $('#error_confirm_password').hide();
        checkErrorUpdatePassword = false;
    }
}

$('#ConfirmPassword').keydown(() => {
    errorConfirmPassword();
});
$('#ConfirmPassword').keyup(() => {
    errorConfirmPassword();
});
//========== Bat loi mat khau - End ==================
const clickChangePassword = (id_account) => {
    event.preventDefault();
    let newPassowrd = $('#NewPassword').val();
    let oldPassowrd = $('#OldPassword').val();
    
    errorOldPassword();
    errorNewPassword();
    errorConfirmPassword();

    if (checkErrorUpdatePassword) return;

    $.ajax({
        url: '/Admin/Account/UpdatePassword',
        data: {
            OldPassword: oldPassowrd,
            NewPassword: newPassowrd,
            ID_Account: id_account
        },
        type: "GET",
        success: (result) => {
            if (result) {
                //showAlertMessage('Cập nhật mật khẩu thành công!', true);
                //location.reload();
                window.location = '/Admin/Account?status=update_success';
            } else {
                $('#error_old_password').show();
                $('#error_old_password').text("Mật khẩu cũ không đúng!");
                $('#error_new_password').hide();
                $('#error_confirm_password').hide();
            }

        },
        error: (error) => {
            showAlertMessage('Cập nhật mật khẩu thất bại!', false);
        }
    });
}

//============ Bat loi cap nhat thong tin ca nhan - Start ======================

let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
let phoneFormat = /^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/;
let checkErrorUpdateInfo = false;
//--------------------------------------------
// Bat loi full name
const errorFullName = () => {
    if ($('#FullName').val() == '') {
        $('#error_full_name').show();
        $('#error_full_name').text('Họ tên không được để trống');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_full_name').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#FullName').keydown(() => {
    errorFullName();
});
$('#FullName').keyup(() => {
    errorFullName();
});

//------------------------------------------------
// Bat loi address
const errorAddress = () => {
    if ($('#Address').val() == '') {
        $('#error_address').show();
        $('#error_address').text('Địa chỉ không được để trống');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_address').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Address').keydown(() => {
    errorAddress();
});
$('#Address').keyup(() => {
    errorAddress();
});
//------------------------------------------------
// Bat loi email
const errorEmail = () => {
    let email = $('#Email').val();
    if (email == '') {
        $('#error_email').show();
        $('#error_email').text('Email không được để trống');
        checkErrorUpdateInfo = true;
    } else if (!emailPattern.test(email)) {
        $('#error_email').show();
        $('#error_email').text('Lỗi định dạng email');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_email').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Email').keydown(() => {
    errorEmail();
});
$('#Email').keyup(() => {
    errorEmail();
});
//------------------------------------------------
// Bat loi phone
const errorPhone = () => {
    let phone = $('#Phone').val();
    if (phone == '') {
        $('#error_phone').show();
        $('#error_phone').text('Số điên thoại không được để trống');
        checkErrorUpdateInfo = true;
    } else if (!phoneFormat.test(phone)) {
        $('#error_phone').show();
        $('#error_phone').text('Số điện thoại nhập không đúng định dạng');
        checkErrorUpdateInfo = true;
    } else {
        $('#error_phone').hide();
        checkErrorUpdateInfo = false;
    }
}
$('#Phone').keydown(() => {
    errorPhone();
});
$('#Phone').keyup(() => {
    errorPhone();
});

//============ Bat loi cap nhat thong tin ca nhan - End ======================
const clickUpdateInfo = () => {

    /*let fullName = $('#FullName').val();
    let address = $('#Address').val();
    let email = $('#Email').val();
    let phone = $('#Phone').val();*/
    //let checkError = false;
    errorFullName();
    errorAddress();
    errorEmail();
    errorPhone();
    if (checkErrorUpdateInfo) event.preventDefault();

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