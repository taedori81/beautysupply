/**
 * Created by taedori on 11/16/15.
 */
(function($){

	// Init Isotope
	var $sorting_grid = $('.sort-grid').isotope({
		itemSelector:'.product-item',
		layoutMode: 'fitRows',
		getSortData: {
			name: '.product-link',
			priceUp: function( itemElem ) {
				var price = $(itemElem).find('.price_color').text();
				price = price.replace(/\$/g, "");
				return parseFloat(price);
			},
			priceDown: function( itemElem ) {
				var price = $(itemElem).find('.price_color').text();
				price = price.replace(/\$/g, "");
				return parseFloat(price);
			},
			review: function ( itemElem ){
				var rating = $( itemElem ).find('.rating').text();
				if (rating == "None"){
					rating = 0.0;
					return rating;
				}
				else {
					return rating;
				}
			}
		},
		sortAscending: {
			name: true,
			priceUp: false,
			priceDown: true,
			review: false
		}
	});

	//Bind sort button click
	$('.sort-by-button-group').on('click', 'button', function() {
		var sortValue = $(this).attr('data-sort-value');
		$sorting_grid.isotope({ sortBy: sortValue });
	});


	// Product Filters
	var $filter_grid = $('.filter-grid').isotope({
		itemSelector: '.product-item',
		layoutMode: 'fitRows'
	});

	// Custom Filter Functions
	var filterFns = {
		priceLessThan10: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 10;

		},
		priceLessThan25: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 25;
		},
		priceLessThan50: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 50;
		},
		priceLessThan75: function(){
			var number = $(this).find('.price_color').text()
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 75;
		},
		priceLessThan100: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 100;
		},
		priceLessThan125: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 125;
		},
		priceLessThan150: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 150;
		},
		priceLessThan175: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 175;
		},
		priceLessThan200: function(){
			var number = $(this).find('.price_color').text();
			number = number.replace(/\$/g,"");
			return parseInt(number, 10) <= 200;
		},

	};
	// Bind filter button click
	$('.filters-length-button-group').on('click', 'a', function(){
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

	// Bind filter button click
	$('.filters-color-button-group').on('click', 'a', function(){
		var filterValue = $(this).attr('data-filter');
		// use filterFn if matches value
		filterValue = filterFns[ filterValue ] || filterValue;
		$filter_grid.isotope({filter:filterValue});
	});

	// change active class on buttons
	$('.color-group').each(function(i, buttonGroup){
		// buttonGroup == this..
		var $buttonGroup = $( buttonGroup );
		$buttonGroup.on('click', 'a', function(){
			$buttonGroup.find('.active').removeClass('active');
			$(this).addClass('active');
		});
	});

	// Bind filter button click
	$('.filters-price-button-group').on('click', 'a', function(){
		var filterValue = $(this).attr('data-filter');
		// use filterFn if matches value
		filterValue = filterFns[ filterValue ] || filterValue;
		//var result = filterValue();
		//alert(result);
		$filter_grid.isotope({filter:filterValue});
	});

	// change active class on buttons
	$('.price-group').each(function(i, buttonGroup){
		// buttonGroup == this..
		var $buttonGroup = $( buttonGroup );
		$buttonGroup.on('click', 'a', function(){
			$buttonGroup.find('.active').removeClass('active');
			$(this).addClass('active');
		});
	});


	$('#id_child_id').change(function(){
		var price = $('#id_child_id').find("option:selected").text();
		var startNumber = price.search(/\bP/i);
		var priceText = price.substring(startNumber);
		var pricePosition = priceText.search(/\d/);
		priceText = priceText.substring(pricePosition);
		$("#product-price").text("$" + priceText);

	});


})(jQuery);
