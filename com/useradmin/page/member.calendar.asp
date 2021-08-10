<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim CMS_CONFIG_LST_Table
   CMS_CONFIG_LST_Table = "CMS_CONFIG_LST"

   Dim CC_KEY,CC_VALUE
   Dim CC_TYPE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")
%>
<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li class="active">morris</li>
  </ul>
  <span id="refresh" class="btn btn-ribbon" style="display: inline-block;"><i class="fa fa-refresh"></i></span>
</div>

<link href="/admin/css/fullcalendar.css" rel="stylesheet">

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">morris</h2>
    </div>
  </div>

  <div class="row">

    <div class="col-sm-12 col-md-12 col-lg-3">
      <div class="panel panel-pink">
        <div class="panel-heading"><i class="fa fa-edit"></i> 사이트설정</div>
        <div class="panel-body">


          <form id="add-event-form">
            <fieldset>

              <div class="form-group">
                <label>Select Event Icon</label>
                <div class="btn-group btn-group-sm btn-group-justified" data-toggle="buttons">
                  <label class="btn btn-default active">
                    <input type="radio" name="iconselect" id="icon-1" value="fa-info" checked>
                    <i class="fa fa-info text-muted"></i> </label>
                  <label class="btn btn-default">
                    <input type="radio" name="iconselect" id="icon-2" value="fa-warning">
                    <i class="fa fa-warning text-muted"></i> </label>
                  <label class="btn btn-default">
                    <input type="radio" name="iconselect" id="icon-3" value="fa-check">
                    <i class="fa fa-check text-muted"></i> </label>
                  <label class="btn btn-default">
                    <input type="radio" name="iconselect" id="icon-4" value="fa-user">
                    <i class="fa fa-user text-muted"></i> </label>
                  <label class="btn btn-default">
                    <input type="radio" name="iconselect" id="icon-5" value="fa-lock">
                    <i class="fa fa-lock text-muted"></i> </label>
                  <label class="btn btn-default">
                    <input type="radio" name="iconselect" id="icon-6" value="fa-clock-o">
                    <i class="fa fa-clock-o text-muted"></i> </label>
                </div>
              </div>

              <div class="form-group">
                <label>Event Title</label>
                <input class="form-control"  id="title" name="title" maxlength="40" type="text" placeholder="Event Title">
              </div>
              <div class="form-group">
                <label>Event Description</label>
                <textarea class="form-control" placeholder="Please be brief" rows="3" maxlength="40" id="description"></textarea>
                <p class="note">Maxlength is set to 40 characters</p>
              </div>

              <div class="form-group">
                <label>Select Event Color</label>
                <div class="btn-group btn-group-justified btn-select-tick" data-toggle="buttons">
                  <label class="btn bg-color-darken active">
                    <input type="radio" name="priority" id="option1" value="bg-color-darken txt-color-white" checked>
                    <i class="fa fa-check txt-color-white"></i> </label>
                  <label class="btn bg-color-blue">
                    <input type="radio" name="priority" id="option2" value="bg-color-blue txt-color-white">
                    <i class="fa fa-check txt-color-white"></i> </label>
                  <label class="btn bg-color-orange">
                    <input type="radio" name="priority" id="option3" value="bg-color-orange txt-color-white">
                    <i class="fa fa-check txt-color-white"></i> </label>
                  <label class="btn bg-color-greenLight">
                    <input type="radio" name="priority" id="option4" value="bg-color-greenLight txt-color-white">
                    <i class="fa fa-check txt-color-white"></i> </label>
                  <label class="btn bg-color-blueLight">
                    <input type="radio" name="priority" id="option5" value="bg-color-blueLight txt-color-white">
                    <i class="fa fa-check txt-color-white"></i> </label>
                  <label class="btn bg-color-red">
                    <input type="radio" name="priority" id="option6" value="bg-color-red txt-color-white">
                    <i class="fa fa-check txt-color-white"></i> </label>
                </div>
              </div>

            </fieldset>
            <div class="form-actions">
              <div class="row">
                <div class="col-md-12">
                  <button class="btn btn-default" type="button" id="add-event" >
                    Add Event
                  </button>
                </div>
              </div>
            </div>
          </form>

        </div>
      </div>

    <div class="well well-sm" id="event-container">
      <form>
        <legend>
          Draggable Events
        </legend>
        <ul id='external-events' class="list-unstyled">
          <li>
            <span class="bg-color-darken txt-color-white" data-description="Currently busy" data-icon="fa-time">Office Meeting</span>
          </li>
          <li>
            <span class="bg-color-blue txt-color-white" data-description="No Description" data-icon="fa-pie">Lunch Break</span>
          </li>
          <li>
            <span class="bg-color-red txt-color-white" data-description="Urgent Tasks" data-icon="fa-alert">URGENT</span>
          </li>
        </ul>
        <div class="checkbox">
          <label>
            <input type="checkbox" id="drop-remove" class="checkbox style-0" checked="checked">
            <span>remove after drop</span> </label>

        </div>
      </form>
    </div>

    </div>
    <div class="col-sm-12 col-md-12 col-lg-9">
      <div class="panel panel-greenLight">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> My Events</div>
        <div class="panel-body" id="calendar">

        </div>
      </div>

    </div>
  </div>
</div>


<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/moment.min.js", dt_2);

    function dt_2() {
      loadScript("js/fullcalendar.js", dt_3);
    }

    function dt_3() {
      loadScript("js/fullcalendar-ko.js", pagefunction);
    }

  }

  function runDataTables(){
    alert("11");
  }

  var fullviewcalendar;

  var pagefunction = function() {

    // full calendar

    var date = new Date();
      var d = date.getDate();
      var m = date.getMonth();
      var y = date.getFullYear();

      var hdr = {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
      };

      var initDrag = function (e) {
          // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
          // it doesn't need to have a start or end

          var eventObject = {
              title: $.trim(e.children().text()), // use the element's text as the event title
              description: $.trim(e.children('span').attr('data-description')),
              icon: $.trim(e.children('span').attr('data-icon')),
              className: $.trim(e.children('span').attr('class')) // use the element's children as the event class
          };
          // store the Event Object in the DOM element so we can get to it later
          e.data('eventObject', eventObject);

          // make the event draggable using jQuery UI
          e.draggable({
              zIndex: 999,
              revert: true, // will cause the event to go back to its
              revertDuration: 0 //  original position after the drag
          });
      };

      var addEvent = function (title, priority, description, icon) {
          title = title.length === 0 ? "Untitled Event" : title;
          description = description.length === 0 ? "No Description" : description;
          icon = icon.length === 0 ? " " : icon;
          priority = priority.length === 0 ? "label label-default" : priority;

          var html = $('<li><span class="' + priority + '" data-description="' + description + '" data-icon="' +
              icon + '">' + title + '</span></li>').prependTo('ul#external-events').hide().fadeIn();

          $("#event-container").effect("highlight", 800);

          initDrag(html);
      };

      /* initialize the external events
     -----------------------------------------------------------------*/

      $('#external-events > li').each(function () {
          initDrag($(this));
      });

      $('#add-event').click(function () {
          var title = $('#title').val(),
              priority = $('input:radio[name=priority]:checked').val(),
              description = $('#description').val(),
              icon = $('input:radio[name=iconselect]:checked').val();

          addEvent(title, priority, description, icon);
      });

      /* initialize the calendar
     -----------------------------------------------------------------*/

      fullviewcalendar = $('#calendar').fullCalendar({

          header: hdr,

          editable: true,
          droppable: true, // this allows things to be dropped onto the calendar !!!

          drop: function (date, allDay) { // this function is called when something is dropped

              // retrieve the dropped element's stored Event Object
              var originalEventObject = $(this).data('eventObject');

              // we need to copy it, so that multiple events don't have a reference to the same object
              var copiedEventObject = $.extend({}, originalEventObject);

              // assign it the date that was reported
              copiedEventObject.start = date;
              copiedEventObject.allDay = allDay;

              // render the event on the calendar
              // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
              $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

              // is the "remove after drop" checkbox checked?
              if ($('#drop-remove').is(':checked')) {
                  // if so, remove the element from the "Draggable Events" list
                  $(this).remove();
              }

          },

          select: function (start, end, allDay) {
              var title = prompt('Event Title:');
              if (title) {
                  calendar.fullCalendar('renderEvent', {
                          title: title,
                          start: start,
                          end: end,
                          allDay: allDay
                      }, true // make the event "stick"
                  );
              }
              calendar.fullCalendar('unselect');
          },

          events: [{
              title: 'All Day Event',
              start: new Date(y, m, 1),
              description: 'long description',
              className: ["event", "bg-color-greenLight"],
              icon: 'fa-check'
          }, {
              title: 'Long Event',
              start: new Date(y, m, d - 5),
              end: new Date(y, m, d - 2),
              className: ["event", "bg-color-red"],
              icon: 'fa-lock'
          }, {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d - 3, 16, 0),
              allDay: false,
              className: ["event", "bg-color-blue"],
              icon: 'fa-clock-o'
          }, {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d + 4, 16, 0),
              allDay: false,
              className: ["event", "bg-color-blue"],
              icon: 'fa-clock-o'
          }, {
              title: 'Meeting',
              start: new Date(y, m, d, 10, 30),
              allDay: false,
              className: ["event", "bg-color-darken"]
          }, {
              title: 'Lunch',
              start: new Date(y, m, d, 12, 0),
              end: new Date(y, m, d, 14, 0),
              allDay: false,
              className: ["event", "bg-color-darken"]
          }, {
              title: 'Birthday Party',
              start: new Date(y, m, d + 1, 19, 0),
              end: new Date(y, m, d + 1, 22, 30),
              allDay: false,
              className: ["event", "bg-color-darken"]
          }, {
              title: 'Smartadmin Open Day',
              start: new Date(y, m, 28),
              end: new Date(y, m, 29),
              className: ["event", "bg-color-darken"]
          }],

          eventRender: function (event, element, icon) {
              if (!event.description == "") {
                  element.find('.fc-event-title').append("<br/><span class='ultra-light'>" + event.description +
                      "</span>");
              }
              if (!event.icon == "") {
                  element.find('.fc-event-title').append("<i class='air air-top-right fa " + event.icon +
                      " '></i>");
              }
          },

          windowResize: function (event, ui) {
              $('#calendar').fullCalendar('render');
          }
      });

      /* hide default buttons */
      $('.fc-header-right, .fc-header-center').hide();

  };

</script>


<%
   Conn.Close
   Set Conn = nothing
%>
