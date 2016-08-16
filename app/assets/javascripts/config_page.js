(function() {
  $(document).ready(function() {
    var display = $("#config-display");
    var loading = $(".loading");
    var create = $('#create-btn');
    var createText = create.html().split(' ');
    [loading, create].map(hideComponent);

    $(document).on({
      ajaxStart: function () {
        showComponent(loading);
      },
      ajaxStop: function() {
        hideComponent(loading);
        $('#admin-table').DataTable({ destroy: true });
      }
    });

    $("#config-options").on("change", function(e) {
      if(e.target.value == '') {
        display.children().remove();
        hideComponent(create);
        return;
      }
      display.load(e.target.value, function() {
        var target = singularize(e.target.value);
        createText = reloadCreateText(createText);
        createText.push(target);
        create.html(createText.join(' '));
        showComponent(create);
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

    function hideComponent(component) {
      component.hide();
    }

    function showComponent(component) {
      component.show();
    }
  });
})()
