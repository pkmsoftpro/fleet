$(function() {
	
	  getDealerDashboardInfo(false);
      $('#hasAllBranchesChecked').click(function() {
    	  getDealerDashboardInfo();
    });
      $("input[name='theme']").on("change", function () {
            $.getScript(this.value);
            getDealerDashboardInfo(false);
      });
                  
});

function getDealerDashboardInfo(value) {
	var speedoMeterChart;
	var barChart;
	var pieChart;
	var hasAllChecked = $('#hasAllBranchesChecked').is(':checked');
	var refresh = false;
	if(value){
		refresh=value;
		$('#refreshButton').prop('disabled', true);
	}
    var url = "dealerDashboard?hasAllChecked="+hasAllChecked+"&refresh="+refresh;
    $("#loading").show();
	$('#showDashboard').hide();
    $.getJSON( "dealerDashboard", { hasAllChecked: hasAllChecked, refresh: refresh } )
       .done(function( json ) {
    	   $("#loading").hide();
    	   $("#showDashboard").show();
    	   $('#refreshButton').prop('disabled', false);
    	   if(hasAllChecked){
    			 json.dealerDashboard.id=-1;
    	   } 
    	  var speedoMeterOptions={
         	chart: {
      		      renderTo: 'containerDealerSpeedoMeter',
                  type: 'gauge',
                  spacingTop: 25,
                  borderWidth: 1,
                  borderColor: '#d4d4d4',
                  plotBackgroundColor: null,
      	          plotBackgroundImage: null,
      	          plotBorderWidth: 0,
      	          plotShadow: false,
                  events:{
                      click:function(){
                     	 openChartDrilDown(this.options.title.text,'getDashboardFleetClaims?folderName=Average Claims Age'+'&type=CLAIM_AGE&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked);
                      }
                  }
              },
              credits: {
                  enabled: false
              },
              title: {
                  text: dashboard_i18N.claimsAvgAge
              },
              subtitle:{
             	    text:'<span style="background-size:10px 2px;border-style:solid;border-color:#DF5353;"></span>BAD<span style="background-size:10px 10px;border-style:solid;border-color:#DDDF0D;"></span>OK<span style="background-size:10px 10px;border-style:solid;border-color:#55BF3B;"></span>GOOD',
             	    floating: true,
             	    x: 0,
             	    useHTML:true,
             	    y:290
              },
              pane: {
      	        startAngle: -140,
      	        endAngle: 140,
      	        background: [{
      	            backgroundColor: {
      	                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
      	                stops: [
      	                    [0, '#FFF'],
      	                    [1, '#333']
      	                ]
      	            },
      	            borderWidth: 0,
      	            outerRadius: '109%'
      	        }, {
      	            backgroundColor: {
      	                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
      	                stops: [
      	                    [0, '#333'],
      	                    [1, '#FFF']
      	                ]
      	            },
      	            borderWidth: 1,
      	            outerRadius: '107%'
      	        }, {
      	            // default background
      	        }, {
      	            backgroundColor: '#DDD',
      	            borderWidth: 0,
      	            outerRadius: '105%',
      	            innerRadius: '103%'
      	        }]
      	    },                    

      	  yAxis: {
  	        min: 0,
  	        max: 100,
  	        minorTickInterval: 'auto',
  	        minorTickWidth: 1,
  	        minorTickLength: 10,
  	        minorTickPosition: 'inside',
  	        minorTickColor: '#666',
  	        tickPixelInterval: 30,
  	        tickWidth: 2,
  	        tickPosition: 'inside',
  	        tickLength: 10,
  	        tickColor: '#666',
  	        labels: {
  	            step: 2,
  	            rotation: 'auto'
  	        },
  	        title: {
  	            text: json.dealerDashboard.totalAgeOfClaims,
  	            y:120
  	        },
  	        plotBands: [{
  	            from: 0,
  	            to: json.claimAgeYellowBandFrom,
  	            color: '#55BF3B' // green
  	        }, {
  	            from:json.claimAgeYellowBandFrom,
  	            to: json.claimAgeOrangeBandFrom,
  	            color: '#DDDF0D' // yellow
  	        }, {
  	            from:json.claimAgeOrangeBandFrom,
  	            to: json.claimAgeRedBandFrom,
  	            color: '#FFA500' // orange
  	        }, {
  	            from: json.claimAgeRedBandFrom,
  	            to: json.claimAgeMax,
  	            color: '#DF5353' // red
  	        }]        
  	       },
           plotOptions: {
                  gauge: {
                      dataLabels: {
                          enabled: true
                      },
                      dial: {
                          radius: '100%'
                      }
                   }
              },

              series: [{
            	  name: dashboard_i18N.claimsAvgAge,
                  data:[json.dealerDashboard.totalAgeOfClaims>100?100:json.dealerDashboard.totalAgeOfClaims],
                  yAxis: 0,
                  url:'getDashboardFleetClaims?type=claimAge'
              }]
     };
     	  
    //Bar Chart 	  
    var barChartoptions={
		chart: {
		 renderTo: 'dealerBarChart',
         type: 'bar',
         borderWidth: 1,
         spacingTop: 25,
         spacingBottom: 100,
         spacingLeft: 5,
         borderColor: '#d4d4d4'
     },
     credits: {
         enabled: false
     },
     tooltip: {
    	    formatter: function() {
    	        return  this.series.name +'</b>'+ Highcharts.numberFormat(this.y, 2) ;
    	    }
     },
     title: {
         text: dashboard_i18N.barChart,
         margin: 80
     },
     xAxis: {
         categories: [dashboard_i18N.claims]
     },
     yAxis: {
         min: 0,
         tickInterval: 10,
         max:100,
         title: {text: dashboard_i18N.claimSubmitted}
     },
     colors: ['red','green'],
     legend: {
         backgroundColor: '#FFFFFF',
         reversed: true
     },
     plotOptions: {
         series: {
         	cursor: 'pointer',
             stacking: 'normal',
             point: {
                 events: {
                 	 click: function() {
                     	openChartDrilDown(this.options.name,this.options.url);
                     }
                 }
             }
         }
     },
     series: [{
         name: dashboard_i18N.adjusted,
         data: [
                {
         	   name :dashboard_i18N.adjusted,
         	   y:parseFloat(json.dealerDashboard.totalClaimsAdjusted/(json.dealerDashboard.totalClaimsAdjusted+json.dealerDashboard.totalClaimsNotadjusted)*100),
         	   url:'getDashboardFleetClaims?folderName=Adjusted'+'&type=ADJUSTED_CLAIMS&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked
         	   }
            ]
         
         },
         {
         name:dashboard_i18N.notAdjusted,
         data: [
                { 
             	   name: dashboard_i18N.notAdjusted,
             	   y:parseFloat(json.dealerDashboard.totalClaimsNotadjusted/(json.dealerDashboard.totalClaimsAdjusted+json.dealerDashboard.totalClaimsNotadjusted)*100),
             	   url: 'getDashboardFleetClaims?folderName=Not Adjusted'+'&type=ADJUSTED_CLAIMS&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked
             	}
               ]
         }]
     }; 
    
     //Pie Chart
		var pieChartoptions={
     		  chart: {
     			  renderTo:'dealerServiceResponseChart',
                   plotBackgroundColor: null,
                   plotBorderWidth: null,
                   borderWidth: 1,
                   borderColor: '#d4d4d4',
                   plotShadow: false
               },
               credits: {
                   enabled: false
               },
               title: {
                   text: dashboard_i18N.pieChart
               },
               tooltip: {
           	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
               },
               plotOptions: {
                   pie: {
                       allowPointSelect: true,
                       cursor: 'pointer',
                       dataLabels: {
                           enabled: true,
                           color: '#000000',
                           connectorColor: '#000000',
                           formatter: function() {
                               return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %';
                           }
                       },
                       point: {
                     	  events:{
                     		  click: function() {
                     			  openChartDrilDown(this.options.name,this.options.url);
                               }
                     	  }
                       }
                   }
               },
               series: [{
                   type: 'pie',
                   name: dashboard_i18N.serviceResponse,
                   data: 
                       [{name :dashboard_i18N.sameday, y:json.dealerDashboard.noOfSrRepsonseDay0,sliced: true,selected: true,url:'dealerDashbardSR?folderName=Same Day'+'&missedPM=false&days=0&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked},
                       {name :dashboard_i18N.nextday, y:json.dealerDashboard.noOfSrRepsonseDay1,url:'dealerDashbardSR?folderName=Next Day'+'&missedPM=false&days=1&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked},
                       {name: dashboard_i18N.secondday,y: json.dealerDashboard.noOfSrRepsonseDay2,url:'dealerDashbardSR?folderName=2nd Day'+'&missedPM=false&days=2&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked},
                       {name :dashboard_i18N.thirddday,y:json.dealerDashboard.noOfSrRepsonseDay3,url:'dealerDashbardSR?folderName=3rd Day'+'&missedPM=false&days=3&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked},
                       {name :dashboard_i18N.fourthday,y:json.dealerDashboard.noOfSrRepsonseDay4,url:'dealerDashbardSR?folderName=4th Day'+'&missedPM=false&days=4&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked},
                       {name :dashboard_i18N.morethanfourdays,y:json.dealerDashboard.noOfSrRepsonseDaysgrtthan4,url:'dealerDashbardSR?folderName=>4 Days'+'&missedPM=false&days=5&dealerDashboardId='+json.dealerDashboard.id+'&hasAllChecked='+hasAllChecked}]
                   
               }]
         }; 		
				
			//details for dealer summary
		    if(json.numberOfBranches ==1){
		    	 $("#checkboxForAll").hide();
		    }
		    dealerDashboardId = json.dealerDashboard.id;
			$('#dealerName').html(json.dealerDashboard.dealerName);
			$('#totalBranches').html(json.numberOfBranches);
			$('#totalFleetLocations').html(json.dealerDashboard.noOfFleetLocations);
			$('#totalFleetAssets').html(json.dealerDashboard.noOfEquipments);
			$('#totalFleetDollars').html(json.dealerDashboard.totalClaimAmountFormatted);
			$('#claimProcessed').html(json.dealerDashboard.totalClaimProcessed);
			$('#avgclaim').html(json.dealerDashboard.averageClaimFormatted);
			$('#outstandingClaims').html(json.dealerDashboard.totalOutstandingClaims);
			$('#requiringInfo').html(json.dealerDashboard.totalClaimsRequiringInfo);
			$('#pmassigned').html(json.dealerDashboard.totalPmAssigned);
			$('#pmcompleted').html(json.dealerDashboard.totalPmCompleted);
			$('#missedpms').html(json.dealerDashboard.totalPmIncomplete);
			$('#estimatedRevenue').html(json.dealerDashboard.additionalRevenueFormatted);
			
			var pieChart = new Highcharts.Chart(pieChartoptions);
			var barChart = new Highcharts.Chart(barChartoptions);
			var speedoMeterChart = new Highcharts.Chart(speedoMeterOptions); 
       })
       .fail(function( jqxhr, textStatus, error ) {
    	   console.log('dealer dashboard request failed! ' + textStatus); 
       });
        
}
