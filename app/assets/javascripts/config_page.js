(function() {
  $(document).ready(function() {
    var configTable = $("#config-table");
    var configForm = $("#config-form");
    var loading = $(".loading");
    var create = $("#create-btn");
    var createText;
    [loading, create].map(hideComponent);

    if (configTable.length > 0) {
      dataConfirmModal.setDefaults({ commit: "Delete" })
    }

    $(document).on({
      ajaxStart: function () {
        showComponent(loading);
      },
      ajaxStop: function() {
        hideComponent(loading);
        $("#admin-table").DataTable({ destroy: true });
      }
    });

    if( create.length > 0) {
      createText = create.html().split(" ");
    }

    // Handle actions based on user choice form select list
    $("#config-options").on("change", function(e) {
      var target = e.target.value;

      if( target == "") {
        configTable.children().remove();
        hideComponent(create);
        return;
      }

      var action = singularize(target);
      var path = [target, "rendering=dynamic"].join("?");
      configTable.load(path, function() {
        createText = reloadCreateText(createText);
        createText.push(action);
        create.html(createText.join(" "));
        create.attr("href", [target, "new"].join("/"));
        showComponent(create);
        activateDeleteAction();
      });
    });


    // Handle delete action from any admin table
    // This simply hides the row via css to make it 
    // appear as if it deleted imeediately. 
    // The server code does the actual deleting
    function activateDeleteAction() {
      configTable.find("table tr").on("click", function (e) {
        if (e.target.innerHTML === "Delete") {
          var row = $(e.target).closest("tr")
          $(document).on("click", function (e) {
            if ( $(e.target).hasClass("commit") ) {
              row.addClass("hidden");
            }
          });
        }
      });
    }

    function singularize(text) {
      if( text.slice(-3) == "ses" ) {
        return text.slice(0, -2);
      }
      if (text.search(/\_/) ) {
        text = text.split("_").join(" ");
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

    function pathOps() {
      return {
        path: "",
        setPath: function(newpath) {
          this.path = newpath;
        },
        getPath: function() {
          return this.path;
        }
      }
    }

  });
})()
