var refresh = false;
$(function() {
	$('#customerSummaryTableId').hide();
	$('#refreshId').hide();
	getCustomerDashboardInfo();
	$('#hasAllCheckedId').click(function() {
		getCustomerDashboardInfo();
    });
	$('#refreshId').click(function() {
		refresh = true;
		getCustomerDashboardInfo();
		refresh = false;
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

function getCustomerDashboardInfo() {
	$("#loadingCustomerDashboard").show();
	var adbChart;
	var totalClaimChart;
	var quoteAgeChart;
	var hasAllChecked = $('#hasAllCheckedId').is(':checked');
	if(islocationChanged){
		$('#hasAllCheckedId').prop('checked', false);
		hasAllChecked = $('#hasAllCheckedId').is(':checked');
		islocationChanged=false;
	}
	$.getJSON("customerDashboardInfo?hasAllChecked="+hasAllChecked+"&refresh="+refresh, function(result) {
		$("#loadingCustomerDashboard").hide();
		if(result.hasCustomerDashboard)
		{
			$('#customerSummaryTableId').show();
			$('#refreshId').show();
			
			$('#customerNameId').html(result.customerDashboard.customerName);
			$('#customerLocationId').html($("<a></a>").text(result.totalLocations).attr("href", "#")
			.click(function() {openChartDrilDown(customerClaimDashboardText, 'getFleetLocations?folderName=CustomerClaimDashboard&origin=customerDashboard');}));
			$('#totalAssetsId').html($("<a></a>").text(result.customerDashboard.noOfEquipments).attr("href", "#")
			.click(function() {openChartDrilDown(fleetInventoryText, 'fleetInventoryListing.action?folderName=RETAIL&origin=customerDashboard&hasAllChecked='+hasAllChecked);}));
			$('#averageUtilizationId').html(result.customerDashboard.averageUtilizationFormatted+'%');
			$('#averageCostperhourId').html(result.customerDashboard.averageCostPerhourFormatted);
			$('#totalLaborId').html(result.customerDashboard.totalLaborFormatted);
			$('#totalPartsId').html(result.customerDashboard.totalPartsFormatted);
			$('#totalTravelId').html(result.customerDashboard.totalTravelFormatted);
			$('#totalMiscellaneousId').html(result.customerDashboard.totalMiscellaneousFormatted);
			$('#totalDrayageId').html(result.customerDashboard.totalDrayageFormatted);
			$('#fixedBillingId').html(result.customerDashboard.fixedBillingFormatted);
			$('#hourlyBillingId').html(result.customerDashboard.hourlyBillingFormatted);
			$('#totalSpendDollarsId').html(result.customerDashboard.totalSpentFormatted);
			$('#totalWoProcessedId').html($("<a></a>").text(result.customerDashboard.totalClaimProcessed).attr("href", "#")
			.click(function() {openChartDrilDown(customerClaimDashboardText, 'listCustomerClaimDashboards?folderName=TOTAL_WORK_ORDER_PROCESSED&hasAllChecked='+hasAllChecked);}));
			$('#totalAverageClaimId').html(result.customerDashboard.averageClaimFormatted);
			
			adbChart = new Highcharts.Chart({
				chart : {
					renderTo : 'adbContainer',
					zoomType : 'xy',
					marginRight : 55,
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
					text : titleChart1
				},
				xAxis : [ {
					categories : result.last12Months,
					tickLength : 15
				} ],
				yAxis : [ { // Total Spend yAxis
					min : 0,
					max : result.adbClaimSpentMax,
					tickInterval : result.adbClaimSpentIntervals,
					labels : {
						format : result.currency + '{value}',
						style : {
							color : '#4572A7'
						}
					},
					title : {
						text : totalSpendText,
						style : {
							color : '#4572A7'
						}
					}
				}, { // Incidents yAxis
					min : 0,
					max : result.adbIncidentsMax,
					tickInterval : result.adbIncidentsIntervals,
					title : {
						text : incidentsText,
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
                     borderWidth: 0,
					 floating : true
					//backgroundColor : '#FFFFFF'
				},
				plotOptions: {
			           series: {
			               cursor: 'pointer',
			               point: {
			                   events: {
			                       click: function() {
			                          openChartDrilDown(customerClaimDashboardText, "listCustomerClaimDashboards?folderName=ADB_CLAIMS&hasAllChecked="
			                        		  +hasAllChecked+"&paidMonth="+this.category+"&callType=ADB,MAB");
			                       }
			                   }
			               }
			           }
			        },
				series : [ {
					name : spendText,
					color : '#4572A7',
					type : 'column',
					data : result.customerDashboard.adbClaimSpent,
					tooltip : {
						valuePrefix : result.currency
					}
	
				}, {
					name : incidentsText,
					color : '#DF5353',
					type : 'line',
					yAxis : 1,
					data : result.customerDashboard.adbIncidents,
					tooltip : {
						valueSuffix : ''
					}
				},
				{
	                type: 'line',
	                name: trendLineText,
	                color: '#FFFF00',
	                data: [[0, result.customerDashboard.trendlineStartAdb], [11, result.customerDashboard.trendlineEndAdb]],
	                marker: {
	                    enabled: false
	                },
	                states: {
	                    hover: {
	                        lineWidth: 0
	                    }
	                },
	                enableMouseTracking: true
	            }
				]
			});
	
			totalClaimChart = new Highcharts.Chart({
				chart : {
					renderTo : 'totalClaimSpentAndIncidentsContainer',
					zoomType : 'xy',
					marginRight : 60,
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
					text : titleChart2
				},
				xAxis : [ {
					categories : result.last12Months,
					tickLength : 15
				} ],
				yAxis : [ { // Total Spend yAxis
					min : 0,
					max : result.claimSpentMax,
					tickInterval : result.claimSpentIntervals,
					labels : {
						format : result.currency + '{value}',
						style : {
							color : '#4572A7'
						}
					},
					title : {
						text : totalSpendText,
						style : {
							color : '#4572A7'
						}
					}
				}, { // Incidents yAxis
					min : 0,
					max : result.totalIncidentsMax,
					tickInterval : result.totalIncidentsIntervals,
					title : {
						text : incidentsText,
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
                     borderWidth: 0,
					 floating : true
					//backgroundColor : '#FFFFFF'
				},
				plotOptions: {
			           series: {
			               cursor: 'pointer',
			               point: {
			                   events: {
			                       click: function() {
			                          openChartDrilDown(customerClaimDashboardText, 
			                        		  "listCustomerClaimDashboards?folderName=LAST_12_MONTHS_CLAIMS&hasAllChecked="
			                        		  +hasAllChecked+"&paidMonth="+this.category);
			                       }
			                   }
			               }
			           }
			        },
				series : [ {
					name : spendText,
					color : '#4572A7',
					type : 'column',
					data : result.customerDashboard.claimSpent,
					tooltip : {
						valuePrefix : result.currency
					}
	
				}, {
					name : incidentsText,
					color : '#DF5353',
					type : 'line',
					yAxis : 1,
					data : result.customerDashboard.totalIncidents,
					tooltip : {
						valueSuffix : ''
					}
				},
				{
	                type: 'line',
	                name: trendLineText,
	                color: '#FFFF00',
	                data: [[0, result.customerDashboard.trendlineStartTotal], [11, result.customerDashboard.trendlineEndTotal]],
	                marker: {
	                    enabled: false
	                },
	                states: {
	                    hover: {
	                        lineWidth: 0
	                    }
	                },
	                enableMouseTracking: true
	            }
				]
			});
	
			quoteAgeChart = new Highcharts.Chart({
				chart : {
					renderTo : 'outstandingQuoteAgeContainer',
					type : 'gauge',
					plotBackgroundColor : null,
					plotBackgroundImage : null,
					plotBorderWidth : 0,
					plotShadow : false,
					borderWidth: 1,
	                borderColor: '#d4d4d4',
					events: {
	                    click: function() {
	                    	openChartDrilDown(customerQuoteDashboardText, 
	                    			"listCustomerQuoteDashboards?folderName=AVERAGE_QUOTE_AGE&hasAllChecked="+hasAllChecked);
	                    	}
					}
				},
				credits : {
					enabled : false
				},
				title : {
					text : titleChart3
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
					max : result.quoteAgeMax,
					tickInterval : result.quoteAgeIntervals,
					tickWidth : 2,
					tickPosition : 'inside',
					tickLength : 10,
					tickColor : '#666',
					labels : {
						step : 1,
						rotation : 'auto'
					},
					title : {
						text : daysText
					},
					plotBands : [ {
						from : 0,
						to : result.quoteAgeRedBandFrom,
						color : '#55BF3B' // green
					}, {
						from : result.quoteAgeRedBandFrom,
						to : result.quoteAgeMax,
						color : '#DF5353' // red
					} ]
				},
				tooltip : {
		            formatter: function(){
		            return titleChart3+': '+result.customerDashboard.outstandingQuoteAge+' '+daysText;
		            }
				},
				series : [ {
					name : titleChart3,
					data : [ result.quoteAgeForBand ]
				} ]
			});
		}
	});
}