<div class="sub_visual sub_visual<%=Left(PAGE_NUM(PG_SEQ),2)%>">
	 <div class="container max-height">
			<div class="vc">
				 <div class="vm">
						<h2 class="huge-title"><%=SUB_HUGE_TITLE%></h2>
				 </div>
			</div>
   </div>
</div>

<div class="sub_menu">
   <div class="container">
      <div class="divide home">
         <div class="vc">
            <div class="vm">
               <a href="/" title="home">home</a>
            </div>
         </div>
      </div>
      <div class="divide">
         <a href="#" class="big">
            <div class="vc">
               <div class="vm">
                  <span><%=SUB_HUGE_TITLE%></span>
               </div>
            </div>
         </a>
         <ul class="big_tab_menu stab_menu">
            <%=BIG_TAB_MENU%>
         </ul>
      </div>
      <div class="divide">
         <a href="#" class="sub">
            <div class="vc">
               <div class="vm">
                  <span><%=SUB_BIG_TITLE%></span>
               </div>
            </div>
         </a>
         <ul class="sub_tab_menu stab_menu">
            <%=SUB_TAB_MENU%>
         </ul>
      </div>
   </div>
</div>

<script type="text/javascript">
$(function(){
   $(".sub_menu .divide").on("mouseenter",function(){
      $(this).addClass("over");
      $(this).find(".stab_menu").stop().slideDown();
   }).on("mouseleave",function(){
      $(this).removeClass("over");
      $(this).find(".stab_menu").stop().slideUp();
   });
});
</script>