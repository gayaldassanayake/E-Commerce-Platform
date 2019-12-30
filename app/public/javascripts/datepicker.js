$(document).ready(function(){

    var startdate_input=$('input[name="start_date"]'); 
    var datepickerstart=new Date();
    var selectedStartDate=new Date();
    var selectedEndDate=new Date();
    if($("#start_date_hidden").val()){
        if(datepickerstart > new Date($("#start_date_hidden").val())){
            datepickerstart=new Date($("#start_date_hidden").val());
        }
        selectedStartDate=new Date($("#start_date_hidden").val());
    }

    if($("#end_date_hidden").val()){
        selectedEndDate=new Date($("#end_date_hidden").val());
    }
    var options1={

        format: 'yyyy/mm/dd',
        todayHighlight: true,
        autoclose: true,
        
    };
    startdate_input.datepicker(options1);

    var enddate_input=$('input[name="end_date"]');
    var options2={
        format: 'yyyy/mm/dd',
        todayHighlight: true,
        autoclose: true
    };
    enddate_input.datepicker(options2);


    $('#start_date').datepicker('update',selectedStartDate);
    $('#end_date').datepicker('update', selectedEndDate);

})


$(function () {

    $("#start_date").on('changeDate', function (e) {
        $('#end_date').datepicker('setStartDate',e.date);

        if(new Date($('#end_date').val())<e.date){
            $('#end_date').datepicker('update', e.date);

        }
    });

});

