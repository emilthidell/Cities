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

<div class="container">
  {{ content() }}
</div>
