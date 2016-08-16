(function() {
  $(document).ready(function() {
    var display = $("#config-display");
    var loading = $(".loading");
    var create = $('#create-btn');
    var createText = create.html().split(' ');
    loading.hide();

    $(document).on({
      ajaxStart: function () {
        loading.show();
      },
      ajaxStop: function() {
        loading.hide();
        $('#admin-table').DataTable({ destroy: true });
      }
    });

    $("#config-options").on("change", function(e) {
      display.load(e.target.value, function() {
        var target = singularize(e.target.value);
        createText = reloadCreateText(createText);
        createText.push(target);
        create.html(createText.join(' '));
      });
    });

    function singularize(text) {
      if( text[text.length - 2] == 'e' ) {
        return text.slice(0, -2);
      }
      return text.slice(0, -1);
    }

    function reloadCreateText(text) {
      return text.length > 3 ? text.slice(0, -1) : text;
    }
  });
})()
