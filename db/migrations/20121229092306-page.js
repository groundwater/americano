var db   = require('db-migrate');
var type = db.dataType;

exports.up = function (db, callback) {
  db.createTable('page', {
    id: { type: 'int', primaryKey: true, autoIncrement:true },
    content: { type: 'string' }, 
    url: { type: 'string' }, 
    hash: { type: 'string' }
  }, callback);
};

exports.down = function (db, callback) {
  db.dropTable('page', callback);
};
