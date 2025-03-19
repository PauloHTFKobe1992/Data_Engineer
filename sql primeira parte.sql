select 
c.customerId,
c.email, 
c.nombre,
c.apellido,
c.fechaNacimiento,
count(o.orderId) as Cantidad
from 
challenge.customer c
join challenge.order o
	on c.customerId = o.sellerId -- usado para listar os vendedores
join challenge.orderstatus os
	on o.orderId = os.orderId
where c.fechaNacimiento = cast(current_date()as date)
and o.fechaOrder between '2020-01-01' and '2020-01-31'
and os.statusDescription <> 'Cancelado' -- para retornar apenas vendas finalizadas
group by
c.customerId,
c.email,
c.nombre,
c.apelido,
c.sexo,
c.direccion,
c.fechaNacimiento
having count(o.orderId) > 1500; -- operações maiores que 1500
