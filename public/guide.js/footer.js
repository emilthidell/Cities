  $(function () {
    var oSize = jQuery.fn.size;
    jQuery.fn.tooltip = function() {
        console.log('jQuery Tooltips are disisabled in this application');
    };
    setTimeout(function(){
        console.log('asda');
            $('[data-toggle="tooltip"]').tooltip()
    },1000);
  if($('.map').length > 0){
     /*
     * Adjust the Map position depending on the screen resolutions
     */
     var mapHeight = $( '.map' ).height();
     var spacers   = parseInt($( '.navbar-spacer' ).height())+parseInt($( 'h2' ).height());

     $( window ).resize(function() {

         var winHeight = $( window ).height();

         if(winHeight > parseInt(mapHeight)+parseInt(spacers)){
             var availableHeight = parseInt(winHeight)-parseInt(spacers);
             var freeSpace       = parseInt(availableHeight)-parseInt(mapHeight);

             $('.map').css('top', (freeSpace/2)+'px');

         }
     });
  }

  var globals.appfreeSpaceHeight = 0;

  if($('.controlsHolder').length > 0){
     /*
     * Adjust the Map position depending on the screen resolutions
     */
     var mapHeight = $( '.controlsHolder' ).height();
     var spacers   = parseInt($( '.navbar-spacer' ).height())+parseInt($( 'h2' ).height());

     $( window ).resize(function() {

         var winHeight = $( window ).height();

         if(winHeight > parseInt(mapHeight)+parseInt(spacers)){
             var availableHeight = parseInt(winHeight)-parseInt(spacers);
             var freeSpace       = parseInt(availableHeight)-parseInt(mapHeight);

             $('.controlsHolder').css('top', (freeSpace/2)+'px');
             globals.appfreeSpaceHeight = (freeSpace/2);
         }else{
             globals.appfreeSpaceHeight = 0;
         }
     });
  }

  $( window ).resize();

  if($('.extra-home').length > 0){
      $('.extra-home').click(function(){
          var cityId = $(this).data('id');
          window.location.href = '/cities/'+cityId;
          return false;
      });
      var differ = 1;
      setInterval(function(){
          var homeBouncerTop = $('.extra-home').find('i').css('top').replace('px','');
          if(homeBouncerTop > -10){
              differ = -1;
          }else if(homeBouncerTop < -15){
              differ = 1;
          }
          $('.extra-home').find('i').css('top', (parseInt(differ)+parseInt(homeBouncerTop))+'px');
      },100);
  }

  $( ".building" ).on( "click", function(event) {
      var buildingBlock = event.target.id;
      buildingBlock = buildingBlock.split('-')
      window.location.href = '/cities/'+buildingBlock[0]+'/building/'+buildingBlock[1];
      return false;
  });

  if($('#your-guide').length > 0){
      $('#your-guide').fadeIn(400);
      $('#your-guide').animate({
                          'left': '200px',
                          'top' : (200+globals.appfreeSpaceHeight)+'px'
                      },
                      {
                          'easing':'easeInOutExpo',
                          'duration': 4000,
                          'complete': function(){
                              console.log('sadadad');
                              var guide = this;
                              var changer = 0;

                              function doBouncing(){
                                if(changer == 0){
                                    changerValue = "+=15px";
                                    changer = 1;
                                }else{
                                    changerValue = "-=15px";
                                    changer = 0;
                                }
                                console.log(changerValue);
                                $('#your-guide').animate({'top': changerValue, 'left': changerValue}, 2000);
                              }

                              doBouncing();
                              setInterval(doBouncing, 2300);
                            }
                        });
  }

})
