import psycopg2
from bottle import route, run, template

@route('/')
def index():
	s = 'connected'
	try:
		conn = psycopg2.connect("dbname='CalWIN' user='postgres' host='localhost' password='postgres'")
		cur = conn.cursor()
		cur.execute("""SELECT * FROM cntzip_0115 where mc > 0 order by mc desc """)
		data = cur.fetchall();
		return template('show_enrollment', rows=data)
	except:
		s = 'ERROR!'
		return '<h1>ERROR</h1>'
	
	

run(host='localhost', port=8080)