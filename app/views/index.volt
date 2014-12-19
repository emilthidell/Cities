<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Cities</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/bootswatch/2.3.1/united/bootstrap.min.css"   rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
        {{ stylesheet_link('css/style.css') }}
        {{ stylesheet_link('css/stoneage.css') }}
    </head>
    <body>
        <div class="navbar-spacer"></div>

        {% if guide.mode %}
        <div id="your-guide" data="{{ guide.jsonMessages }}"><div class="tile-moon"><div class="actor"></div></div></div>
        {% endif %}

        {{ content() }}
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"         ></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/2.3.1/js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"   ></script>
        <script src="/js/app.js"    ></script>
        <script src="/js/globals.js"></script>
        <script src="/js/footer.js" ></script>
        <script src="/js/guide.js"  ></script>
    </body>
</html>
