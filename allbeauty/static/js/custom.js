/**
 * Created by taedori on 11/16/15.
 */
(function($){
    $(document).ready(function(){
        // Isotope filters
		//-----------------------------------------------
		//if ($('.isotope-container').length>0 || $('.masonry-grid').length>0 || $('.masonry-grid-fitrows').length>0 || $('.isotope-container-fitrows').length>0) {
		//	$(window).load(function() {
		//		$('.masonry-grid').isotope({
		//			itemSelector: '.masonry-grid-item',
		//			layoutMode: 'masonry'
		//		});
		//		$('.masonry-grid-fitrows').isotope({
		//			itemSelector: '.masonry-grid-item',
		//			layoutMode: 'fitRows'
		//		});
		//		$('.isotope-container').fadeIn();
		//		var $container = $('.isotope-container').isotope({
		//			itemSelector: '.isotope-item',
		//			layoutMode: 'masonry',
		//			transitionDuration: '0.6s',
		//			filter: "*"
		//		});
		//		$('.isotope-container-fitrows').fadeIn();
		//		var $container_fitrows = $('.isotope-container-fitrows').isotope({
		//			itemSelector: '.isotope-item',
		//			layoutMode: 'fitRows',
		//			transitionDuration: '0.6s',
		//			filter: "*"
		//		});
		//		// filter items on button click
		//		$('.filters').on( 'click', 'ul.nav li a', function() {
		//			var filterValue = $(this).attr('data-filter');
		//			$(".filters").find("li.active").removeClass("active");
		//			$(this).parent().addClass("active");
		//			$container.isotope({ filter: filterValue });
		//			$container_fitrows.isotope({ filter: filterValue });
		//			return false;
		//		});
		//	});
		//	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		//		$('.tab-pane .masonry-grid-fitrows').isotope({
		//			itemSelector: '.masonry-grid-item',
		//			layoutMode: 'fitRows'
		//		});
		//	});
		//}

	});

	// Product Filters
	var $filter_grid = $('.filter-grid').isotope({
		itemSelector: '.product-item',
		layoutMode: 'fitRows'
	});

	// Custom Filter Functions
	var filterFns = {

	};
	// Bind filter button click
	$('.filters-button-group').on('click', 'a', function(){
		var filterValue = $(this).attr('data-filter');
		// use filterFn if matches value
		filterValue = filterFns[ filterValue ] || filterValue;
		$filter_grid.isotope({filter:filterValue});
	});

	// change active class on buttons
	$('.length-group').each(function(i, buttonGroup){
		// buttonGroup == this..
		var $buttonGroup = $( buttonGroup );
		$buttonGroup.on('click', 'a', function(){
			$buttonGroup.find('.active').removeClass('active');
			$(this).addClass('active');
		});
	});
})(jQuery);