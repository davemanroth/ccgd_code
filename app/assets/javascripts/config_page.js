(function() {
  $(document).ready(function() {
    var display = $("#config-display");
    var loading = $(".loading");
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
      console.log(e.target.value);
      display.load(e.target.value);
    });
  });
})()
