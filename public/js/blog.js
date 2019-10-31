$('.avatar').each(function (index,item) {
    $(this).mouseover(function () {
        $(this).siblings('.userInfo-position').show()
    }).mouseout(function () {
        $(this).siblings('.userInfo-position').hide()
    })
})