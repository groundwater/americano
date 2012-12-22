var db   = require('db-migrate');
var type = db.dataType;

exports.up = function (db, callback) {
  db.createTable('{{model}}', {
    id: { type: 'int', primaryKey: true, autoIncrement:true },{{rows}}
  }, callback);
};

exports.down = function (db, callback) {
  db.dropTable('{{model}}', callback);
};
