SELECT pht.segment1, pht.org_id, oodt.organization_code
  FROM apps.po_headers_all pht,
       apps.po_lines_all plt,
       apps.po_line_locations_all pllt,
       apps.mtl_system_items_b msit,
       apps.org_organization_definitions oodt
 WHERE     1 = 1
       AND oodt.organization_id = pllt.ship_to_organization_id
       AND msit.organization_id = pllt.ship_to_organization_id
       AND msit.segment1 NOT LIKE 'ZZZ%'
       AND msit.inventory_item_id = plt.item_id
       AND NVL (pht.cancel_flag, 'N') = 'N'
       AND NVL (plt.cancel_flag, 'N') = 'N'
       AND NVL (pllt.cancel_flag, 'N') = 'N'
       AND type_lookup_code = 'STANDARD'
       AND plt.po_header_id = pht.po_header_id
       AND pllt.po_header_id = pht.po_header_id
       AND pllt.po_line_id = plt.po_line_id
       AND NVL (pllt.closed_code, 'OPEN') = 'OPEN'
       AND match_option = 'R'
ORDER BY pht.creation_date;