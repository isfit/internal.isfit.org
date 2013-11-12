    $(function(){
      $('#years').bind('change', function () {
         var url = "/indaba_speakers?year=" + $(this).val()
          if (url) {
              window.location.replace(url);
          }
          return false;
      });
    });