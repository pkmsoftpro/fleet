<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
   <style>
   .rowDivEven,.rowDivOdd,.rowDivHeader{border-right:0!important;border-left:0!important;border-top:0!important;width:400px!important;border-color:#837F94!important}
   .containerDiv { 
  width: 200px; 
 
}
   </style>
<div class="accordion-header contentPane">
   
   

    <!-- accordion header -->
    <spring:message code="title.messagesAndBulletin.createNewMessage" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.messagesAndBulletin.messagetitle" />
    </div>
    <div class="floatL">
        <input type="text" data-ng-model="messagesBulletin.subject" required />
    </div>
    <div class="clear"></div>
    <div class="labelStyle floatL">
        <spring:message code="label.messagesAndBulletin.messageDesc" />
    </div>

    <div class="textBoxAlignment">
        <div class="container">
            <div class="box">
                <div text-angular="text-angular" name="htmlcontent" ng-model="htmlcontent" ta-disabled='disabled'></div>
            </div>
        </div>
    </div>
    <div class="labelStyle floatL">
        <spring:message code="label.common.Attachment" />
    </div>
    <div class="floatL">
        <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
            <spring:message code="label.common.Attach" />
        </button>
    </div>
    <div class="clear"></div>
    <div class="radioClear"></div>
    <div class="attachmentAlignment">
        <%@include file="messagesAndBulletinsAttachedDocs.jsp"%>
    </div>
    <div class="clear"></div>

  <div class="labelStyle floatL">
        <spring:message code="label.messagesAndBulletin.customerNameGrp" />
     
    </div>
    <div class="floatL"></div>
  <!--   <div>
        <input type="text" url="listFleetCustomers" id="customerName" name="customerName" ng-model="customerName"  id="customerName" fbs-typeahead="typeaheadFn" data-ng-required="isRequired()"/>
    </div> -->
    
    <div class="containerDiv"
    ng-init="customerArray = customerArray == null ? [] : customerArray"
    ng-model="customerArray" repeater>
    <input type="hidden" name="customerArray"
       ng-model="customerArray" />
    <div class="rowDivHeader">
        <div class="cellDivHeader wid300">
        <spring:message code="label.messagesAndBulletin.customerNameGrp" />
        </div>       
        <div class="cellDivHeader wid96">
            <a class="add-row" 
                ng-click="addInputRow('customerArray','id')"></a>
        </div>
    </div>
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"  ng-repeat="name in customerArray">  
        <div class="cellDiv wid300" >
         
               <input type="text" url="listFleetCustomers" name="customerName" data-ng-model="name.customerName" ng-change="getCustomerId($index,name.customerName)" id="customerName" fbs-typeahead required/>
               
        </div>   
        <div class="cellDiv wid96">
            <a class="class"  ng-click="deleteThis($index,'customerArray')" ng-hide="isReadOnly()"><i class="icon-trash"></i>
            </a>
        </div>
    </div>
</div>


  <div class="labelStyle floatL">
        <spring:message code="label.messagesAndBulletin.dealerNameGrp" />      
    </div>
    <div class="floatL"></div>

  <div class="containerDiv"
    ng-init="dealerArray = dealerArray == null ? [] : dealerArray"
    ng-model="dealerArray" repeater>
    <input type="hidden" name="dealerArray"
       ng-model="dealerArray" />
    <div class="rowDivHeader">
        <div class="cellDivHeader wid300">
        <spring:message code="label.messagesAndBulletin.dealerNameGrp" />
        </div>       
        <div class="cellDivHeader wid96">
            <a class="add-row" 
                ng-click="addInputRow('dealerArray','id')"></a>
        </div>
    </div>
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"  ng-repeat="name in dealerArray">  
        <div class="cellDiv wid300" >
         
               <input type="text" url="listServiceProviders" name="dealerName" data-ng-model="name.dealerName" ng-change="getDealerId($index,name.dealerName)"  id="dealerName" fbs-typeahead required/>
        </div>   
        <div class="cellDiv wid96">
            <a class="class"  ng-click="deleteThis($index,'dealerArray')" ><i class="icon-trash"></i>
            </a>
        </div>
    </div>
</div>
   

    <div class="clear"></div>

    
    <div class="centered marB10">
        <button type="button" class="blue-btn" data-ng-click="save()" ng-disabled='form.$invalid ||!(customerArray.length>0|| dealerArray.length>0)'>
            <spring:message code="label.common.send" />
        </button>
        <button type="button" class="blue-btn" data-ng-click="cancel()">
            <spring:message code="label.Common.cancel" />
        </button>

    </div>
</div>
<div popup="openUploadDocWindow" close="close()">
    <div class="modal-header">
        <h6>
            <spring:message code="title.common.manageDocuments" />
        </h6>
    </div>
    <div class="modal-body">
        <jsp:include page="../fileUpload/fileUpload.jsp"></jsp:include>
        <div class="clear"></div>
    </div>

</div>
 <div popup="successMessage" close="closeMessagesAndBulletin()">
        <div class="modal-header">
            <center>
                <spring:message code="label.messagesAndBulletin.window" />
            </center>
        </div>
        <div class="modal-body">
            <center>
                    <spring:message code="label.messagesAndBulletin.succesMessage" />
            </center>
            <div class="clear"></div>
            <center>
                <button type="button" class="blue-btn" ng-click="closeMessagesAndBulletin()">
                    <spring:message code="label.serviceRequest.underWarranty.ok" />
                </button>
            </center>
        </div>
    </div>
</div>
