def show_existing_events_html
  # rubocop:disable Layout/LineLength
  %(<div>
  <h5>Attend Event(s)</h5>
  <br/>
  <form action="/attend_events" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
      <input type="checkbox" name="event_ids[]" id="event_ids_" value="1" />
      description_one #{Date.today}<br/>
      <input type="checkbox" name="event_ids[]" id="event_ids_" value="2" />
      description_two #{Date.today}<br/>
    <br/>
    <div class="actions">
      <input type="submit" name="commit" value="Save " data-disable-with="Save " /> &nbsp;&nbsp;
      <a href="/events">Cancel</a>
    </div>
</form></div>)
  # rubocop:enable Layout/LineLength
end
