(function() {
  $(document).ready(function() {
    display = $("#config-display");
    loading = $(".loading");
    loading.hide();

    $(document).on({
      ajaxStart: function () {
        loading.show();
      },
      ajaxStop: function() {
        loading.hide();
        $('#admin-table').DataTable().draw();
      }
    });

    $("#config-options").on("change", function(e) {
      console.log(e.target.value);
      display.load(e.target.value);
    });
  });
})()
