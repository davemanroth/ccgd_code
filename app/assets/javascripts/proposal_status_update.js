(function() {
  $(document).ready(function() {
    var form = $('#proposal-status-update form');
    var row = form.parent().parent().parent();
    var url = form.attr('action') + '/';
    var select = $('#proposal-status-update select');
    var button = $('#proposal-status-update #submit-update');
    var selected = get_selected(select);

    select.on('change', function(e) {
      selected = get_selected($(this));
      form.attr('action', url + selected);
    });

    button.on('click', function() {
      modify_classes(row);
      if(is_pending(selected)) {
        // change classes
      }
    });

    function get_selected(select) {
      return select.find('option:selected').val();
    }

    function is_pending(value) {
      return value == 2;
    }

    function modify_classes(row) {
      var classes = row.attr('class');
      console.log(classes.split(' '));
    }
  });
})()
