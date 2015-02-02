<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Cities</title>
        <link href="/css/bootstrap.min.css" rel="stylesheet">
        <link href="/css/bootstrap-united.min.css"   rel="stylesheet">
        <link href="/css/font-awesome.min.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="/img/favicon.png">
        {{ stylesheet_link('css/style.css') }}
        {{ stylesheet_link('css/stoneage.css') }}
    </head>
    <body>
        <div class="navbar-spacer"></div>

        {% if guide.mode %}
        <div id="your-guide" data="{{ guide.jsonMessages }}"><div class="tile-moon"><div class="actor"></div></div></div>
        {% endif %}

        {{ content() }}

        <script src="/js/jquery-1.11.2.min.js"></script>
        <script src="/js/jquery.rainsnow.js"  ></script>
        <script src="/js/bootstrap.min.js"    ></script>
        <script src="/js/jquery-ui.min.js"    ></script>
        <script src="/js/app.js"              ></script>
        <script src="/js/globals.js"          ></script>
        <script src="/js/footer.js"           ></script>
        <script src="/js/character.js"        ></script>
        <script src="/js/guide.js"            ></script>
        <script src="/js/positions.js"        ></script>
        <script src="/js/debugtools.js"      ></script>
    </body>
</html>
