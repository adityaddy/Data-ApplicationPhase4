import subprocess as sp
import pymysql
import pymysql.cursors


def adduser():
    
    try:
        row = {}
        q1  = "SELECT * FROM `customer`"
        cur.execute(q1)
        cur.fetchall()
        rc = cur.rowcount
        row["cid"] = rc+1
        print("Enter new user details: ")
        name = (input("Name (Fname Minit Lname): ")).split(' ')
        row["fname"] = name[0]
        row["lname"] = name[1]
        row["fav_drink_name"] = input("fav_drink_name: )
        row["dob"] = input("Birth Date (YYYY-MM-DD): ")

        query = "INSERT INTO customer(cid,fname,lname,fav_drink_name,dob) VALUES('%d', '%s', '%s', '%s', '%s')" %(rc, row["fname"], row["lname"], row["fav_drink_name"], row["dob"])
        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print (">>>>>>>>>>>>>", e)

    return


def deleteuser():

    try:
        cid = input("Enter CID of Customer : ")
        query = "SELECT fname FROM customer WHERE cid=%d"
        cur.execute(query, (cid,))
        name = cur.fetchall()
        query = "DELETE FROM customer WHERE cid=%d"
        cur.execute(query, (cid,))
        con.commit()
        query = "INSERT INTO oldcustomer(cid) VALUES('%s')" %(name)
        cur.execute(query,)
        con.commit();

    except Exception as e:
        con.rollback()
        print("Failed to delete into database")
        print (">>>>>>>>>>>>>", e)



def callfunc(ch):
    """
    Function that maps helper functions to option entered
    """

    if(ch==1): 
        adduser()
    elif(ch==2):
        deleteuser()
    elif(ch==3):
        func3()
    elif(ch==4):
        func4()
    elif(ch==5):
        func5()
    else:
        print("Error: Invalid Option")





while(1):
    tmp = sp.call('clear',shell=True)
    username = input("Username: ")
    password = input("Password: ")

    try:
        con = pymysql.connect(host='localhost',
                user=username,
                password=password,
                db='COMPANY',
                cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear',shell=True)
        with con:
            cur = con.cursor()
            while(1):
                tmp = sp.call('clear',shell=True)
                print("1. function 1")
                print("2. function 2")
                print("3. function 3")
                print("4. function 4")
                print("5. function 5")
                print("6. Logout")
                ch = int(input("Enter Choice > "))
                tmp = sp.call('clear', shell=True)
                if ch==6:
                    break
                else:
                    callfunc(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except:
        tmp = sp.call('clear',shell=True)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")
