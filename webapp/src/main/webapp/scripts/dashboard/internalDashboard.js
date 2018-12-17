$(function() {
	  getInternalDashboardInfo(false);
      $("input[name='theme']").on("change", function () {
            $.getScript(this.value);
            getInternalDashboardInfo(false);
      });
});

function openChartDrilDown(tabName,url) {
    parent.publishEvent("/tab/open", {
       label : tabName,
       url : url,
       decendentOf : '',
       forceNewTab : true
    }); 
}   

function getInternalDashboardInfo(value) {
	var lineChart;
	var quoteAgeChart;
	$("#loadingInternalDashboard").show();
	$('#internaldbcontainer').hide();
    $.getJSON( "internalDashboard", {} )
       .done(function( json ) {
    	   $("#loadingInternalDashboard").hide();
    	   
    	   if(json.internalDashboard){
    		   
    	   $("#internaldbcontainer").show();
    		   
     	   var invoiceChartOptions={
     			 chart: {
           		     renderTo: 'invoiceChart',
                     type: 'line',
                     zoomType : 'xy',
 					 marginRight : 50,
 					 marginLeft : 80,
 					 marginTop : 50,
 					 marginBottom : 100,
 					 borderWidth: 1,
 	                 borderColor: '#d4d4d4'
                 },
                 credits: {
                       enabled: false
                 },
     			 title: {
                     text: dashboard_i18N.invoiceDollars,
                     x: -20 
                 },
                 xAxis: {
                     categories: json.last30Days,
                     labels: {
                         rotation: -45,
                         style: {
                             fontSize: '9px',
                             fontFamily: 'Verdana, sans-serif',
                             fontWeight: 'bold',
                             color : '#4572A7'
                         }
                     }
                 },
                 yAxis: {
                		min : json.minAmount,
     					max : json.maxAmount,
     					tickInterval : json.invoiceChartIntervals,
     					labels : {
     						format : json.currency + '{value}',
     						style : {
     							color : '#4572A7'
     						}
     					},
     					title : {
     						text : 'Amount',
     						style : {
     							color : '#4572A7'
     						}
     					}
                 },
                 tooltip: {
                     valueSuffix: json.currency
                 },
                 legend: {
                     layout: 'horizontal',
                     align: 'center',
                     verticalAlign: 'bottom',
                     borderWidth: 0
                 },
                 series: [{
                     name: dashboard_i18N.invoiceDollars,
                     data: json.customerInvoice
                 }, {
                     name: dashboard_i18N.dealerPayment,
                     data: json.dealerPayment
                 }]
            };
     	   
			quoteAgeChartOptions = {
				chart : {
					renderTo : 'outstandingQuoteAgeContainer',
					type : 'gauge',
					plotBackgroundColor : null,
					plotBackgroundImage : null,
					borderWidth: 1,
	                borderColor: '#d4d4d4',
					plotShadow : false,
					events: {
	                    click: function() {
	                    	openChartDrilDown(dashboard_i18N.quotes, 
	                    			"listInternalQuoteDashboards?folderName=InternalQuoteDashboard&internalDashboardId="+json.quoteAgeDashboardId);
	                    	}
					}
				},
				credits : {
					enabled : false
				},
				title : {
					text : dashboard_i18N.averageOutstandingQuoteAge
				},
	
				pane : {
					startAngle : -135,
					endAngle : 135,
					background : [ {
						backgroundColor : {
							linearGradient : {
								x1 : 0,
								y1 : 0,
								x2 : 0,
								y2 : 3
							},
							stops : [ [ 0, '#FFF' ], [ 1, '#333' ] ]
						},
						borderWidth : 0,
						outerRadius : '109%'
					}, {
						backgroundColor : {
							linearGradient : {
								x1 : 0,
								y1 : 0,
								x2 : 0,
								y2 : 3
							},
							stops : [ [ 0, '#333' ], [ 1, '#FFF' ] ]
						},
						borderWidth : 1,
						outerRadius : '107%'
					}, {
					// default background
					}, {
						backgroundColor : '#DDD',
						borderWidth : 0,
						outerRadius : '105%',
						innerRadius : '103%'
					} ]
				},
	
				// the value axis
				yAxis : {
					min : 1,
					max : json.quoteAgeMax,
					tickInterval : json.quoteAgeIntervals,
					tickWidth : 2,
					tickPosition : 'inside',
					tickLength : 10,
					tickColor : '#666',
					labels : {
						step : 1,
						rotation : 'auto'
					},
					title : {
						text : dashboard_i18N.days
					},
					plotBands : [ {
						from : 0,
						to : json.quoteAgeRedBandFrom,
						color : '#55BF3B' // green
					}, {
						from : json.quoteAgeRedBandFrom,
						to : json.quoteAgeMax,
						color : '#DF5353' // red
					} ]
				},
				tooltip : {
		            formatter: function(){
		            return dashboard_i18N.averageOutstandingQuoteAge+': '+json.outstandingQuoteAge+' '+dashboard_i18N.days;
		            }
				},
				series : [ {
					name : dashboard_i18N.averageOutstandingQuoteAge,
					data : [ json.quoteAgeForBand ]
				} ]
			};
     	  
     	   
		    $('#mtdClaimsReceived').html(json.internalDashboard.mtdClaimsReceived);
			$('#mtdClaimsPaid').html(json.internalDashboard.mtdClaimsPaid);
			$('#mtdBacklogAvg').html(json.internalDashboard.mtdBacklogAvg);
			$('#mtdClaimsAged').html(json.internalDashboard.mtdClaimsAged+' '+ 'Days');
			$('#mtdClaimsProcessed').html(json.internalDashboard.mtdClaimsProcessed);
			$('#mtdAvgClaimsAge').html(json.internalDashboard.avgAgeOfClaims+' '+ 'Days');
			
			var lineChart = new Highcharts.Chart(invoiceChartOptions);
			quoteAgeChart = new Highcharts.Chart(quoteAgeChartOptions);
			
    	   }	
       })
       .fail(function( jqxhr, textStatus, error ) {
    	   console.log('internal dashboard request failed! ' + textStatus); 
       });
    
}
