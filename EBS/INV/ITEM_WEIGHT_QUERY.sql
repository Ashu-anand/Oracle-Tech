SELECT msit.segment1 item_number,
       primary_uom_code,
       msit.unit_weight,
       weight_uom_code,
       unit_volume,
       volume_uom_code
  FROM apps.mtl_system_items_b msit, apps.org_organization_definitions oodt
 WHERE     1 = 1
       AND oodt.organization_code = NVL ( :org_code, oodt.organization_code)
       AND msit.organization_id = oodt.organization_id
       AND inventory_item_status_code NOT IN ('Inactive');