def user_html
  %(<div>
  <p>
    <strong>Name:</strong>
    creator
  </p>
  <p>
    <strong>Events Created:</strong>
      <li>
        <a href="/events/1">description_one</a>
      </li>
      <li>
        <a href="/events/2">description_two</a>
      </li>
  </p>
  <p>
    <strong>You have registered for the following events:</strong><br/>
      <li>
        <a href="/events/1">description_one</a>
      </li>
      <li>
        <a href="/events/2">description_two</a>
      </li>
  </p>
  <p>
    <strong>You have registered for the following <i>Upcoming</i> events:</strong><br/>
      <li>
        <a href="/events/2">description_two</a>
      </li>
  </p>
  <p>
    <strong>You have registered for the following <i>Previous</i> events:</strong><br/>
      <li>
        <a href="/events/1">description_one</a>
      </li>
  </p>
</div>
)
end
