(function () {
  $(document).ready(function() {
    var toggle = $('#admin-table-toggle-show');
    var table = $('#admin-table').DataTable({ pageLength: 25 });
    var rows = [];

    table.rows().every( function () {
      row = this.node();
      if( $(row).hasClass('info') ) {
        $(row).addClass('hidden');
        rows.push(row);
      }
    });

    toggle.on('click', function(e) {
      e.preventDefault();
      if(toggle.attr('data-show-inactive') == 0) {
        toggleRowVisibility(1);
        toggle.attr('data-show-inactive', 1);
        toggle.text('Hide inactive');
      }
      else {
        toggleRowVisibility(0);
        toggle.attr('data-show-inactive', 0);
        toggle.text('Show inactive');
      }
    });

    function toggleRowVisibility(option) {
      $(rows).each( function () {
        if(option == 1) {
          $(this).removeClass('hidden');
        }
        else {
          $(this).addClass('hidden');
        }
      });
    }

  });
})();
