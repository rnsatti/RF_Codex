import cx_Oracle
 
try:
    con = cx_Oracle.connect('QMS_Admin/Qms_Admin$$0102@172.24.247.123:1521/TDMDB')
    print('TDM Server Successfully Connected')
 
except cx_Oracle.DatabaseError as er:
    print('There is an error in the Oracle database:', er)
 
else:
    try:
        cur = con.cursor()
 
        # fetchall() is used to fetch all records from result set
        cur.execute("select count(*) from Selfcare_TDMReservation_Table where JIRA_ID = 'QAD-49677' ")
        rows = cur.fetchall()
        print(rows)
 
 
    except cx_Oracle.DatabaseError as er:
        print('There is an error in the Oracle database:', er)
 
    except Exception as er:
        print('Error:'+str(er))
 
    finally:
        if cur:
            cur.close()
 
finally:
    if con:
        con.close()