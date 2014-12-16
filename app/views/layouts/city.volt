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

                <li><a href="/cities/{{ current_city }}">Your City</a></li>
                <li><a href="/users">Find Friends</a></li>
                <li><a href="/profiles">Profiles</a></li>
                <li><a href="/permissions">Permissions</a></li>

            {% else %}

                <li><a href="/cities">Your Cities</a></li>
                <li><a href="/users">Find Friends</a></li>
                <li><a href="/profiles">Profiles</a></li>
                <li><a href="/permissions">Permissions</a></li>

            {% endif %}

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
                <div class="character"></div>

                {% for building in buildings %}
                  <div class="building" data-toggle="tooltip" data-placement="top" title="Go to {{ building.title }}" id="{{ building.id }}" style="width: {{ building.width }}px;height: {{ building.length }}px;left: {{ building.left }}px;top: {{ building.top }}px;background-image: url(/img/{{ building.resource_folder }}/out-{{ building.upgrade }}.png);"></div>
                {% endfor %}

            </div>
        </div>


    </div>
    {{ content() }}
</div>
