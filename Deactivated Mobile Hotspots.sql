SELECT SUBSTRING_INDEX(materials, ':', -1) AS 'Mobile Number',
       itemnotes_nonpublic AS 'Additional Information',
       Barcode,
       holdingbranch AS "Current Location",
       v.lib AS 'Status',
       CONCAT('<a class="btn btn-default btn-xs" style="display:block;margin-left: auto;margin-right: auto;width: 90%;" href="https://mb.verizonwireless.com/', SUBSTRING_INDEX(materials, ':', -1), '" target="_blank">', 'Deactivate', '</a>') AS 'Service Options',
       CONCAT('<a class="btn btn-default btn-xs" href="/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', i.biblionumber, '&itemnumber=', i.itemnumber, '#edititem" target="_blank">', 'Change Status', '</a>') AS 'Koha Options'
FROM biblio
LEFT JOIN items i USING (biblionumber)
LEFT JOIN issues USING (itemnumber)
LEFT JOIN borrowers USING (borrowernumber)
LEFT JOIN authorised_values v ON (i.notforloan=v.authorised_value)
LEFT JOIN accountlines a USING (itemnumber)
WHERE itype IN ('HOTSPOT')
  AND v.category='NOT_LOAN'
  AND notforloan='3'
  AND onloan IS NULL
GROUP BY itemnumber
ORDER BY datelastseen
