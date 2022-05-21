<?php
if (!empty($sliders)) {
    ?>
    <div id="myCarousel" class="carousel slide" data-ride="carousel" data-pause="hover">
        <? if (!empty($sliders) && count($sliders) > 1) { ?>
            <ol class="carousel-indicators">
                <? for ($i = 0; $i < count($sliders); $i++) { ?>
                    <li data-target="#myCarousel" data-slide-to="<?= $i ?>"<?= ($i == 0) ? ' class="active"' : false ?>></li>
                <? } ?>
            </ol>
        <? } ?>
        <div class="carousel-inner" role="listbox">
            <?
            foreach ($sliders as $key => $slider) {
                ?>
                <div class="item<?= ($key == 0) ? ' active' : false ?>">
                    <? if (!empty($slider['url'])) {?><a href="<?= $slider['url'] ?>"><? }?>
                       
                        <picture>
                            <? if(file_exists(WWW_ROOT."/img/sliders/". $slider['id'] ."_small.jpg")){?>
  <source media="(max-width:450px)" srcset="/img/sliders/<?= $slider['id'] ?>_small.jpg"><? }?>
  <img src="/img/sliders/<?= $slider['id'] ?>.jpg" alt="<?= $slider['title'] ?>">
</picture>
                        
                    <? if (!empty($slider['url'])) {?></a>
                        <? }    
                    if(!empty($slider['title']) && !empty($slider['description'])){
                    ?>
                         <div class="carousel-caption d-none d-md-block">
                            <h2><?=$slider['title']?></h2>
                            <p><?=$slider['description']?></p>
                          </div>
                    <? }?>
                </div>
                <?
            }
            ?>
        </div>
        <? if (!empty($sliders) && count($sliders) > 1) { ?>
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Anterior</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Siguiente</span>
            </a>
        <? } ?>
    </div>
<? } ?>