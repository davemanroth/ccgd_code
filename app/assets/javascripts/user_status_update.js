(function () {
  $(document).ready(function() {

  // POJO of actions for each user row's button type
    var actions = {
      approve: {
        type: 'approve',
        remove: false,
        text: 'Active',
        btn_stat: 'I',
        btn_type: 'warning',
        btn_text: 'Deactivate',
        row_style: ''
      },
      reactivate: {
        type: 'reactivate',
        remove: false,
        text: 'Active',
        btn_stat: 'I',
        btn_type: 'warning',
        btn_text: 'Deactivate',
        row_style: ''
      },
      deactivate: {
        type: 'deactivate',
        remove: false,
        text: 'Inactive',
        btn_stat: 'A',
        btn_type: 'success',
        btn_text: 'Reactivate',
        row_style: 'info'
      },
      reject: {
        type: 'reject',
        remove: true
      }
    };

  // Handle action buttons' click events and respond accordingly
    $('.user-admin-table tbody tr').on('click', function(e) {

      // First check to make sure one of the action buttons was clicked
      if (e.target.nodeName != 'A') {
        return;
      }

      // Next, make sure preventDefault does not affect the 'Edit' button
      if (e.target.innerText != 'Edit') {
        e.preventDefault();
      }

      // Check the button that was clicked and perform the corresponding action
      var href = e.target.pathname.slice(0,-1);
      var action = actions[e.target.innerText.toLowerCase()];
      if (action != undefined) {
        if( action.remove ) {
          //$(this).remove();
          console.log('Are you sure you want to ' + action.type + ' this user?');
        }
        else {
          var button = generate_button(href + action.btn_stat, action.btn_type, action.btn_text);
          $(this).removeClass().addClass(action.row_style);
          $(this).find('.user-edit').siblings().remove();
          $(this).find('.user-status').text(action.text)
          $(this).find('.user-actions').append(button);
        }
      }
    });

  // Generate the apprpriate button to replace current button(s)
    function generate_button(href, type, text) {
      var button = '<a class="btn btn-' + type + '" ';
      button += 'href="' + href + '" ';
      button += 'data-remote="true" data-method="patch">';
      button += text + '</a>';
      return button;
    }

  });
})();
