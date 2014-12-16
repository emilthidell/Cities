<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Cities</title>
        <link href="//netdna.bootstrapcdn.com/bootswatch/2.3.1/united/bootstrap.min.css" rel="stylesheet">
        {{ stylesheet_link('css/style.css') }}
        {{ stylesheet_link('css/stoneage.css') }}
    </head>
    <body>
        <div class="navbar-spacer"></div>
        
        {{ content() }}

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
        <script>
            $(function () {
              $('[data-toggle="tooltip"]').tooltip()
            })
        </script>
    </body>
</html>
