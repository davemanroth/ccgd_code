(function() {
  $(document).ready(function() {
    var display = $("#config-display");
    var loading = $(".loading");
    var create = $('#create-btn');
    var createText = create.html();
    loading.hide();

    $(document).on({
      ajaxStart: function () {
        loading.show();
      },
      ajaxStop: function() {
        loading.hide();
        // $('#admin-table').DataTable().draw();
      }
    });

    $("#config-options").on("change", function(e) {
      //console.log(e);
      display.load(e.target.value);
      var target = singularize(e.target.value);
      create.html(createText + target);
    });

    function singularize(text) {
      return text.slice(0, -1);
    }
  });
})()
