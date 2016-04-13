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
      btn_style: 'warning'
    },
    deactivate: {
      type: 'deactivate',
      remove: true
    },
    reject: {
      type: 'reject',
      remove: true
    }
  };

// Handle action buttons' click events and respond accordingly
  $('#users tbody tr').on('click', function(e) {
    if (e.target.innerText != 'Edit') {
      e.preventDefault();
    }
    href = e.target.pathname.slice(0,-1);
    var action = actions[e.target.innerText.toLowerCase()];
    if (action != undefined) {
      if( action.remove ) {
        //$(this).remove();
        console.log('Are you sure you want to ' + action.type + ' this user?');
      }
      else {
        var button = generate_button(href + action.btn_stat, action.btn_type, action.btn_text);
        $(this).removeClass(action.btn_style)
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
