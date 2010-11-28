// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  $(".credito").hide();
  $("#venta_tipo_pago").change(function() {
    if ($(this).children(":selected").val() == "1")
      $(".credito").show();
    else
      $(".credito").hide();
  });
  $(".notice").delay(6000).slideUp();
});

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
  }

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));
  }
