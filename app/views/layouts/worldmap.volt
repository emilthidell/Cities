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

<div class="container" style="width: 100%;">
    <div align="center">
        <div class="worldmap">
            {% for city in cities %}
              {% if city.extra != "" %}
                <span class="extra-{{ city.extra }}" data-toggle="tooltip" data-placement="top" title="{{ city.title }}"  style="left:{{ city.x }}px; top:{{ city.y }}px; z-index:10;" data-id="{{ city.id }}"><i class="fa fa-home" style="position:relative;"></i></span>
              {% endif %}
              <a href="/cities/{{ city.id }}" class="minimap" data-toggle="tooltip" data-placement="top" title="{{ city.title }}" style="left:{{ city.x }}px; top:{{ city.y }}px;background-image:url(/img/previews/{{ city.preview }}.png)"></a>
            {% endfor %}
        </div>
    </div>
    {{ content() }}
</div>
