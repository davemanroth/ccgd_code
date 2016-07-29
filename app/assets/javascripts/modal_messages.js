(function() {
  $(document).ready(function() {
    $('#app-modal').on('show.bs.modal', function(e) {
      var button = $(e.relatedTarget);
      var message = button.data('message');
      var modal = $(this);
      modal.find('.modal-body p').text(message);
    });
    /*
    $('.modal-confirm').on('click', function(e) {
      button = e.target;
      console.log( $(button).attr('data-message') );
    });
    */
  });
})();
