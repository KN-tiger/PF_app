$(function(){
    $('#item-image').change(function(){
        $('img').remove();
        const file = $(this).prop('files')[0];
        const fileReader = new FileReader();
        fileReader.onloadend = function() {
            $('#preview').html('<img src="' + fileReader.result + '"/>');
            $('img').addClass('preview-size');
            }
        fileReader.readAsDataURL(file);
    });
});