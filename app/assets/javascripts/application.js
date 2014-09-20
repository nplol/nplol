// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// vendor libs
//= require jquery-2.1.1
//= require jquery_ujs
//= require jquery.tipsy
//= require parallax
//= require_directory ./lib
//= require q
//= require event-emitter

// application-specific js
//= require post-manager
//= require post-form
//= require header
//= require auth
//= require app

// application entry point
$(document).ready(function() {
  $('.background').parallax();
})
