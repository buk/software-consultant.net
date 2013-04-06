//= require foundation/foundation
//= require foundation/foundation.section
//= require foundation/foundation.tooltips
//= require foundation/foundation.topbar
//= require foundation/foundation.reveal
//= require jquery.lifestream.js
//= require lifestream.js

//= require raphael-min
//= require morris
//= require chart

$(document).ready(function(){
  $(document).foundation();
  $('.chart').chart();
});

