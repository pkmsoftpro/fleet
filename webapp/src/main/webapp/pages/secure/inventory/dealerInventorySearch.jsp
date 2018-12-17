
<tr>
    <td width="150px" class="searchLabel labelStyle"><s:text name="search.inventory.optionCode" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.optionCode" id="inventorySearchCriteria.optionCode" />
    </td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.customerName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.customerName" id="inventorySearchCriteria.customerName" /></td>
</tr>

<!-- location name -->
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.locationName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.locationName" id="inventorySearchCriteria.locationName" /></td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.serialNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.serialNumber" id="inventorySearchCriteria.serialNumber" />
    </td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="label.serviceRequest.maintenanceType" /></td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.maintenanceType" id="inventorySearchCriteria.maintenanceType" /></td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.assetNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.assetNumber" id="inventorySearchCriteria.assetNumber" /></td>
</tr>
<!-- plant Name -->
<!-- <tr>
    <td width="150px" class="searchLabel labelStyle"><s:text name="search.inventory.plantName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.plantDescription" id="inventorySearchCriteria.plantDescription" /></td>
</tr> -->

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.manufacturer" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.manufacturer" id="inventorySearchCriteria.manufacturer" />
    </td>
</tr>

<!-- product type -->

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.equipmentType" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.equipmentType" id="inventorySearchCriteria.equipmentType" /></td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.productName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.series" id="inventorySearchCriteria.series" /></td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.model" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.model" id="inventorySearchCriteria.model" /></td>
</tr>
<tr>
    <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text name="search.inventory.leaseStartDate" />:</span> <span
        style="float: right;"><s:text name="label.common.from" />: </span>
    </td>
    <td><sd:datetimepicker name='inventorySearchCriteria.leaseStartFrom' value='%{inventorySearchCriteria.leaseStartFrom}'
            id='inventorySearchCriteria.leaseStartFrom' />
    </td>

</tr>
<tr>
    <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
    <td><sd:datetimepicker name='inventorySearchCriteria.leaseStartTill' value='%{inventorySearchCriteria.leaseStartTill}'
            id='inventorySearchCriteria.leaseStartTill' />
    </td>

</tr>
<tr>
    <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text name="search.inventory.leaseEndDate" />:</span> <span
        style="float: right;"><s:text name="label.common.from" />: </span></td>
    <td><sd:datetimepicker name='inventorySearchCriteria.leaseEndFrom' value='%{inventorySearchCriteria.leaseEndFrom}'
            id='inventorySearchCriteria.leaseEndFrom' />
    </td>

</tr>
<tr>
    <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
    <td><sd:datetimepicker name='inventorySearchCriteria.leaseEndTill' value='%{inventorySearchCriteria.leaseEndTill}'
            id='inventorySearchCriteria.leaseEndTill' />
    </td>

</tr>

<!-- Equipment Number -->

<!-- claim number -->

<!-- build date -->
<!-- Delivery date -->
<tr>
    <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text name="search.inventory.deliveryDate" />:</span> <span
        style="float: right;"><s:text name="label.common.from" />: </span></td>
    <td><sd:datetimepicker name='inventorySearchCriteria.deliveryDateStratFrom' value='%{inventorySearchCriteria.deliveryDateStratFrom}'
            id='inventorySearchCriteria.deliveryDateStratFrom' /></td>

</tr>
<tr>
    <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
    <td><sd:datetimepicker name='inventorySearchCriteria.deliveryDateEndTill' value='%{inventorySearchCriteria.deliveryDateEndTill}'
            id='inventorySearchCriteria.deliveryDateEndTill' />
    </td>

</tr>

