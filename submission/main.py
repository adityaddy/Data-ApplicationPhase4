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
        #delete from customer table
        query = "DELETE FROM customer WHERE cid=%d"
        cur.execute(query, (cid,))
        con.commit()
        #delete from from custguard
        query = "DELETE FROM custguard WHERE cid=%d"
        cur.execute(query, (cid,))
        con.commit()

        #delete from from drinktrans
        query = "DELETE FROM drinktrans WHERE cid=%d"
        cur.execute(query, (cid,))
        con.commit()

        #delete from from lovestogoto
        query = "DELETE FROM lovestogoto WHERE cid=%d"
        cur.execute(query, (cid,))
        con.commit()

        #adding in old customer
        query = "INSERT INTO oldcustomer(cid) VALUES('%s')" %(name)
        cur.execute(query)
        con.commit()


    except Exception as e:
        con.rollback()
        print("Failed to delete from database")
        print (">>>>>>>>>>>>>", e)

    return



def modifycustomer():
    try:
        cid = input("Enter the Customer ID : ")
        field = input("Enter the Attribute to modify : ")
        if field=="cid":
            print("Can't Change cid : It is Primary Key")
            return
        value = input("Enter the Attribute Value")
        data = (field, value,cid)
        query = "UPDATE customer SET %s=%s WHERE cid=%d"
        cur.execute(query,data)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to Update")
        print (">>>>>>>>>>>>>", e)

    return


def modifybar():
    try:
        bid = input("Enter the Bar ID : ")
        field = input("Enter the Attribute to modify : ")
        if field=="bid":
            print("Can't Change bar id : It is Primary Key")
            return
        value = input("Enter the Attribute Value")
        data = (field, value,bid)
        query = "UPDATE bar SET %s=%s WHERE cid=%d"
        cur.execute(query,data)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to Update")
        print (">>>>>>>>>>>>>", e)

    return

def modifyBarManager():
    try:
        bid = input("Enter the Bar ID : ")
        field = input("Enter the Attribute to modify : ")
        if field=="bid":
            print("Can't Change bar id : It is Primary Key")
            return
        if field=="name":
            print("Can't Change name : It is Primary Key")
            return
        value = input("Enter the Attribute Value")
        data = (field, value,bid)
        query = "UPDATE bar_manager SET %s=%s WHERE cid=%d"
        cur.execute(query,data)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to Update")
        print (">>>>>>>>>>>>>", e)

    return



def cust_report():
    query = "SELECT * FROM customer"
    cur.execute(query,data)
    data = cur.fetchall()
    print(data)

def bar_report():
    query = "SELECT * FROM bar"
    cur.execute(query,data)
    data = cur.fetchall()
    print(data)

def old_cust_report():
    query = "SELECT * FROM old_customer"
    cur.execute(query,data)
    data = cur.fetchall()
    print(data)




def callfunc(ch):
    """
    Function that maps helper functions to option entered
    """

    if(ch==1): 
        adduser()
    elif(ch==2):
        deleteuser()
    elif(ch==3):
        modifycustomer()
    elif(ch==4):
        modifybar()
    elif(ch==5):
        modifyBarManager()
    elif(ch==6):
        cust_report()
    elif(ch==7):
        bar_report()
    elif(ch==8):
        old_cust_report()

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
                print("1. Add Customer")
                print("2. Delete Customer")
                print("3. Modify Customer")
                print("4. Modify Bar")
                print("5. Modify Bar Manager")
                print("6. Customer Report")
                print("7. Bar Report")
                print("8. Old Customer Report")
                print("9. Logout")
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
