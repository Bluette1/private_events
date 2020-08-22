def index_html
  %(<div>
  <h5>Events</h5>
  <table>
    <thead>
      <tr>
        <th>Description</th>
        <th>Date</th>
        <th colspan="3"></th>
      </tr>
    </thead>
    <tbody>
        <tr>
          <td>description_one</td>
          <td>#{Date.today}</td>
          <td><a href="/events/1">Show</a></td>
        </tr>
        <tr>
          <td>description_two</td>
          <td>#{Date.today}</td>
          <td><a href="/events/2">Show</a></td>
        </tr>
    </tbody>
  </table>
  <br/>
  <h6>Upcoming Events</h6>
  <table>
    <thead>
      <tr>
        <th>Description</th>
        <th>Date</th>
        <th colspan="3"></th>
      </tr>
    </thead>
    <tbody>
        <tr>
          <td>description_one</td>
          <td>#{Date.today}</td>
          <td><a href="/events/1">Show</a></td>
        </tr>
        <tr>
          <td>description_two</td>
          <td>#{Date.today}</td>
          <td><a href="/events/2">Show</a></td>
        </tr>
    </tbody>
  </table>
  <br/>
  <h6>Past Events</h6>
  <table>
    <thead>
      <tr>
        <th>Description</th>
        <th>Date</th>
        <th colspan="3"></th>
      </tr>
    </thead>
    <tbody>
    </tbody>
  </table>
</div>
)
end
