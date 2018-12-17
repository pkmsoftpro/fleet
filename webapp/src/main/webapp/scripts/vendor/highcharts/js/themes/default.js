/**
 * default theme for Highcharts JS
 * 
 */

Highcharts.theme = {
    chart: {
    	 backgroundColor: null,
    	 borderWidth: 1,
    	 className: 'highcharts-background',
    	 borderColor: '#d4d4d4'
    		 
    },
    title: {
		style: {
			color: '#333333',
			font: '"Lucida Grande", "Lucida Sans Unicode", Arial, Helvetica, sans-serif'
		}
	},
	subtitle: {
		style: {
			color: '#333333',
			font: '"Lucida Grande", "Lucida Sans Unicode", Arial, Helvetica, sans-serif'
		}
	},
   
};

// Apply the theme
var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
