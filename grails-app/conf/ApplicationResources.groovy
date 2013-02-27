modules = {
	
	'bootstrap-js' {
		defaultBundle 'bundle_bootstrap'
		dependsOn 'jquery'
		resource url:[dir: 'js', file:'bootstrap.min.js'], exclude: 'minify'
	}
	
	'bootstrap' {
		defaultBundle 'bundle_bootstrap'
		dependsOn 'bootstrap-js'
		resource url:[dir: 'css', file:'bootstrap-responsive.min.css'], disposition: 'head', exclude:'minify'
		resource url:[dir: 'css', file:'bootstrap.min.css'], disposition: 'head', exclude:'minify'
		resource url:[dir: 'css', file:'bootswatch.css'], disposition: 'head'
	}
	
	'highcharts' {
		dependsOn 'jquery'
		resource url:[dir: 'js/highcharts', file: 'highcharts.js']
		resource url:[dir: 'js/highcharts/modules', file: 'exporting.js']
	}
	
	'list-view' {
		dependsOn 'jquery'
		resource url:[dir: 'js', file:'list.js']
	}
	
	'show-view' {
		dependsOn 'jquery'
		resource url:[dir: 'js', file:'show.js']
	}
}