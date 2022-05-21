<?
if(!empty($_GET['id']))
$pics = findAll("contents_pictures",null,'content_id = '.escape($_GET['id']),'contents_pictures.order');
?>
<script type="text/javascript" src="/js/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
    // When the document is ready set up our sortable with it's inherant function(s)
    $(document).ready(function() {
        $("#order-list").sortable({
            handle : '.handle',
            update : function () {
                var order = $('#order-list').sortable('serialize');
                $("#info").load("/kdpanel/contents/process-sortable.php?"+order);
            }
        });
    });
</script>
<div class="widget-top">
    <h3>Ordenar fotos</h3>
</div>
<div class="inside">
    <? if(empty($pics)){?><br/>No se encontraron im&aacute;genes para mostrar.<br/><br/><br/><? }else{?>
    <div class="p_b"><strong>Para ordenar solamente arrastre las im&aacute;genes desde el icono movimiento.</strong><br/><br/></div>
    <div id="info"></div>
    <ul id="order-list">
        <?
        if(!empty($pics)){
            foreach ($pics as $pic) {
            ?>
                <li id="listItem_<?=$pic['id']?>">
                    <img src="/img/ico-order.png" alt="move" width="16" height="16" class="handle" />
                    <img src="/img/paginas/thumbs/<?=$pic['src']?>" height="95" />
                </li>
           <? 
           }
        }
        ?>
    </ul><? }?>
    <br class="clear" />
</div>