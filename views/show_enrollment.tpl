<!DOCTYPE html>
<html>
	<head>
		 <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" />
		 <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
	<title>Enrollment Counts by ZipCode</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">	
		<style>
			#myTable{
				width:100%;
				font-size:smaller;
				text-align: center
			}
			#map {
				width:500px;
				height:500px;

			}
		</style>
	</head>
	<body>
		
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	 <script src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>
	<script type="text/javascript" src="http://maps.stamen.com/js/tile.stamen.js?v1.3.0"></script>
	
	<div data-role='page' id="mapPage">
		

		<div data-role='header' data-theme='b'>
			January 2015 Enrollment map
		</div>
		<div data-role='main' class='ui-content'>
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
			<div id='map'></div>
			<script>

			var layer = new L.StamenTileLayer("toner-lite");		
			
			var map = new L.Map("map", {
			    center: new L.LatLng(37.804018, -122.255446),
			    zoom: 12
			});
			
			map.addLayer(layer)

			</script>
		</div>
		
	</div>
	
<!-- 	Second page -->

	<div data-role='page'>
		<div data-role='header' data-theme='b'>
			January 2015 Enrollment Counts by Zip Code
		</div>
		
		<div data-role='main' class='ui-content'>
			<menu>
			<section id="selectStyle">
			By Location | By Program Over Time
			</section>
			</menu>
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
	</div>
<script type="text/javascript">
		
		
		$("select#myList").change(function(){
			var selected = $(this).children(":selected").html();
			$('table tbody tr').hide();
			$('table td:contains(' + selected + ')').parent('tr').show('fast');
			
		})
	</script>	

	</body>
</html>
