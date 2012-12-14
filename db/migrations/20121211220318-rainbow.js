var dbm = require('db-migrate');
var type = dbm.dataType;

exports.up = function(db, callback) {
	db.createTable('rainbow', {
	  hash: { type: 'string', primaryKey: true },
	  pass: 'string'
	}, callback);
};

exports.down = function(db, callback) {
	db.dropTable('rainbow',callback)
};
