  $(function () {
    var oSize = jQuery.fn.size;
    jQuery.fn.tooltip = function() {
        console.log('jQuery Tooltips are disisabled in this application');
    };
    $('[data-toggle="tooltip"]').tooltip();

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
             app.globals.appfreeSpaceHeight = (freeSpace/2);
         }else{
             app.globals.appfreeSpaceHeight = 0;
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

})
