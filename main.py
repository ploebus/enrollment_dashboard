import psycopg2
from bottle import route, run, template,post,request,response
conn = psycopg2.connect("dbname='CalWIN' user='postgres' host='localhost' password='postgres'")

@route('/')
def index():
	s = 'connected'
	try:
		cur = conn.cursor()
		cur.execute("""SELECT * FROM cntzip_0115 where mc > 0 order by mc desc """)
		data = cur.fetchall();
		return template('show_enrollment', rows=data)
	except:
		s = 'ERROR!'
		return '<h1>ERROR</h1>'
	
@post('/ZipCode')	
def getZipCode():
	lat = float(request.forms.get("lat"))
	lng = float(request.forms.get("lng"))
	#coords = lng + " " + lat
	
	selection = "SELECT zcta5ce10 FROM ala_tigerzips_2014 where ST_Within(ST_GeomFromText(\'POINT({lng} {lat})\',4326),geom)=true".format(lng=lng, lat=lat)
	try:
		cur=conn.cursor()
		cur1 = conn.cursor()
		try: 
			cur.execute(selection)
			cur1.execute(selection)
			s = "%s" % (cur.fetchone()[0],)
			nextSelection = "SELECT * from cntzip_0115 where zipcode='{zip}'".format(zip=s)
			cur1.execute(nextSelection)
			data = cur1.fetchone()
			p = '{"zipcode":%s,'%(data[0])
			p += '"ga":%s,'%(data[1])
			p += '"mc":%s,'%(data[2])
			p += '"cf":%s,'%(data[3])
			p += '"cw":%s}'%(data[4])
			response.set_header('content-type','application/json')
			return p
		except:
			return "database1 error"
		
	except:
		s="ERROR!"
		#return '<h1>ERROR</h1>'
		return selection
run(host='localhost', debug=True, reloader=True,port=8080)