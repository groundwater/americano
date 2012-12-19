var AddCard = new Migration({
	up: function() {
    this.create_table('card', function(t) {
      t.integer('id');
      t.integer('user');
      t.string('name');
      t.primary_key('id');
    });
	},
	down: function() {
		this.drop_table('card');
	}
});
