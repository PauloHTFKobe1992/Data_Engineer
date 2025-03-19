delimiter $$

drop procedure if exists update_item_data;
create procedure update_item_data ()

begin
inser into challeng.item(itemId, precio, estado, fechaUpdt)
select 
	i.itemId,
    i.precio,
    i.estado,
    current_timestamp() as fechaUpdt
    from challeng.item i
on duplicate key update
	precio = i.precio,
    estado = i.estado;
    
end.
$$

delimiter ;

create trigger update_item_audt
before delete on item 
for each row
insert into itemAudit
set action = 'update',
orderId = old.orderId,
precio = old.precio,
estado = old.estado,
cambiofecha = now();

create trigger del_item_audt
before delete on item 
for each row
insert into itemAudit
set action = 'delete',
orderId = old.orderId,
precio = old.precio,
estado = old.estado,
cambiofecha = now();
