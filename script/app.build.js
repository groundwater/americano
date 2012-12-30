({
  paths:{
    'jquery'    : 'jquery',
    'bootstrap' : 'bootstrap/js/bootstrap',
    'pjax'      : 'pjax',
    'spin'      : 'spin'
	},
  shim:{
    'bootstrap' : ['jquery'],
    'pjax'      : ['jquery'],
    'spin'      : ['jquery']
	},
	baseUrl: "../tmp/public",
  out: "../build/public/scripts/init.js",
  name: "scripts/init"
})
