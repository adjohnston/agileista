//  ------
//  sticky
//  ------
  
    'use strict';

    function Sticky (el, options) {
      this.defaults = $.extend({
        offsetTop: 0
      }, options);

      window.addEventListener('scroll', (function () {
        this.checkOffset.call(this, el)
      }).bind(this));
    }

    Sticky.prototype = {
      checkOffset: function (el) {
        if (window.pageYOffset > el.offset().top)
          el.css('top', this.defaults.offsetTop).addClass('sticky');
        
        else if (window.pageYOffset === 0 || window.pageYOffset < el.offset().top)
          el.removeClass('sticky');
      }
    };

    $.fn.sticky = function (options) {
      return this.each(function () {
        if(!$.data(this, 'sticky'))
          $.data(this, 'sticky', new Sticky($(this), options));
      });
    };