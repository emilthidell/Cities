<div align="center" class="well">

    <div align="left">
        <h2>Cities</h2>
    </div>

    <div align="left">

    {% for city in cities %}
      <li><a href="/cities/map/{{ city.id }}">{{ city.title }}</a></li>
    {% endfor %}

    </div>

</div>
