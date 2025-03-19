with top_vendedores as(
select 
date_format(o.fecha_order, '%Y-%m') as ano_mes,
c.customerId,
c.nombre,
c.apellido,
count(distinct o.orderId) as cantidad_ventas, -- quantidade de vendas finalizadas
sum(oi.cantidad) as suma_itens, -- quantidade de produtos
sum(oi.precioUn) total, -- total das ventas
row_number() over (partition by date_format(o.fechaorder, '%y-%m') order by sum(oi.precioUn) desc) as ranking
from challenge.customer c
join challenge.order o
	on c.customerId = o.sellerId -- seleção somente dos vendedores
join challenge.orderstatus os
	on o.orderId = os.orderoId
join challenge.orderitem oi
	on o.orderId = oi.orderId
join challenge.item i 
	on oi.itemId = i.itemId
join challenge.category ct
	on i.categoryId = ct.category_Id
where o.fechaOrder between '2020-01-01' and '2020-12-31' -- periodo de vendas
and ct.categoryDescription = 'Celulares'
and os.statusDescripcion <> 'Cancelado' -- Retornar apenas vendas concluidas
group by date_format(o.fechaorder, '%Y%m'),
c.customerId,
c.nombre,
c.apellido)

select 
ano_mes,
customerId,
nombre,
apellido,
cantidad_ventas,
suma_itens,
total,
ranking
from top_vendedores
where ranking < 6
order by ano_mes, ranking