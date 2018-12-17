
<s:if test="isLoggedInUserAnInternalUser()">
    <tr>
        <td width="150px" class="searchLabel labelStyle"><s:text name="search.inventory.optionCode" />:</td>
        <td class="searchLabel"><s:textfield name="inventorySearchCriteria.optionCode" id="inventorySearchCriteria.optionCode" />
        </td>
    </tr>
</s:if>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.serialNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.serialNumber" id="inventorySearchCriteria.serialNumber" />
    </td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.assetNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.assetNumber" id="inventorySearchCriteria.assetNumber" /></td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="label.serviceRequest.maintenanceType" /></td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.maintenanceType" id="inventorySearchCriteria.maintenanceType" /></td>
</tr>


<s:if test="!isLoggedInUserCustomer()">
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.customerName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.customerName" id="inventorySearchCriteria.customerName" /></td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.customerBillTo" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.customerBillTo" id="inventorySearchCriteria.customerBillTo" /></td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.shipTo" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.shipTo" id="inventorySearchCriteria.shipTo" /></td>
</tr>
</s:if>



<s:if test="isLoggedInUserAnInternalUser()">
    <tr>
        <td class="searchLabel labelStyle"><s:text name="search.inventory.contractCode" />:</td>
        <td class="searchLabel"><s:textfield name="inventorySearchCriteria.contractCode" id="inventorySearchCriteria.contractCode" /></td>
    </tr>
</s:if>


<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.manufacturer" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.manufacturer" id="inventorySearchCriteria.manufacturer" /></td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.model" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.model" id="inventorySearchCriteria.model" />
    </td>
</tr>
<s:if test="isLoggedInUserAnInternalUser()">
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.sapEquipmentNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.equipmentNumber" id="inventorySearchCriteria.equipmentNumber" /></td>
</tr>
</s:if>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.productName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.series" id="inventorySearchCriteria.series" />
    </td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.productClass" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.productClass" id="inventorySearchCriteria.productClass" />
    </td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.equipmentType" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.equipmentType" id="inventorySearchCriteria.equipmentType" /></td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.Sic" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.sicCode" id="inventorySearchCriteria.sicCode" /></td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.prefDealerNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.prefDealerNumber" id="inventorySearchCriteria.prefDealerNumber" />
    </td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.altdDealerNumber" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.altDealerNumber" id="inventorySearchCriteria.altDealerNumber" />
    </td>
</tr>

<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.prefDealerName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.prefDealerName" id="inventorySearchCriteria.prefDealerName" />
    </td>
</tr>
<tr>
    <td class="searchLabel labelStyle"><s:text name="search.inventory.altDealerName" />:</td>
    <td class="searchLabel"><s:textfield name="inventorySearchCriteria.altDealerName" id="inventorySearchCriteria.altDealerName" />
    </td>
</tr>

<!-- lease date -->

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

<!-- contract date -->
<s:if test="isLoggedInUserAnInternalUser()">
<tr>
    <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text name="search.inventory.contractStartDate" />:</span> <span
        style="float: right;"><s:text name="label.common.from" />: </span>
    </td>
    <td><sd:datetimepicker name='inventorySearchCriteria.contractDateStartFrom' value='%{inventorySearchCriteria.contractDateStartFrom}'
            id='inventorySearchCriteria.contractDateStartFrom' />
    </td>

</tr>
<tr>
    <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
    <td><sd:datetimepicker name='inventorySearchCriteria.contractDateStartTill' value='%{inventorySearchCriteria.contractDateStartTill}'
            id='inventorySearchCriteria.contractDateStartTill' />
    </td>

</tr>

<tr>
    <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text name="search.inventory.contractEndDate" />:</span> <span
        style="float: right;"><s:text name="label.common.from" />: </span></td>
    <td><sd:datetimepicker name='inventorySearchCriteria.contractDateEndFrom' value='%{inventorySearchCriteria.contractDateEndFrom}'
            id='inventorySearchCriteria.contractDateEndFrom' />
    </td>

</tr>
<tr>
    <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
    <td><sd:datetimepicker name='inventorySearchCriteria.contractDateEndTill' value='%{inventorySearchCriteria.contractDateEndTill}'
            id='inventorySearchCriteria.contractDateEndTill' />
    </td>

</tr>
</s:if>