

function clickSaveCategory() {
    let data = {};
    let checkError = false;
    data["Name"] = $('#Name').val();
    if (data["Name"] == "") {
        $('#error_name').show();
        $('#error_name').text("Tên danh mục không được bỏ trống");
        checkError = true;
    }
    data["Status"] = $("#show").is(":checked") ? true : false;
    data["ID_Category"] = 0;
    data["ID_Category"] = Number($('#id').val());


    let file = $('#inputFile')[0].files[0];
    if (data["ID_Category"] == 0 && file == null) {
        $('#error_image').show();
        $('#error_image').text("Ảnh danh mục không được để trống");
        checkError = true;
    }

    if (checkError) return;
    if (file != undefined) {
        var reader = new FileReader();
        reader.onload = function (e) {
            data["Base64"] = e.target.result;
            data["Icon"] = file.name;
            if (data["ID_Category"] == 0) {
                addData(data);
            } else {
                editData(data);
            }
        };
        reader.readAsDataURL(file);
    } else {
        data["Icon"] = $('#imagename').val();
        if (data["ID_Category"] == 0) {
            addData(data);
        } else {
            editData(data);
        }
    }


}

function addData(data) {
    $.ajax({
        url: '/Admin/Category/AddProductCategory',
        data: JSON.stringify(data),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: (result) => {
            showAlertMessage('Thêm danh mục thành công!', true);
            //$('#modal-create').modal().hide();
            //$("#modal-create").modal({ backdrop: false });
            //$('.modal-backdrop').remove();
            $('#modal-create').modal().hide();
            $('.modal-backdrop').remove();
            //alert("Thêm danh mục thành công.");
            //$("#modal-create").modal("hide");
            setDataCategory(
                result["ID_Category"],
                result["Name"],
                result["Icon"],
                result["Status"],
                per_edit,
                per_del
            );
        },
        error: (error) => {
            //alert("Thêm danh mục thất bại!");
            showAlertMessage('Thêm danh mục thất bại!', false);
        }
    });
}
function editData(data) {

    $.ajax({
        url: '/Admin/Category/AddProductCategory',
        data: JSON.stringify(data),
        type: "POST",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: (result) => {
            showAlertMessage('Cập nhật danh mục thành công!', true);

            //$('#modal-create').modal().hide();
            //$("#modal-create").modal({ backdrop: false });
            //$('.modal-backdrop').remove();
            //alert("Cập nhật danh mục thành công.");
            $('#modal-create').modal().hide();
            $('.modal-backdrop').remove();
            editCategory(
                result["ID_Category"],
                result["Name"],
                result["Icon"],
                result["Status"],
                per_edit,
                per_del
            );

            //$('#modal-create').modal().hide();
            //location.reload();
        },
        error: (error) => {
            showAlertMessage('Cập nhật danh mục thất bại!', false);
            //alert("Cập nhật danh mục thất bại!");
        }
    });
}


const setDataCategory = (id, name, icon, status, per_edit, per_del) => {
    let showStatus = status ? "Hiển thị" : "Ẩn";
    let f_edit = '';
    let f_del = '';
    if (per_edit) {
        f_edit = 'title="Sửa" data-toggle="modal" data-target="#modal-create"' +
            'onclick="clickEditCategory(' + id + ',\'' + name + '\',\'' + icon + '\',' + status + ')"';
    } else {
        f_edit = 'onclick="clickPer()"';
    }
    if (per_del) {
        f_del = 'onclick="deleteCategory(' + id + ')"';
    } else {
        f_del = 'onclick="clickPer()"';
    }
    $('#data-category').append(
        '<tr class="tr-shadow" id="' + id + '">' +
        '<td class="block-icon">' +
        '<img src="/wwwroot/imageUpload/' + icon +
        '" alt="Icon" style="max-width: 25px; max-height: 25px;"/>' +
        '</td>' +
        '<td>' +
        '<span class="block-name-product" id="name-product">' + name + '</span>' +
        '</td>' +
        '<td>' +
        '<span class="status--process" id="show-status">' + showStatus + '</span>' +
        '</td>' +
        '<td>' +
        '<div class="table-data-feature">' +
        '<button class="item" title="Sửa" ' + f_edit+'>' +
        '<i class="fas fa-pencil-alt"></i>' +
        '</button>' +
        '<button class="item" title="Xóa" ' + f_del + ' >' +
        '<i class="fas fa-trash-alt"></i>' +
        '</button>' +
        '</div>' +
        ' </td>' +
        '</tr>' +
        ' <tr class="spacer" id="spacer-' + id + '"></tr>'
    );
}

const editCategory = (id, name, icon, status, per_edit, per_del) => {
    let showStatus = status ? "Hiển thị" : "Ẩn";
    let f_edit = '';
    let f_del = '';
    if (per_edit) {
        f_edit = 'title="Sửa" data-toggle="modal" data-target="#modal-create"' +
            'onclick="clickEditCategory(' + id + ',\'' + name + '\',\'' + icon + '\',' + status + ')"';
    } else {
        f_edit = 'onclick="clickPer()"';
    }
    if (per_del) {
        f_del = 'onclick="deleteCategory(' + id + ')"';
    } else {
        f_del = 'onclick="clickPer()"';
    }
    $('#' + id).html(
        '<td class="block-icon">' +
        '<img src="/wwwroot/imageUpload/' + icon +
        '" alt="Icon" style="max-width: 25px; max-height: 25px;"/>' +
        '</td>' +
        '<td>' +
        '<span class="block-name-product" id="name-product">' + name + '</span>' +
        '</td>' +
        '<td>' +
        '<span class="status--process" id="show-status">' + showStatus + '</span>' +
        '</td>' +
        '<td>' +
        '<div class="table-data-feature">' +
        '<button class="item" title="Sửa" ' + f_edit + '>' +
        '<i class="fas fa-pencil-alt"></i>' +
        '</button>' +
        '<button class="item" title="Xóa" ' + f_del + ' >' +
        '<i class="fas fa-trash-alt"></i>' +
        '</button>' +
        '</div>' +
        ' </td>'
    );
}