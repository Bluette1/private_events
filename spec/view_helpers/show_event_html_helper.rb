def event_html
  %(<div>
  <p>
    <strong>Description:</strong>
    description_one
  </p>
  <p>
    <strong>Date:</strong>
    #{Date.today}
  </p>
  <p>
    <strong>Creator:</strong>
    creator
  </p>
  <p>
    <strong>Attendees:</strong><br/>
      <li>
        creator
      </li>
      <li>
        user
      </li>
  </p>
  <a href="/events">Back</a>
</div>)
end
