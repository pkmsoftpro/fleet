$(function() {
	getCreditRescindPerformanceInfo();
});

function getCreditRescindPerformanceInfo() {
	var creditRescindChart;
	
	$.getJSON("creditRescindPerformanceInfo", function(result) {
		if(result.hasCreditRescinds)
		{
			creditRescindChart = new Highcharts.Chart({
				chart : {
					renderTo : 'creditRescindContainer',
					zoomType : 'xy',
					marginRight : 65,
					marginLeft : 80,
					marginTop : 50,
					marginBottom : 100,
					borderWidth: 1,
	                borderColor: '#d4d4d4'
				},
				credits : {
					enabled : false
				},
				title : {
					text : "Credit Rescind Performance"
				},
				xAxis : [ {
					categories : result.last30Days,
					labels: {
                        rotation: -45,
                        style: {
                            fontSize: '9px',
                            fontFamily: 'Verdana, sans-serif',
                            fontWeight: 'bold',
                            color : '#4572A7'
                        }
                    },
					tickLength : 15
				} ],
				yAxis : [ { // Net Amount yAxis
					min : 0,
					max : result.netAmountMax,
					tickInterval : result.netAmountIntervals,
					labels : {
						format : result.currency + '{value}',
						style : {
							color : '#4572A7'
						}
					},
					title : {
						text : "Net Amount",
						style : {
							color : '#4572A7'
						}
					}
				}, { // No of Transactions yAxis
					min : 0,
					max : result.noOfTransactionsMax,
					tickInterval : result.noOfTransactionsIntervals,
					title : {
						text : "No of Transactions",
						style : {
							color : '#DF5353'
						}
					},
					labels : {
						format : '{value}',
						style : {
							color : '#DF5353'
						}
					},
					opposite : true
				} ],
				tooltip : {
					shared : true
				},
				legend : {
					layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom',
                    borderWidth: 0
				},
				series : [{
					name : "No of Transactions",
					color : '#DF5353',
					type : 'column',
					yAxis : 1,
					data : result.noOfTransactions
				},{
					name : "Net Amount",
					color : '#4572A7',
					type : 'line',
					data : result.netAmount,
					tooltip : {	valuePrefix : result.currency }
				}]
			});
		}
	});
}