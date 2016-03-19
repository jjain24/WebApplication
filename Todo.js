
var mongoose = require('mongoose');

var TodoSchema = new mongoose.Schema({
  name: {type :String, default: 'Jina'},
  completed: {type: Boolean, default:false},
  note: {type: String, default: ''},
  createdby: {type:String, default:'admin'},
  owner: {type: String, default: 'Jina'},
  estimate: {type: Number, default: 1},
  Time: {type: Date, default: Date.now}
  });

module.exports = mongoose.model('Todo', TodoSchema);