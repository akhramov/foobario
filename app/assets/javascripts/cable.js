
//= require action_cable
//= require_self
//= require_tree ./channels

var App = App || {};
App.cable = ActionCable.createConsumer();
