// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  if ($("#venta_tipo_pago").val() != "1") {
    $(".credito").hide();
    $(".destroy_build").val("1");
  }

  $("#venta_tipo_pago").change(function() {
    if ($(this).children(":selected").val() == "1") {
      $(".destroy_build").val("0");
      $(".credito").show();
    }
    else {
      $(".destroy_build").val("1");
      $(".credito").hide();
    }
  });

  $(".notice").delay(6000).slideUp();
  $(".actualizar_pedido").hide()
  $(".text_field_cantidad").change(function() {
    $(".enviar_pedido").hide();
    $(".actualizar_pedido").show();
  });

  // funcion para evitar que no ajuste stock al eliminar un detalle
  $(function() {
    $(".eliminardetalle").change(function (){
      if ($(".eliminardetalle").val() == "1") {
        $(".enviarventa").hide(); 
      }
    });
  });

  $(function() {
    $("#producto_categoria").change(function() {
      window.location.href='/catalogo?categoria=' + $("#producto_categoria").val();
    });
  });

  $(function(){
    $('#fecha_datos_2i').change(function() {
      window.location.href='libro_ventas?month=' + $('#fecha_datos_2i').val() + '&year=' + $('#fecha_datos_1i').val()
    });
    $('#fecha_datos_1i').change(function() {
      window.location.href='libro_ventas?month=' + $('#fecha_datos_2i').val() + '&year=' + $('#fecha_datos_1i').val()
    });
  });

  $(function(){
    $('#datos_fecha_2i').change(function() {
      window.location.href='cierre_venta?month=' + $('#datos_fecha_2i').val() + '&year=' + $('#datos_fecha_1i').val()
    });
    $('#datos_fecha_1i').change(function() {
      window.location.href='cierre_venta?month=' + $('#datos_fecha_2i').val() + '&year=' + $('#datos_fecha_1i').val()
    });
  });

  $(function(){
    $('#fecha_venta_2i').change(function() {
      window.location.href='ventas?month=' + $('#fecha_venta_2i').val() + '&year=' + $('#fecha_venta_1i').val() + '&day=' + $('#fecha_venta_3i').val()
    });
    $('#fecha_venta_1i').change(function() {
      window.location.href='ventas?month=' + $('#fecha_venta_2i').val() + '&year=' + $('#fecha_venta_1i').val() + '&day=' + $('#fecha_venta_3i').val()
    });
    $('#fecha_venta_3i').change(function() {
      window.location.href='ventas?month=' + $('#fecha_venta_2i').val() + '&year=' + $('#fecha_venta_1i').val() + '&day=' + $('#fecha_venta_3i').val()
    });
  });


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

