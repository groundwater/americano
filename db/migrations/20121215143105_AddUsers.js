var AddUsers = new Migration({
	up: function() {
    this.create_table('user', function(t) {
      t.integer('id');
      t.string('email');
      t.string('password');
      t.primary_key('id');
    });
	},
	down: function() {
		this.drop_table('user');
	}
});