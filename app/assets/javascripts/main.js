(function($) {
	$().ajaxSend(function(a, xhr, s){ // Set request headers globally
		xhr.setRequestHeader("Accept", "text/javascript, text/html, application/xml, text/xml, */*");
	});
})(jQuery);

if($('#loading')) {
  $('#loading').ajaxStart(function(){
    $(this).show();
  });
  $('#loading').ajaxStop(function(){
    $(this).hide();
  });
}

function notifyUser(json, user) {
  if(user !== json.performed_by) {
    $('#notification-bar div.content').replaceWith(json.notification);
    $('#notification-bar').slideDown('slow');
    setTimeout(function() {
      $("#notification-bar").slideUp('slow');
    }, 5000);
  }
}

function setupTaskBoard(project_id, user_story_id) {

  var us_container = '#user_story_container_' + user_story_id;
  $(us_container).find('div.task-card').draggable({delay: 100, zIndex: 100});

  var items_with_paths = {"#incomplete_": "/renounce",
		          "#inprogress_": "/claim",
		          "#complete_":   "/complete"};

  $.each(items_with_paths, function(item, path) {
    $(item + user_story_id).droppable({
      accept: us_container + ' div.task-card',
      drop: function(event, props) {
        $.ajax({
          url: '/projects/' + project_id + '/user_stories/' + user_story_id + '/tasks/' + props.draggable.attr('data-task') + path,
          type: 'POST',
          data: { _method: 'PUT' },
          dataType: 'jsonp'
        });
      }
    });
  });
}

function setupTaskBoards(project_id, user_story_ids) {
  user_story_ids.forEach(function(usId){ setupTaskBoard(project_id, usId); });
}

function setupSprintPlanning(project_id, sprint_id) {
  $('#estimated').sortable({
    items: 'div.backlog-item',
    connectWith: '#committed',
    receive: function(event, ui) {
      $.post('/projects/' + project_id + '/sprints/' + sprint_id + '/user_stories/' + ui.item.attr('data-story') + '/unplan', {format: 'json'}, function(data) {
        if(data.ok === true) {
          $('#points_planned').html(data.points_planned + ' story points');
          $('#flashs').html('Sprint reordered');
        }
      }, "json");
      $('#estimated > .drop-here').appendTo("#estimated");
    }
  });

  $('#committed').sortable({
    items: 'div.backlog-item',
    connectWith: '#estimated',
    update: function(event, ui) {
      $.post('/projects/' + project_id + '/sprints/' + sprint_id + '/user_stories/' + ui.item.attr('data-story') + '/reorder', {move_to: ui.item.index() - 1}, function(data) {
        if(data.ok === true) {
          $('#flashs').html('Sprint reordered');
        }
      }, "json");
    },
    receive: function(event, ui) {
      $.post('/projects/' + project_id + '/sprints/' + sprint_id + '/user_stories/' + ui.item.attr('data-story') + '/plan', {format: 'json'}, function(data) {
        if(data.ok === true) {
          $('#points_planned').html(data.points_planned + ' story points');
          $('#flashs').html('Sprint reordered');
        }
      }, "json");
      $('#committed > .drop-here').appendTo("#committed");
    }
  });
}

$(function() {

  // Return a helper with preserved width of cells
  var fixHelper = function(e, ui) {
    ui.children().each(function() {
      $(this).width($(this).width());
    });
    return ui;
  };

  if ( $('#backlog-items').length > 0 ) {
    $('#backlog-items').sortable({
      items: 'div.backlog-item',
      update: function(event, ui) {
      var project_id = $(this).attr('data-project');
        $.post('/projects/' + project_id + '/backlog/sort', {user_story_id: ui.item.attr('data-story'), move_to: ui.item.index() - 1}, function(data) {
          if(data.ok === true) {
            $('#flashs').html('Backlog reordered');
            Agileista.setupVelocityMarkers(data.velocity);
          }
        }, "json");
      }
    });
  }

  $('.js-new-task-input').keyup(function(){
    if($(this).val().length !== 0){
      $(this).parent().parent().next('.js-new-task-button').attr('disabled', false);
    }
    else {
      $('.js-new-task-button').attr('disabled', true);
    }
  });

  $('.js-new-task-button').attr('disabled', true);

});
