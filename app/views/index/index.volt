{{ content() }}

<header class="jumbotron subhead" id="overview">
    <div class="hero-unit city-intro">
        <h1>Welcome to Cities!</h1>
        <p class="lead">This is a application built with Phalcon Framework</p>

        <div align="right" style="text-align: center;">
      {{ link_to('session/login', '<i class="icon-user icon-white"></i> Login', 'class': 'btn btn-success btn-large') }}
      {{ link_to('session/signup', '<i class="icon-ok icon-white"></i> Create an Account', 'class': 'btn btn-primary btn-large') }}
        </div>
    </div>
</header>

<div class="row">

    <div class="span4" style="width:23%;">
      <div class="well" style="height: 410px;">
        <div class="front-banner" style="background-image:url(/img/splash/ages.png);"></div>
        <h3>5 Different ages</h3>
        <p>Your city... or should I say village at this state, starts its journey early back in the stone age.</p>
        <p>You start with only a little guy and his home, help him reach the moon!</p>
      </div>
    </div>

    <div class="span3" style="width:23%;">
      <div class="well" style="height: 410px;">
        <div class="front-banner" style="background-image:url(/img/splash/team.png);"></div>
        <h3>Team up!</h3>
        <p>Gather your friends and play together in a team.</p>
        <p>A team need at least 2 players, send a request from the post office and wait for the letter to arrive at your friends home.</p>
      </div>
    </div>

    <div class="span3" style="width:23%;">
      <div class="well" style="height: 410px;">
        <div class="front-banner" style="background-image:url(/img/splash/invite.png);"></div>
        <h3>Invite friends</h3>
        <p>You will get experience points for every friends you invite.</p>
        <p>And don't forget, it's always funnier to play with your friends!</p>
      </div>
    </div>

    <div class="span4" style="width:23%;">
      <div class="well" style="height: 410px;">
        <div class="front-banner" style="background-image:url(/img/splash/emil.png);"></div>
        <h3>Emil Thidell</h3>
        <p>Cities is developed and designed by, <a href="http://emil.ninja" target="_blank">Emil Thidell</a>.</p>
        <p>I known PhalconPHP for a while and i've never got the time to test it out so i decided to give myself a small side project with PhalconPHP framework to test the limits and performance.</p>
      </div>
    </div>

  </div>
