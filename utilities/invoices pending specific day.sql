select
	i.invoice_number,
	i.total_invoice,
	i.create_date,
	i.expire_date,
	is2.status_date,
	i2.invoice_status
from
	invoices i
left join invoices_status is2 on is2.id = i.history_id 
left join invoicesstatus i2 on i2.id = is2.invoice_status_id 
where
	i.id not in
(
	select
		i.id
	from
		invoices i
	left join invoices_status is2 on
		is2.id = i.history_id
	left join invoicesstatus i2 on
		i2.id = is2.invoice_status_id
	where
		i.id in
(
		select
			i.id
		from
			invoices i
		where
			DATE_FORMAT(i.create_date , "%Y-%m-%d") <= "2024-03-01"
		order by
			i.id desc)
		and is2.invoice_status_id = 3
		and DATE_FORMAT(is2.status_date, "%Y-%m-%d") <= "2024-03-01"
	order by i.id desc) and DATE_FORMAT(i.create_date , "%Y-%m-%d") <= "2024-03-01" 
	and i2.id not in (2,3)
		order by i.id asc;