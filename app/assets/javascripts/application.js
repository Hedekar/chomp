// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(document).on('hidden.bs.modal', function(e) {
  $(e.target).removeData('bs.modal');
});

function nutritions_search_update_page(page)
{
  $("input[name=page]").val(page);
  $("input[type=submit]").click();
}

function stylize_nutrition_window() {
  var i =0;
  $(".nutrition_details .item").each(function(){
    if(i%2==0)
      $(this).addClass("left");
    else
      $(this).addClass("right");
    
    i++;
  });
}

function submit_nutrition_form() {
  $("#nutrition_form").submit();
  update_profile_panel();
  $("#my-modal").modal('hide');
}

function update_profile_panel() {
  $("#tracking_box").load("/track");
}