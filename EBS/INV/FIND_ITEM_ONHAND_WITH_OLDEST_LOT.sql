SELECT organization_code,
       item_number,
       MIN (creation_date) lot_creation_date,
       MAX (moqt_creation_date) max_onhand_date
  FROM (SELECT organization_code,
               msit.segment1 item_number,
               msit.description,
               inventory_item_status_code item_status,
               moqt.subinventory_code,
               concatenated_segments locator_number,
               primary_transaction_quantity pri_trx_qty,
               moqt.lot_number,
               orig_date_received,
               transaction_uom_code trx_uom,
               transaction_quantity tx_qty,
               mln.creation_date,
               mln.expiration_date,
               mln.origination_date,
               moqt.creation_date moqt_creation_date
          FROM apps.mtl_onhand_quantities_detail moqt,
               apps.mtl_system_items_b msit,
               apps.mtl_item_locations_kfv milt,
               mtl_lot_numbers mln,
               apps.org_organization_definitions oodt
         WHERE     1 = 1
               AND mln.organization_id = msit.organization_id
               AND mln.inventory_item_id = msit.inventory_item_id
               AND mln.lot_number = moqt.lot_number
               AND moqt.inventory_item_id = msit.inventory_item_id
               AND moqt.organization_id = msit.organization_id
               AND moqt.organization_id = oodt.organization_id
               AND oodt.organization_code =
                      NVL ( :org_code, oodt.organization_code)
               AND milt.inventory_location_id = moqt.locator_id
               AND moqt.subinventory_code NOT IN ('IF ANY')
               AND expiration_date IS NULL
               AND mln.lot_number NOT IN ('IF ANY')
               AND inventory_item_status_code = 'Active')
GROUP BY item_number, organization_code
ORDER BY 1, 2, 3;