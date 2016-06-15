(function() {
  $(document).ready(function() {
    var form = $('#proposal-status-update form');
    var url = form.attr('action') + '/';
    var select = $('#proposal-status-update select');
    var selected = getSelected(select);

    select.on('change', function(e) {
      selected = getSelected($(this));
      form.attr('action', url + selected);
    });

    function getSelected(select) {
      return select.find('option:selected').val();
    }
  });
})()
