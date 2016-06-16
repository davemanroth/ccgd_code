(function() {
  $(document).ready(function() {
    var form = $('#proposal-status-update form');
    var row = form.parent().parent().parent();
    var select = $('#proposal-status-update select');
    var button = $('#proposal-status-update #submit-update');
    var selected = getSelected(select);
    var pendingClass = 'warning';

    select.on('change', function(e) {
      selected = getSelected($(this));
      thisForm = $(this).next();
      formUrl = getUrl(thisForm);
      thisForm.attr('action', formUrl + selected);
    });

    button.on('click', function() {
      var row = $(this).closest('tr');
      if(isPending(selected)) {
        if(!row.hasClass(pendingClass)) {
          row.addClass(pendingClass); 
        }
      }
      else if (row.hasClass(pendingClass) ) {
        row.removeClass(pendingClass);
      }
      else {}
    });

    function getSelected(select) {
      return $(select).find('option:selected').val();
    }

    function getUrl(thisForm) {
      return thisForm.attr('action').substr(0, thisForm.attr('action').length - 1);
    }

    function isPending(value) {
      return value == 2;
    }
  });
})()
