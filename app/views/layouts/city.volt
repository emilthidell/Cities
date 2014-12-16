<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container" style="width: auto;">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      {{ link_to(null, 'class': 'brand', 'Cities')}}
        <div class="nav-collapse">

         <ul class="nav">

              {% if num_cities <= 1 %}
                  <li><a href="/cities/map/{{ current_city }}">Your City</a></li>
              {% else %}
                  <li><a href="/cities">Your Cities</a></li>
              {% endif %}

              <li><a href="/users">Find Friends</a></li>
              <li><a href="/worldmap">Map</a></li>

            </ul>

          </ul>

        <ul class="nav pull-right">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">{{ auth.getName() }} <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li>{{ link_to('users/changePassword', 'Change Password') }}</li>
            </ul>
          </li>
          <li>{{ link_to('session/logout', 'Logout') }}</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<div class="container" style="width: 100%;">
    <div align="center">

        <div align="left" class="city-name">
            <h2>{{ city.title }}</h2>
        </div>
        <div class="{{ mapFolder }}">
            <div class="map">
                {% if city.layer != "" %}
                    <div class="layer" style="background-image:url(/img/{{ mapFolder }}/{{ city.layer }}.png)"></div>
                {% endif %}

                {% for character in characters %}
                  <div class="character" data-toggle="tooltip" data-placement="top" title="{{ character.title }}" id="character-{{ character.id }}" style="left: {{ character.left }}px;top: {{ character.top }}px;background-image: url(/img/{{ character.state }}/character.png);"></div>
                {% endfor %}

                {% for building in buildings %}
                  <div class="building" data-toggle="tooltip" data-placement="top" title="Go to {{ building.title }}" id="building-{{ building.id }}" style="width: {{ building.width }}px;height: {{ building.length }}px;left: {{ building.left }}px;top: {{ building.top }}px;background-image: url(/img/{{ building.resource_folder }}/out-{{ building.upgrade }}.png);"></div>
                {% endfor %}

            </div>
        </div>


    </div>
    {{ content() }}
</div>
