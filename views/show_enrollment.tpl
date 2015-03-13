<!DOCTYPE html>
<html>
	<head>
		 <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" />
		 <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
	<title>Enrollment Counts by ZipCode</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	
		<style>
			
			
			
			#map{
				min-height:400px;
				height:100%;
			}
			#myTable{
				width:100%;
				font-size:smaller;
				text-align: center
			}
			
			
		
		</style>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>
	<script type="text/javascript" src="http://maps.stamen.com/js/tile.stamen.js?v1.3.0"></script>
	</head>
	<body>
		
	
	
	<div data-role='page' id="one">
		

		<div data-role='header'>
			Stuff here
		</div>
		<div data-role='main' class='ui-content ui-grid-a'>
			
			<div id='map' class="ui-bock a">
			</div>
			<script>





			
			
			var layer = new L.StamenTileLayer("toner-lite");		
			var marker;
			var map = new L.Map("map", {
			    center: new L.LatLng(37.804018, -122.255446),
			    zoom: 12
			});
			map.setView([37.804018, -122.255446],15)
			
			map.addLayer(layer)
			map.locate({setView:true, maxZoom:12})

			map.on('locationfound',onLocationFound)

			function onLocationFound(e){
				L.marker(e.latlng).addTo(map);
				console.log(e.latlng)
			}
			
			map.on('click',function(e){
				
				if(marker != null)
					{
						map.removeLayer(marker)			
					};

				marker = L.marker(e.latlng).addTo(map);
				
				//make a point where map was clicked
				//clear the table
				$("#detailTable tbody tr").remove();
				
				$.post("ZipCode", {"lat":e.latlng.lat,"lng":e.latlng.lng}, function(data){
					//add new rows
					$.each(data,function(k,v){
						$("#detailTable tbody").append("<tr><td>" + k + "</td><td>" + v + "</td></tr>")
					});

					//flip the page
					$.mobile.changePage("#two",{
						transition:"flip",
						role: "page",
						changeHash:false
					});


 					showSelect(data.ZipCode);
					console.log(data)
				})
			})
			</script>
		

			
		</div>
		<div data-role='footer'>
			<a href="#two">See List</a>	
		</div>
		
	</div>
	
<!-- 	Second page -->

	<div data-role='page' id="two">
		<div data-role='header' data-theme='b'>
			
		</div>
		
		<div data-role='main' class='ui-content'>
			<menu>
			<section id="selectStyle">
			<a href="#one" data-transition='flip'>By Location </a> | By Program Over Time
			</section>
			</menu>
			
			<table id="detailTable" data-role="table" data-mode="columntoggle" class="ui-body-d ui-shadow table-stripe">
					<thead>
						<tr class='ui-bar-d'>
							<th>What</th>
							<th>HOW</th>
						</tr>
					</thead>

					<tbody>


					</tbody>

				</table>


			<form>
				<fieldset>
					<label for="select-native-s">SELECT A ZIP CODE:</label>
					<select id="select-native-s" name='select-native-s'>
						%for row in rows:
							<option value="{{row[0]}}">{{row[0]}}</option>
						%end
					</select>
				</fieldset>
			</form>
			
				<table data-role="table" id="myTable" data-mode='reflow' class='ui-responsive'>
					<thead>
					<tr><th>ZipCode</th><th>GA</th><th>MC</th><th>CF</th><th>CW</th></tr>
					</thead>
					<tbody>
						%for row in rows:
							<tr class='resultTable'>
								%for col in row:
									<td>{{col}}</td>
								%end
							</tr>
						%end
					</tbody>
				</table>
			
		</div>
	
<script type="text/javascript">
		
		function showSelect(s){
			console.log(s)
			$('#myTable tbody tr').hide();
			$('#myTable td:contains(' + s + ')').parent('tr').show('fast');
		}
		$("select#select-native-s").change(function(){
			var selected = $(this).children(":selected").html();
			$('table tbody tr').hide();
			$('table td:contains(' + selected + ')').parent('tr').show('fast');
			
		})
	</script>	
	</div>
	
	</body>
</html>
