if(typeof app.character == 'undefined'){
    app.character = {};
}

app.character.numCharacters = 0;

app.character.init = function(){
    $this = app.character;
    $this.numCharacters();
    if($this.numCharacters > 0){
        $('.character').click(function(){
            var clickedChar = this;
            console.log('char clicked');
            if($('.selectedChar').length > 0){
                $('.selectedChar').fadeOut(100,function(){
                    $(this).remove();
                });
            }
            if($('.selectedCharOptions').length > 0){
                $('.selectedCharOptions').fadeOut(100,function(){
                    $(this).remove();
                });
            }

            $(clickedChar).html('<div class="selectedChar fa-spin" style="display:none;"></div><div class="selectedCharOptions" style="display:none;"><div class="icon-land"></div><div class="icon-build"></div><div class="icon-decorations"></div><div class="icon-walk"></div><div class="icon-attack"></div><div class="icon-close close-character-controls"></div></div>');
            $('.selectedChar').fadeIn(100,function(){
                $('.selectedCharOptions').fadeIn(100,function(){
                    $('.close-character-controls').click(function(){
                        $('.selectedCharOptions').fadeOut(100,function(){
                            $(this).remove();
                        });
                        $('.selectedChar').fadeOut(100,function(){
                            $(this).remove();
                        });
                        return false;
                    });
                });
            });
        });
    }
};

app.character.numCharacters = function(){
    $this = app.character;
    var numCharacters = $('.character').length;
    $this.numCharacters = numCharacters;
};

app.character.init();
