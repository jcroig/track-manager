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
	
	'list-view' {
		dependsOn 'jquery'
		resource url:[dir: 'js', file:'list.js']
	}
}