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

            {%- set menus = [
              'Home': 'index',
              'About': 'about'
            ] -%}

            {%- for key, value in menus %}
              {% if value == dispatcher.getControllerName() %}
              <li class="active">{{ link_to(value, key) }}</li>
              {% else %}
              <li>{{ link_to(value, key) }}</li>
              {% endif %}
            {%- endfor -%}

          </ul>

          <ul class="nav pull-right">
            {%- if logged_in %}
            <li>{{ link_to('users', 'Users Panel') }}</li>
            <li>{{ link_to('session/logout', 'Logout') }}</li>
            {% else %}
            <li>{{ link_to('session/login', 'Login') }}</li>
            {% endif %}
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </div>

<div class="container main-container" style="width:1200px;">
  {{ content() }}
</div>

<footer>
Made with love by the ninja himself!

    {{ link_to("privacy", "Privacy Policy") }}
    {{ link_to("terms", "Terms") }}

© 2013 Emil Thidell
</footer>
